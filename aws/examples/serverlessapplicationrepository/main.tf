#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13.5"
}

provider "aws" {
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "serverlessapplicationrepository" {
  source = "../../modules/serverlessapplicationrepository"


  tags = map("Env", "stage", "Orchestration", "Terraform")

}
