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

  iam_policy_attachment_roles  = []
  iam_policy_attachment_users  = []
  iam_policy_attachment_groups = ["admins"]
}
