# Work with SSOADMIN via terraform

A terraform module for making SSOADMIN.


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

data "aws_ssoadmin_instances" "ssoadmin" {}

data "aws_ssoadmin_permission_set" "ssoadmin" {
  instance_arn = tolist(data.aws_ssoadmin_instances.ssoadmin.arns)[0]
  name         = "AWSReadOnlyAccess"
}

data "aws_identitystore_group" "ssoadmin" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmin.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "ssoadminGroup"
  }
}

data "aws_iam_policy_document" "ssoadmin" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

module "ssoadmin" {
  source      = "../../modules/ssoadmin"
  name        = "TEST"
  environment = "stage"

  # SSO admin account assignment
  enable_ssoadmin_account_assignment = true

  ssoadmin_account_assignment_instance_arn       = data.aws_ssoadmin_permission_set.ssoadmin.instance_arn
  ssoadmin_account_assignment_permission_set_arn = data.aws_ssoadmin_permission_set.ssoadmin.arn

  ssoadmin_account_assignment_principal_id   = data.aws_identitystore_group.ssoadmin.group_id
  ssoadmin_account_assignment_principal_type = "GROUP"

  ssoadmin_account_assignment_target_id   = "012347678910"
  ssoadmin_account_assignment_target_type = "AWS_ACCOUNT"

  # SSO admin permission set
  enable_ssoadmin_permission_set           = true
  ssoadmin_permission_set_name             = ""
  ssoadmin_permission_set_description      = "An ssoadmin"
  ssoadmin_permission_set_instance_arn     = tolist(data.aws_ssoadmin_instances.ssoadmin.arns)[0]
  ssoadmin_permission_set_relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  ssoadmin_permission_set_session_duration = "PT2H"

  # SSO admin managed policy attachment
  enable_ssoadmin_managed_policy_attachment              = true
  ssoadmin_managed_policy_attachment_managed_policy_arns = ["arn:aws:iam::aws:policy/AlexaForBusinessDeviceSetup"]

  # SSO admin permission set inline policy
  enable_ssoadmin_permission_set_inline_policy          = true
  ssoadmin_permission_set_inline_policy_inline_policies = [data.aws_iam_policy_document.ssoadmin.json]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Set name prefix for some resources (`default = ssoadmin`)
- `environment` - Set Env for stack (`default = dev`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_ssoadmin_account_assignment` - Enable ssoadmin account assignment usage (`default = False`)
- `ssoadmin_account_assignment_instance_arn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of the SSO Instance. (`default = null`)
- `ssoadmin_account_assignment_permission_set_arn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of the Permission Set that the admin wants to grant the principal access to. (`default = null`)
- `ssoadmin_account_assignment_principal_id` - (Required, Forces new resource) An identifier for an object in SSO, such as a user or group. PrincipalIds are GUIDs (For example, f81d4fae-7dec-11d0-a765-00a0c91e6bf6). (`default = null`)
- `ssoadmin_account_assignment_principal_type` - (Required, Forces new resource) The entity type for which the assignment will be created. Valid values: USER, GROUP. (`default = null`)
- `ssoadmin_account_assignment_target_id` - (Required, Forces new resource) An AWS account identifier, typically a 10-12 digit string. (`default = null`)
- `ssoadmin_account_assignment_target_type` - (Optional, Forces new resource) The entity type for which the assignment will be created. Valid values: AWS_ACCOUNT. (`default = null`)
- `enable_ssoadmin_managed_policy_attachment` - Enable ssoadmin managed policy attachment usage (`default = False`)
- `ssoadmin_managed_policy_attachment_instance_arn` - The Amazon Resource Name (ARN) of the SSO Instance under which the operation will be executed. (`default = ""`)
- `ssoadmin_managed_policy_attachment_managed_policy_arns` - (Required, Forces new resource) The IAM managed policy list of Amazon Resource Name (ARN) to be attached to the Permission Set. (`default = []`)
- `ssoadmin_managed_policy_attachment_permission_set_arn` - The Amazon Resource Name (ARN) of the Permission Set. (`default = ""`)
- `enable_ssoadmin_permission_set` - Enable ssoadmin permission set usage (`default = False`)
- `ssoadmin_permission_set_name` - The name of the Permission Set. (`default = ""`)
- `ssoadmin_permission_set_instance_arn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of the SSO Instance under which the operation will be executed. (`default = null`)
- `ssoadmin_permission_set_description` - (Optional) The description of the Permission Set. (`default = null`)
- `ssoadmin_permission_set_relay_state` - (Optional) The relay state URL used to redirect users within the application during the federation authentication process. (`default = null`)
- `ssoadmin_permission_set_session_duration` - (Optional) The length of time that the application user sessions are valid in the ISO-8601 standard. Default: PT1H. (`default = null`)
- `enable_ssoadmin_permission_set_inline_policy` - Enable ssoadmin permission set inline policy usage (`default = False`)
- `ssoadmin_permission_set_inline_policy_inline_policies` - (Required) The IAM inline policy list to attach to a Permission Set. (`default = []`)
- `ssoadmin_permission_set_inline_policy_instance_arn` - The Amazon Resource Name (ARN) of the SSO Instance under which the operation will be executed. (`default = ""`)
- `ssoadmin_permission_set_inline_policy_permission_set_arn` - The Amazon Resource Name (ARN) of the Permission Set. (`default = ""`)

## Module Output Variables
----------------------
- `ssoadmin_account_assignment_id` - The identifier of the Account Assignment i.e. principal_id, principal_type, target_id, target_type, permission_set_arn, instance_arn separated by commas (,).
- `ssoadmin_managed_policy_attachment_id` - The Amazon Resource Names (ARNs) of the Managed Policy, Permission Set, and SSO Instance, separated by a comma (,).
- `ssoadmin_managed_policy_attachment_managed_policy_name` - The name of the IAM Managed Policy.
- `ssoadmin_permission_set_id` - The Amazon Resource Names (ARNs) of the Permission Set and SSO Instance, separated by a comma (,).
- `ssoadmin_permission_set_arn` - The Amazon Resource Name (ARN) of the Permission Set.
- `ssoadmin_permission_set_created_date` - The date the Permission Set was created in RFC3339 format.
- `ssoadmin_permission_set_inline_policy_id` - The Amazon Resource Names (ARNs) of the Permission Set and SSO Instance, separated by a comma (,).


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
