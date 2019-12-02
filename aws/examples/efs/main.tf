#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-west-2"
    shared_credentials_file = pathexpand("~/.aws/credentials")
    profile                 = "default"
}

module "efs" {
    source                  = "../../modules/efs"
    name                    = "TEST"
    region                  = "us-west-2"
    environment             = "nonprod"

    enable_efs_file_system  = true
    efs_file_system_name    = ""
    encrypted               = false
    kms_key_id              = ""
    performance_mode        = "generalPurpose"

    lifecycle_policy        = [
        {
            transition_to_ia    = "AFTER_90_DAYS"
        },
    ]
    
    enable_efs_mount_target = true
    subnet_ids              = ["subnet-0e2b323b731655057", "subnet-0ffa47878036f1641", "subnet-096406cfdf907ee11"]
    security_groups         = ["sg-07b62c0d0ea37056d"]
}