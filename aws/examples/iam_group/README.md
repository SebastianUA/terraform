# Work with AWS IAM for group using via terraform
=======================

A terraform module for making IAM group.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "iam_group" {
    source                                  = "../../modules/iam_group"
    name                                    = "TEST-iam-group"
    environment                             = "PROD"

    # Using IAM group
    enable_iam_group                        = true
    iam_group_name                          = ""
    iam_group_path                          = "/"

    # Using IAM group policy
    enable_iam_group_policy                 = true
    iam_group_policy_name                   = "test-policy"
    iam_group_policy                        = file("additional_files/policy.json")

    # Using IAM group policy attachment
    #enable_iam_group_policy_attachment      = true
    #iam_group_policy_attachment_policy_arn  = ""

    # Using IAM group membership
    enable_iam_group_membership             = true
    iam_group_membership_name               = ""
    iam_group_membership_users              = []
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_iam_group` - Enable IAM group usage (`default       = false`).
- `iam_group_name` - The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. Group names are not distinguished by case. For example, you cannot create groups named both 'ADMINS' and (`default       = ""`).
- `iam_group_path` - (Optional, default '/') Path in which to create the group. (`default       = "/"`).
- `enable_iam_group_policy` - Enable IAM group policy usage (`default       = false`).
- `iam_group_policy_name` - (Optional) The name of the policy. If omitted, Terraform will assign a random, unique name. (`default       = ""`).
- `iam_group_policy_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with iam_group_policy_name. (`default       = ""`).
- `iam_group_policy_group` - The IAM group to attach to the policy. (`default       = ""`).
- `iam_group_policy` - (Required) The policy document. This is a JSON formatted string. For more information about building IAM policy documents with Terraform, see the AWS IAM Policy Document Guide (`default       = ""`).
- `enable_iam_group_policy_attachment` - Enable IAM group policy attachment usage (`default       = false`).
- `iam_group_policy_attachment_policy_arn`- (Required) - The ARN of the policy you want to apply (`default     = ""`).
- `enable_iam_group_membership` - Enable IAM group membership usage (`default       = false`).
- `iam_group_membership_name` - The name to identify the Group Membership (`default       = ""`).
- `iam_group_membership_users` - (Required) A list of IAM User names to associate with the Group (`default       = []`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
