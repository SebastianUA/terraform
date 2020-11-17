#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "iam_account" {
  source      = "../../modules/iam_account"
  name        = "TEST"
  environment = "stage"

  # Using IAM access key
  enable_iam_access_key  = true
  iam_access_key_user    = "captain"
  iam_access_key_pgp_key = "keybase:captain"

  # Using IAM account alias
  enable_iam_account_alias = true
  account_alias            = ""

  # Using IAM accouhnt password policy
  enable_iam_account_password_policy = true
  minimum_password_length            = 9
  require_lowercase_characters       = true
  require_numbers                    = true
  require_uppercase_characters       = true
  require_symbols                    = true
  allow_users_to_change_password     = true

  hard_expiry               = null
  max_password_age          = null
  password_reuse_prevention = null
}
