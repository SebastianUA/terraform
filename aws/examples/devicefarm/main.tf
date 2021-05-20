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

module "devicefarm" {
  source      = "../../modules/devicefarm"
  name        = "TEST"
  environment = "dev"

  enable_devicefarm_project = true
  devicefarm_project_name   = ""
}
