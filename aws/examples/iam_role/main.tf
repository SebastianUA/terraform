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

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST-role"
  environment = "stage"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "tf-role-for-testing"
  iam_role_description = "It's just a simple IAM role to test TF module"
  # Inside additional_files directory I will add additional policies for assume_role_policy usage in the future....
  iam_role_assume_role_policy = file("additional_files/assume_role_policy_with_mfa.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "my-iam-role-policy-for-testing-terraform"
  iam_role_policy        = file("additional_files/policy.json")

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment      = false
  iam_role_policy_attachment_policy_arns = ["test"]

  # Using IAM instance profile
  enable_iam_instance_profile = true
  iam_instance_profile_name   = "tf-role-for-testing"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
