#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-west-2"
  profile                  = "default"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

module "kinesis_video" {
  source = "../../modules/kinesis_video"


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}
