#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

module "simpledb" {
  source      = "../../modules/simpledb"
  name        = "TEST"
  environment = "stage"

  enable_simpledb_domain = true
  simpledb_domain_name   = ""
}
