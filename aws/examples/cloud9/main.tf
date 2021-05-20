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

module "cloud9" {
  source      = "../../modules/cloud9"
  name        = "TEST"
  environment = "stage"

  enable_cloud9_environment_ec2        = true
  cloud9_environment_ec2_name          = ""
  cloud9_environment_ec2_instance_type = "t2.micro"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
