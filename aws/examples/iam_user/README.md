# Work with AWS IAM for user using via terraform
=======================

A terraform module for making IAM user.

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

module "iam_user" {
    source                                          = "../../modules/iam_user"
    name                                            = "TEST-user"
    environment                                     = "PROD"

    # Using IAM user
    enable_iam_user                                 = true
    iam_user_name                                   = ""
    iam_user_path                                   = "/"
    force_destroy                                   = true

    # Using user SSH key
    enable_iam_user_ssh_key                         = true
    iam_user_ssh_key_encoding                       = "SSH"
    iam_user_ssh_key_public_key                     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 mytest@mydomain.com"
    iam_user_ssh_key_status                         = "Active"

    # Using IAM user policy
    enable_iam_user_policy                          = true
    iam_user_policy_name                            = "my-test-policy"
    iam_user_policy_policy                          = file("additional_files/policy.json")

    # Using IAM user policy attachment
    enable_iam_user_policy_attachment               = false
    iam_user_policy_attachment_policy_arn           = ""
    
    # Using IAM user membership
    enable_iam_user_group_membership                = true
    iam_user_group_membership_groups                = ["admins"]

    # Using IAM user login profile
    enable_iam_user_login_profile                   = true
    iam_user_login_profile_pgp_key                  = "keybase:captain"
    iam_user_login_profile_password_length          = 20
    iam_user_login_profile_password_reset_required  = true
    
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `tags` - A list of tag blocks. Each element should have keys (`default     = {}`).
- `enable_iam_user` - Enable iam_user usage (`default     = false`). 
- `iam_user_name` - (Required) The user's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. User names are not distinguished by case. For example, you cannot create users named both 'TESTUSER' and 'testuser'. (`default     = ""`).
- `iam_user_path` - (Optional, default '/') Path in which to create the user. (`default     = "/"`).
- `permissions_boundary` - (Optional) The ARN of the policy that is used to set the permissions boundary for the user. (`default     = null`).
- `force_destroy` - (Optional, default false) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. (`default     = false`).
- `enable_iam_user_policy` - Enable iam user policy usage (`default     = false`).
- `iam_user_policy_name` - (Optional) The name of the policy. If omitted, Terraform will assign a random, unique name. (`default     = ""`).
- `iam_user_policy_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name. (`default     = ""`).
- `iam_user_policy_user` - (Required) IAM user to which to attach this policy. (`default     = ""`).
- `iam_user_policy_policy` - (Required) IAM user to which to attach this policy. (`default     = ""`).
- `enable_iam_user_policy_attachment` - Enable iam_user_policy_attachment usage (`default     = false`).
- `iam_user_policy_attachment_policy_arn` - (Required) - The ARN of the policy you want to apply (`default     = ""`).
- `enable_iam_user_ssh_key` - Enable iam_user_ssh_key usage (`default     = false`).
- `iam_user_ssh_key_username` - (Required) The name of the IAM user to associate the SSH public key with. (`default     = ""`).
- `iam_user_ssh_key_encoding` - (Required) Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM. (`default     = "SSH"`).
- `iam_user_ssh_key_public_key` - (Required) The SSH public key. The public key must be encoded in ssh-rsa format or PEM format. (`default     = ""`).
- `iam_user_ssh_key_status` - (Optional) The status to assign to the SSH public key. Active means the key can be used for authentication with an AWS CodeCommit repository. Inactive means the key cannot be used. Default is Active. (`default     = "Active"`). 
- `enable_iam_user_login_profile` - Enable iam_user_login_profile usage (`default     = false`).
- `iam_user_login_profile_user` - (Required) The IAM user's name. (`default     = null`).
- `iam_user_login_profile_pgp_key` - (Required) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument. Ex - keybase:captainua (`default     = null`).
- `iam_user_login_profile_password_length` - (Optional, default 20) The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument. (`default     = 20`).
- `iam_user_login_profile_password_reset_required` -  (Optional, default 'true') Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument. (`default     = true`).
- `enable_iam_user_group_membership` - Enable iam_user_group_membership usage (`default     = false`).
- `iam_user_group_membership_user` - (Required) The name of the IAM User to add to groups (`default     = ""`).
- `iam_user_group_membership_groups` - (Required) A list of IAM Groups to add the user to (`default     = []`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
