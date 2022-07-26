# Work with ORGANIZATIONS via terraform

A terraform module for making ORGANIZATIONS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

data "aws_organizations_organization" "current" {}

data "aws_organizations_organizational_units" "ou" {
  parent_id = data.aws_organizations_organization.current.roots[0].id
}

module "org" {
  source      = "../../modules/organizations"
  name        = "TEST"
  environment = "stage"

  # AWS Org 
  enable_organizations_organization                        = false
  organizations_organization_aws_service_access_principals = ["ALL"]
  organizations_organization_enabled_policy_types          = ["SERVICE_CONTROL_POLICY", "BACKUP_POLICY", "TAG_POLICY"]
  organizations_organization_feature_set                   = "ALL"

  # AWS Org policy
  enable_organizations_policy      = false
  organizations_policy_name        = ""
  organizations_policy_content     = file("additional_files/org_policy_content.json")
  organizations_policy_description = "Allow ALL"
  organizations_policy_type        = "SERVICE_CONTROL_POLICY"

  # AWS Org policy attachment
  enable_organizations_policy_attachment    = false
  organizations_policy_attachment_policy_id = ""
  organizations_policy_attachment_target_id = ""

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = []
}

module "org_unit" {
  source      = "../../modules/organizations"
  name        = "TEST"
  environment = "stage"

  # AWS Org unit
  enable_organizations_organizational_unit    = true
  organizations_organizational_unit_name      = ""
  organizations_organizational_unit_parent_id = data.aws_organizations_organization.current.roots[0].id # data.aws_organizations_organizational_units.ou.id

  # AWS Org policy
  enable_organizations_policy      = true
  organizations_policy_name        = ""
  organizations_policy_content     = file("additional_files/org_policy_content.json")
  organizations_policy_description = "Allow ALL"
  organizations_policy_type        = "SERVICE_CONTROL_POLICY"

  # AWS Org policy attachment
  enable_organizations_policy_attachment    = false
  organizations_policy_attachment_policy_id = ""
  organizations_policy_attachment_target_id = ""

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    data.aws_organizations_organizational_units.ou,
    module.org
  ]
}

module "org_account" {
  source      = "../../modules/organizations"
  name        = "TEST"
  environment = "stage"

  # AWS Org account
  enable_organizations_account    = true
  organizations_account_name      = ""
  organizations_account_parent_id = module.org_unit.organizations_organizational_unit_id
  organizations_account_email     = "solo.metal@bigmir.net"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.org_unit
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_organizations_account` - Enable organizations account usage (`default = False`)
- `organizations_account_name` - A friendly name for the member account. (`default = ""`)
- `organizations_account_email` - (Required) The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account. (`default = null`)
- `organizations_account_iam_user_access_to_billing` - (Optional) If set to ALLOW, the new account enables IAM users to access account billing information if they have the required permissions. If set to DENY, then only the root user of the new account can access account billing information. (`default = null`)
- `organizations_account_parent_id` - (Optional) Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection. (`default = null`)
- `organizations_account_role_name` - (Optional) The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. The Organizations API provides no method for reading this information after account creation, so Terraform cannot perform drift detection on its value and will always show a difference for a configured value after import unless ignore_changes is used. (`default = null`)
- `enable_organizations_organization` - Enable organizations organization usage (`default = False`)
- `organizations_organization_aws_service_access_principals` - (Optional) List of AWS service principal names for which you want to enable integration with your organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must have feature_set set to ALL. For additional information, see the AWS Organizations User Guide. (`default = ['ALL']`)
- `organizations_organization_enabled_policy_types` - (Optional) List of Organizations policy types to enable in the Organization Root. Organization must have feature_set set to ALL. For additional information about valid policy types (e.g. BACKUP_POLICY, SERVICE_CONTROL_POLICY, and TAG_POLICY), see the AWS Organizations API Reference. (`default = ['SERVICE_CONTROL_POLICY', 'BACKUP_POLICY', 'TAG_POLICY']`)
- `organizations_organization_feature_set` - (Optional) Specify 'ALL' (default) or 'CONSOLIDATED_BILLING'. (`default = ALL`)
- `enable_organizations_organizational_unit` - Enable organizations organizational unit usage (`default = False`)
- `organizations_organizational_unit_name` - The name for the organizational unit (`default = ""`)
- `organizations_organizational_unit_parent_id` - ID of the parent organizational unit, which may be the root (`default = ""`)
- `enable_organizations_policy` - Enable organizations policy usage (`default = False`)
- `organizations_policy_name` - The friendly name to assign to the policy. (`default = ""`)
- `organizations_policy_content` - (Required) The policy content to add to the new policy. For example, if you create a service control policy (SCP), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the Service Control Policy Syntax documentation and for more information on the Tag Policy syntax, see the Tag Policy Syntax documentation. (`default = null`)
- `organizations_policy_description` - (Optional) A description to assign to the policy. (`default = null`)
- `organizations_policy_type` - (Optional) The type of policy to create. Valid values are AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), and TAG_POLICY. Defaults to SERVICE_CONTROL_POLICY. (`default = SERVICE_CONTROL_POLICY`)
- `enable_organizations_policy_attachment` - Enable organizations policy attachment (`default = False`)
- `organizations_policy_attachment_policy_id` - (Required) The unique identifier (ID) of the policy that you want to attach to the target. (`default = ""`)
- `organizations_policy_attachment_target_id` - (Required) The unique identifier (ID) of the root, organizational unit, or account number that you want to attach the policy to. (`default = ""`)

## Module Output Variables
----------------------
- `organizations_account_arn` - The ARN for this account.
- `organizations_account_id` - The AWS account id
- `organizations_organization_arn` - ARN of the organization
- `organizations_organization_id` - Identifier of the organization
- `organizations_organization_master_account_arn` - ARN of the master account
- `organizations_organization_master_account_id` - Identifier of the master account
- `organizations_organization_master_account_email` - Email address of the master account
- `organizations_organizational_unit_accounts` - List of child accounts for this Organizational Unit. Does not return account information for child Organizational Units.
- `organizations_organizational_unit_arn` - ARN of the organizational unit
- `organizations_organizational_unit_id` - Identifier of the organization unit
- `organizations_policy_arn` - Amazon Resource Name (ARN) of the policy.
- `organizations_policy_id` - The unique identifier (ID) of the policy.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
