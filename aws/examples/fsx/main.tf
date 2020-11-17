#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13.5"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "fsx" {
  source      = "../../modules/fsx"
  name        = "TEST"
  environment = "stage"

  # FSX lustre file system
  enable_fsx_lustre_file_system           = true
  fsx_lustre_file_system_storage_capacity = 1200
  fsx_lustre_file_system_subnet_ids       = ["sub-4344c4d"]

  fsx_lustre_file_system_import_path = "s3://my-test-bucket-here"

  #
  enable_fsx_windows_file_system              = true
  fsx_windows_file_system_storage_capacity    = 1200
  fsx_windows_file_system_subnet_ids          = ["sub-4344c4d"]
  fsx_windows_file_system_throughput_capacity = 32
}
