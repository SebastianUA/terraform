#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "cloudhsm" {
    source                          = "../../modules/cloudhsm"

    name                            = "test"
    environment                     = "stage"
    region                          = "us-east-1"

    enable_cloudhsm_v2_cluster      = true
    cloudhsm_v2_cluster_subnet_ids  = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]
    cloudhsm_v2_cluster_name        = ""

    enable_cloudhsm_v2_hsm          = true
    cloudhsm_v2_hsm_subnet_id       = "subnet-8851dea6"
}
