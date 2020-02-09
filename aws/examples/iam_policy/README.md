# Work with AWS IAM for policy using via terraform
=======================

A terraform module for making IAM policy.

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

module "iam_policy" {
    source                                  = "../../modules/iam_policy"
    name                                    = "TEST-iam-policy"
    environment                             = "PROD"

    # Using IAM policy
    enable_iam_policy                       = true
    iam_policy_name                         = "test-policy"
    iam_policy_path                         = "/"
    iam_policy_policy                       = file("additional_files/policy.json")

    # Using IAM policy attachment 
    enable_iam_policy_attachment            = true
    iam_policy_attachment_name              = ""
    
    #iam_role_policy_attachment_roles        = null
    #iam_policy_attachment_users             = null
    iam_policy_attachment_groups            = ["admins"]
    
    iam_role_policy_attachment_policy_arn   = ""
} 
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_iam_policy` - Enable IAM policy usage/creation (`default     = false`).
- `iam_policy_path` - (Optional, default '/') Path in which to create the policy. See IAM Identifiers for more information. (`default     = "/"`).
- `iam_policy_policy` - (Required) The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide (`default     = ""`).
- `iam_policy_name` - Set custom policy name (`default     = ""`).
- `iam_policy_name_prefix` - Enable IAM policy with name_prefix usage (`default     = false`).
- `iam_policy_description` - (Optional, Forces new resource) Description of the IAM policy. (`default       = ""`).
- `enable_iam_policy_attachment` - Enabling IAM policy attachment (`default     = false`).
- `iam_policy_attachment_name` - Set custom iam policy attachment name (`default     = ""`).
- `iam_role_policy_attachment_roles` - (Optional) - The role(s) the policy should be applied to (`default       = []`).
- `iam_policy_attachment_users` - (Optional) - The user(s) the policy should be applied to (`default       = []`).
- `iam_policy_attachment_groups` - (Optional) - The group(s) the policy should be applied to (`default       = []`).
- `iam_role_policy_attachment_policy_arn` - The ARN of the policy you want to apply (`default       = ""`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
