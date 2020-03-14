#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "> 0.12.12"
}

provider "aws" {
    region  = "us-west-2"
    profile = "default"
}

module "ec2" {
    source                              = "../../modules/ec2"
    name                                = "TEST-Machine"
    region                              = "us-west-2"

    enable_instance                     = true
    environment                         = "dev"
    instance_type                       = "t2.micro"
    enable_associate_public_ip_address  = true
    disk_size                           = 8
    tenancy                             = "default"
    iam_instance_profile                = ""
    subnet_id                           = ""
    vpc_security_group_ids              = []

    monitoring                          = true

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}
