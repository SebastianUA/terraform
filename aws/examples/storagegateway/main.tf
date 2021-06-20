#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "storagegateway" {
  source      = "../../modules/storagegateway"
  name        = "TEST"
  environment = "stage"

  # Enable storagegateway gateway
  enable_storagegateway_gateway     = true
  storagegateway_gateway_name       = ""
  storagegateway_gateway_timezone   = "GMT"
  storagegateway_gateway_ip_address = "1.2.3.4"
  storagegateway_gateway_type       = "STORED" # "CACHED", "VTL", "FILE_S3"

  depends_on = []
}

data "aws_storagegateway_local_disk" "storagegateway_local_disk" {
  disk_path   = "/dev/xvdb"
  gateway_arn = module.storagegateway.storagegateway_gateway_arn

  depends_on = [
    module.storagegateway
  ]
}

module "storagegateway_stored_iscsi_volume" {
  source      = "../../modules/storagegateway"
  name        = "TEST"
  environment = "stage"

  # Enable storagegateway stored iscsi volume
  enable_storagegateway_stored_iscsi_volume                 = true
  storagegateway_stored_iscsi_volume_name                   = ""
  storagegateway_stored_iscsi_volume_gateway_arn            = module.storagegateway.storagegateway_gateway_arn
  storagegateway_stored_iscsi_volume_network_interface_id   = "192.168.113.66"
  storagegateway_stored_iscsi_volume_target_name            = "example"
  storagegateway_stored_iscsi_volume_preserve_existing_data = false
  storagegateway_stored_iscsi_volume_disk_id                = data.aws_storagegateway_local_disk.storagegateway_local_disk.id

  depends_on = [
    module.storagegateway,
    data.aws_storagegateway_local_disk.storagegateway_local_disk
  ]
}
