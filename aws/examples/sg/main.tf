#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.11.11"
}
provider "aws" {
    region  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "sg" {
    source                              = "../../modules/sg"
    name                                = "test"
    environment                         = "NonPROD"

    enable_sg_creating                  = true
    vpc_id                              = "vpc-0d0d22629db6d471d"
    enable_all_egress_ports             = true
    allowed_ports                       = ["22", "7199", "7000", "7001", "9160", "9042"]
    allow_cidrs_for_allowed_ports       = {
        "22" = [
            "159.224.217.0/24",
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "7199" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "7000" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "7001" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "9160" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "9042" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ]
    }


}
