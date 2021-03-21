#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "codestarconnections" {
  source = "../../modules/codestarconnections"


  tags = map("Env", "stage", "Orchestration", "Terraform")

}
