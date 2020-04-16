#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "appautoscaling" {
    source                                              = "../../modules/appautoscaling"
    name                                                = "TEST"
    environment                                         = "stage"

}
