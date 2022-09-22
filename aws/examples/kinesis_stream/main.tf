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

module "kinesis_stream" {
  source      = "../../modules/kinesis_stream"
  name        = "TEST"
  environment = "stage"

  enable_kinesis_stream           = true
  kinesis_stream_name             = ""
  kinesis_stream_shard_count      = 1
  kinesis_stream_retention_period = 48
  kinesis_stream_shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  kinesis_stream_encryption_type = "KMS"
  # kinesis_stream_kms_key_id = ""

  kinesis_stream_stream_mode_details = {
    stream_mode = "PROVISIONED"
  }

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}