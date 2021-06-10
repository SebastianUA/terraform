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
