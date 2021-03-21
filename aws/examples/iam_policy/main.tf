#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "iam_policy" {
  source      = "../../modules/iam_policy"
  name        = "TEST-iam-policy"
  environment = "stage"

  # Using IAM policy
  enable_iam_policy = true
  iam_policy_name   = "test-policy"
  iam_policy_path   = "/"
  iam_policy_policy = file("additional_files/policy.json")

  # Using IAM policy attachment
  enable_iam_policy_attachment = true
  iam_policy_attachment_name   = ""

  #iam_role_policy_attachment_roles        = null
  #iam_policy_attachment_users             = null
  iam_policy_attachment_groups = ["admins"]

  iam_role_policy_attachment_policy_arn = ""
}
