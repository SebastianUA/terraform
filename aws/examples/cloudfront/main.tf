#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
    profile                 = "default"
}
module "cloudfront" {
    source                          = "../../modules/cloudfront"
    name                            = "TEST-cloudfront"
    region                          = "us-east-1"
    environment                     = "PROD"

}
