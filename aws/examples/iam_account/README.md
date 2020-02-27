# Work with AWS IAM for account using via terraform
=======================

A terraform module for making IAM accont.

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

module "iam_account" {
    source                              = "../../modules/iam_account"
    name                                = "TEST-AIM"
    environment                         = "PROD"

    # Using IAM access key
    enable_iam_access_key               = true
    iam_access_key_user                 = "captain"
    iam_access_key_pgp_key              = "keybase:captain"

    # Using IAM account alias
    enable_iam_account_alias            = true
    account_alias                       = ""

    # Using IAM accouhnt password policy
    enable_iam_account_password_policy  = true
    minimum_password_length             = 9
    require_lowercase_characters        = true
    require_numbers                     = true
    require_uppercase_characters        = true
    require_symbols                     = true
    allow_users_to_change_password      = true

    hard_expiry                         = null
    max_password_age                    = null
    password_reuse_prevention           = null
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_iam_access_key` - Enable IAM access key usage (`default     = false`).
- `iam_access_key_user` - (Required) The IAM user to associate with this access key. (`default     = null`).
- `iam_access_key_pgp_key` - (Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists. (`default     = null`).
- `iam_access_key_status` - (Optional) The access key status to apply. Defaults to Active. Valid values are Active and Inactive. (`default     = "Active"`).
- `enable_iam_account_alias` - Enable IAM account alias usage (`default       = false`).
- `account_alias` - (Required) The account alias (`default       = ""`).
- `enable_iam_account_password_policy` - Enable IAM account password policy usage (`default       = false`).
- `minimum_password_length` - (Optional) Minimum length to require for user passwords. (`default       = 8`).
- `require_lowercase_characters` - (Optional) Whether to require lowercase characters for user passwords. (`default       = true`).
- `require_numbers` - (Optional) Whether to require numbers for user passwords. (`default       = true`).
- `require_uppercase_characters` - (Optional) Whether to require uppercase characters for user passwords. (`default       = true`).
- `require_symbols` - (Optional) Whether to require symbols for user passwords. (`default       = true`).
- `allow_users_to_change_password` - (Optional) Whether to allow users to change their own password (`default       = true`).
- `hard_expiry` - (Optional) Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset) (`default       = null`).
- `max_password_age` - (Optional) The number of days that an user password is valid. (`default       = null`).
- `password_reuse_prevention` - (Optional) The number of previous passwords that users are prevented from reusing. (`default       = null`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
