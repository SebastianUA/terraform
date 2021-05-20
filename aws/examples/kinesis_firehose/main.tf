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

module "kinesis_firehose" {
  source      = "../../modules/kinesis_firehose"
  name        = "TEST"
  environment = "stage"
}
