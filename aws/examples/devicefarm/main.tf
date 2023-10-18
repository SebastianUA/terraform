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

module "devicefarm" {
  source      = "../../modules/devicefarm"
  name        = "TEST"
  environment = "dev"

  enable_devicefarm_project = true
  devicefarm_project_name   = ""
}
