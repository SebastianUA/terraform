#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "codecommit" {
    source                              = "../../modules/codecommit"
    name                                = "TEST"
    environment                         = "stage"

    enable_codecommit_repository        = true
    codecommit_repository_name          = "myrepo"

    enable_codecommit_trigger           = false
    codecommit_trigger_name             = ""
    codecommit_trigger_destination_arn  = ""
    codecommit_trigger_branches         = []
    codecommit_trigger_events           = ["all"]

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}
