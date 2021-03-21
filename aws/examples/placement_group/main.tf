#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "sfn" {
  source      = "../../modules/placement_group"
  name        = "TEST"
  environment = "dev"

  enable_placement_group   = true
  placement_group_name     = ""
  placement_group_strategy = "cluster"


  tags = merge(map(
    "createdby", "vnatarov"
  ))
}
