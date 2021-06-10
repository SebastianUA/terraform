#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region = "us-east-1"
  # alias                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST-role"
  environment = "stage"

  # Using IAM role
  enable_iam_role = true
  iam_role_name   = "kms-role-for-lambda"

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "my-iam-role-policy-for-testing-terraform"
  iam_role_policy        = file("additional_files/policies/kms_policy.json")

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


data "template_file" "kms_key_policy" {
  template = file("additional_files/policies/kms_key_policy.json.tpl")
}

module "kms" {
  source = "../../modules/kms"

  name        = "tmp"
  environment = "dev"

  # KMS key
  enable_kms_key                  = true
  kms_key_name                    = ""
  kms_key_deletion_window_in_days = 30
  kms_key_policy                  = data.template_file.kms_key_policy.rendered

  # KMS alias
  enable_kms_alias = true
  kms_alias_name   = "alias/ec2-my-key"

  # KSM grant
  enable_kms_grant            = true
  kms_grant_name              = ""
  kms_grant_grantee_principal = module.iam_role.iam_role_arn
  kms_grant_operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]

  # KMS external key
  enable_kms_external_key      = true
  kms_external_key_name        = ""
  kms_external_key_description = "Some external KMS key"

  # KMS ciphertext
  enable_kms_ciphertext    = true
  kms_ciphertext_plaintext = <<EOF
{
  "client_id": "e587dbae22222f55da22",
  "client_secret": "8289575d00000ace55e1815ec13673955721b8a5"
}
EOF

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
