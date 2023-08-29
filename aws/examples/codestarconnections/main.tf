#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "default"
}

module "codestarconnections" {
  source = "../../modules/codestarconnections"

  enable_codestarconnections_connection        = true
  codestarconnections_connection_name          = "github-test-codestarconnections"
  codestarconnections_connection_provider_type = "GitHub"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
