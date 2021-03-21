#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "macie" {
  source = "../../modules/macie"

  enable_macie_member_account_association            = true
  macie_member_account_association_member_account_id = "123456789012"

  enable_macie_s3_bucket_association      = true
  macie_s3_bucket_association_bucket_name = "s3-bucket-here"
  macie_s3_bucket_association_prefix      = "data"
  macie_s3_bucket_association_classification_type = [{
    continuous = "FULL"
    one_time   = "NONE"
  }]

}
