# Work with IAM_GROUP via terraform

A terraform module for making IAM_GROUP.


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
  region  = "us-east-1"
  profile = "default"
}

module "iam_group" {
  source      = "../../modules/iam_group"
  name        = "TEST"
  environment = "stage"

  # Using IAM group
  enable_iam_group = true
  iam_group_name   = ""
  iam_group_path   = "/"

  # Using IAM group policy
  enable_iam_group_policy = true
  iam_group_policy_name   = "test-policy"
  iam_group_policy        = file("additional_files/policy.json")

  # Using IAM group policy attachment
  enable_iam_group_policy_attachment = true
  iam_group_policy_attachment_policy_arns = [
    "iam_group_policy_attachment_policy_arn1",
    "iam_group_policy_attachment_policy_arn2"
  ]

  # Using IAM group membership
  enable_iam_group_membership = true
  iam_group_membership_name   = ""
  iam_group_membership_users  = []
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_iam_group` - Enable IAM group usage (`default = False`)
- `iam_group_name` - The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. Group names are not distinguished by case. For example, you cannot create groups named both 'ADMINS' and (`default = ""`)
- `iam_group_path` - (Optional, default '/') Path in which to create the group. (`default = /`)
- `enable_iam_group_policy` - Enable IAM group policy usage (`default = False`)
- `iam_group_policy_name` - (Optional) The name of the policy. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `iam_group_policy_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with iam_group_policy_name. (`default = ""`)
- `iam_group_policy_group` - The IAM group to attach to the policy. (`default = ""`)
- `iam_group_policy` - (Required) The policy document. This is a JSON formatted string. For more information about building IAM policy documents with Terraform, see the AWS IAM Policy Document Guide (`default = ""`)
- `enable_iam_group_policy_attachment` - Enable IAM group policy attachment usage (`default = False`)
- `iam_group_policy_attachment_policy_arns` - (Required) - The ARNs of the policy you want to apply (`default = []`)
- `iam_group_policy_attachment_group` - Set group for policy attachment (`default = ""`)
- `enable_iam_group_membership` - Enable IAM group membership usage (`default = False`)
- `iam_group_membership_name` - The name to identify the Group Membership (`default = ""`)
- `iam_group_membership_users` - (Required) A list of IAM User names to associate with the Group (`default = []`)
- `iam_group_membership_group` - Set membership group (`default = ""`)

## Module Output Variables
----------------------
- `iam_group_arn` - The ARN assigned by AWS for this group.
- `iam_group_id` - The group's ID.
- `iam_group_name` - The group's name.
- `iam_group_path` - The path of the group in IAM.
- `iam_group_unique_id` - The unique ID assigned by AWS.
- `iam_group_policy_id` - The group policy ID.
- `iam_group_policy_group` - The group to which this policy applies.
- `iam_group_policy_name` - The name of the policy.
- `iam_group_policy_policy` - The policy document attached to the group.
- `iam_group_policy_attachment_group` - (Required) - The group the policy should be applied to
- `iam_group_policy_attachment_policy_arn` - (Required) - The ARN of the policy you want to apply
- `iam_group_membership_name` - The name to identify the Group Membership
- `iam_group_membership_users` - list of IAM User names
- `iam_group_membership_group` - IAM Group name


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
