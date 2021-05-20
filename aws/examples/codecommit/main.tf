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

module "codecommit" {
  source      = "../../modules/codecommit"
  name        = "TEST"
  environment = "dev"

  enable_codecommit_repository = true
  codecommit_repository_name   = "myrepo"

  enable_codecommit_trigger = false
  codecommit_trigger = [
    {
      name            = ""
      destination_arn = ""
      branches        = []
      events          = ["all"]
    }
  ]

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
