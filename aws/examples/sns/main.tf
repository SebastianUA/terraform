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

module "sns" {
    source                              = "../../modules/sns"
    name                                = "TEST-SNS"
    environment                         = "PROD"

    #
    sns_protocol = "sqs"
    sns_endpoint = "arn:aws:sqs:us-east-1:XXXXXXXXXXXXXXXX:my_sqs"    
}
