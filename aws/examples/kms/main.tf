#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    # alias = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
     # access_key = "${var.aws_access_key}"
     # secret_key = "${var.aws_secret_key}"
}

module "kms" {
    source               = "../../modules/kms"
    name                 = "TEST-KMS"
    environment          = "PROD"

    aws_account_id       = "XXXXXXXXXXXXXXXXXX"           
}
