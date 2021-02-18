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

module "kinesis_video" {
  source      = "../../modules/kinesis_video"


  tags = map("Env", "stage", "Orchestration", "Terraform")

}
