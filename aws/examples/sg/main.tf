#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
     # access_key = "${var.aws_access_key}"
     # secret_key = "${var.aws_secret_key}"
}

module "sg" {
    source                              = "../../modules/sg"
    name                                = "Bastion_Ukraine"
    environment                         = "PROD"


    enable_sg_creating                  = true
    vpc_id                              = "vpc-09f1d36e"
    enable_all_egress_ports             = "true"
    allowed_ports                       = ["22"]
    allow_cidrs_for_allowed_ports       = {
        #
        # Vitalii.Natarov's home IP - 159.224.217.0/24
        #
        "22" = [
            "159.224.217.0/24",
        ]
    }
}
