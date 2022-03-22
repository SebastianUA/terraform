#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "codecommit" {
  source = "../../modules/codecommit"

  # Enable codecommit repo
  enable_codecommit_repository = true
  codecommit_repository_name   = "myrepo"

  # Enable codecommit trigger
  enable_codecommit_trigger = false
  codecommit_trigger_triggers = [
    {
      name            = "trigger-name"
      destination_arn = "some_sns_here"
      branches        = ["master", "main", "dev"]
      events          = ["all"]
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
