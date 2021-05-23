#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "glacier" {
  source      = "../../modules/glacier"
  name        = "TEST"
  environment = "stage"

  # Glacier Vault
  enable_glacier_vault        = true
  glacier_vault_name          = ""
  glacier_vault_access_policy = file("additional_files/glacier_vault_policy.json")
  glacier_vault_notification  = []

  #   Glacier Vault lock
  enable_glacier_vault_lock                = true
  glacier_vault_lock_complete_lock         = false
  glacier_vault_lock_policy                = file("additional_files/glacier_vault_policy.json")
  glacier_vault_lock_ignore_deletion_error = null

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
