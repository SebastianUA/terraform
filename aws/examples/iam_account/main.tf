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

# 
# Checks
#
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


#
# IAM account
#
module "iam_account" {
  count = data.external.python3_iam_users.result["User"] == "None" && data.external.python3_iam_users.result["exit_code"] == "1" ? 1 : 0

  source      = "../../modules/iam_account"
  name        = "TEST"
  environment = "stage"

  # Using IAM access key
  enable_iam_access_key  = true
  iam_access_key_user    = "captain2"
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

  depends_on = [
    data.external.python3_iam_users
  ]
}
