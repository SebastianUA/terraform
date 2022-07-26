# Work with IAM_ACCOUNT via terraform

A terraform module for making IAM_ACCOUNT.


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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# A check to understand if the user inside AWS is already exist or not
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
data "external" "python3_iam_users" {
  program = ["python3", "additional_files/iam_user.py"]

  query = {
    client       = "iam"
    region       = "us-east-1"
    profile_name = "default"
    role_name    = "None"
    role_session = "None"
    user_name    = "captain2"
  }
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# IAM account
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
module "iam_account" {
  count = data.external.python3_iam_users.result["User"] == "None" && data.external.python3_iam_users.result["exit_code"] == "1" ? 1 : 0

  source      = "../../modules/iam_account"
  name        = "TEST"
  environment = "stage"

  # Using IAM access key
  enable_iam_access_key  = true
  iam_access_key_user    = data.external.python3_iam_users.result["User"]
  iam_access_key_pgp_key = "keybase:captain"

  # Using IAM account alias
  enable_iam_account_alias = true
  iam_account_alias        = ""

  # Using IAM accouhnt password policy
  enable_iam_account_password_policy                         = true
  iam_account_password_policy_minimum_password_length        = 9
  iam_account_password_policy_require_lowercase_characters   = true
  iam_account_password_policy_require_numbers                = true
  iam_account_password_policy_require_uppercase_characters   = true
  iam_account_password_policy_require_symbols                = true
  iam_account_password_policy_allow_users_to_change_password = true

  iam_account_password_policy_hard_expiry               = null
  iam_account_password_policy_max_password_age          = null
  iam_account_password_policy_password_reuse_prevention = null

  depends_on = [
    data.external.python3_iam_users
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_iam_access_key` - Enable IAM access key usage (`default = False`)
- `iam_access_key_user` - (Required) The IAM user to associate with this access key. (`default = null`)
- `iam_access_key_pgp_key` - (Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists. (`default = null`)
- `iam_access_key_status` - (Optional) The access key status to apply. Defaults to Active. Valid values are Active and Inactive. (`default = null`)
- `enable_iam_account_alias` - Enable IAM account alias usage (`default = False`)
- `iam_account_alias` - (Required) The account alias (`default = ""`)
- `enable_iam_account_password_policy` - Enable IAM account password policy usage (`default = False`)
- `iam_account_password_policy_minimum_password_length` - (Optional) Minimum length to require for user passwords. (`default = 8`)
- `iam_account_password_policy_require_lowercase_characters` - (Optional) Whether to require lowercase characters for user passwords. (`default = True`)
- `iam_account_password_policy_require_numbers` - (Optional) Whether to require numbers for user passwords. (`default = True`)
- `iam_account_password_policy_require_uppercase_characters` - (Optional) Whether to require uppercase characters for user passwords. (`default = True`)
- `iam_account_password_policy_require_symbols` - (Optional) Whether to require symbols for user passwords. (`default = True`)
- `iam_account_password_policy_allow_users_to_change_password` - (Optional) Whether to allow users to change their own password (`default = True`)
- `iam_account_password_policy_hard_expiry` - (Optional) Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset) (`default = null`)
- `iam_account_password_policy_max_password_age` - (Optional) The number of days that an user password is valid. (`default = null`)
- `iam_account_password_policy_password_reuse_prevention` - (Optional) The number of previous passwords that users are prevented from reusing. (`default = null`)

## Module Output Variables
----------------------
- `iam_access_key_id` - The access key ID
- `iam_access_key_user` - The IAM user associated with this access key.
- `iam_access_key_key_fingerprint` - The fingerprint of the PGP key used to encrypt the secret
- `iam_access_key_secret` - The secret access key. Note that this will be written to the state file. Please supply a pgp_key instead, which will prevent the secret from being stored in plain text
- `iam_access_key_encrypted_secret` - The encrypted secret, base64 encoded. ~> NOTE: The encrypted secret may be decrypted using the command line, for example: terraform output encrypted_secret | base64 --decode | keybase pgp decrypt.
- `keybase_password_decrypt_command` - ""
- `keybase_password_pgp_message` - ""
- `keybase_secret_key_decrypt_command` - ""
- `keybase_secret_key_pgp_message` - ""
- `iam_account_alias_id` - ID
- `iam_account_password_policy_id` - ID


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
