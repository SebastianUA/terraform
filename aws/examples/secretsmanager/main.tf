#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "secretsmanager" {
  source = "../../modules/secretsmanager"

  # AWS secretsmanager secret
  enable_secretsmanager_secret      = true
  secretsmanager_secret_name        = "test-secretmanager-secret"
  secretsmanager_secret_description = "Managing by Terrafrom"
  secretsmanager_secret_rotation_rules = [{
    automatically_after_days = 7
  }]

  # AWS secretsmanager secret version
  enable_secretsmanager_secret_version = true
  secretsmanager_secret_version_secret_string = jsonencode(
    {
      key1  = "value1"
      key2  = "value2"
      test  = "test"
      test2 = "test2"
    }
  )

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
