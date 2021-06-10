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
# iam user
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
module "iam_user" {
  count = data.external.python3_iam_users.result["User"] == "None" && data.external.python3_iam_users.result["exit_code"] == "1" ? 1 : 0

  source      = "../../modules/iam_user"
  name        = "TEST-iam-user"
  environment = "stage"

  # Using IAM user
  enable_iam_user        = true
  iam_user_name          = ""
  iam_user_path          = "/"
  iam_user_force_destroy = true

  # Using user SSH key
  enable_iam_user_ssh_key     = true
  iam_user_ssh_key_encoding   = "SSH"
  iam_user_ssh_key_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 mytest@mydomain.com"
  iam_user_ssh_key_status     = "Active"

  # Using IAM user policy
  enable_iam_user_policy = true
  iam_user_policy_name   = "my-test-policy"
  iam_user_policy_policy = file("additional_files/policy.json")

  # Using IAM user policy attachment
  enable_iam_user_policy_attachment     = false
  iam_user_policy_attachment_policy_arn = ""

  # Using IAM user membership
  enable_iam_user_group_membership = true
  iam_user_group_membership_groups = ["admins"]

  # Using IAM user login profile
  enable_iam_user_login_profile                  = true
  iam_user_login_profile_pgp_key                 = "keybase:${data.external.python3_iam_users.result["User"]}"
  iam_user_login_profile_password_length         = 20
  iam_user_login_profile_password_reset_required = true


  depends_on = [
    data.external.python3_iam_users
  ]
}
