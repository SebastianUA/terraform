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

module "kinesis_firehose" {
  source      = "../../modules/kinesis_firehose"
  name        = "TEST"
  environment = "stage"

  enable_kinesis_firehose_delivery_stream      = true
  kinesis_firehose_delivery_stream_name        = ""
  kinesis_firehose_delivery_stream_destination = "http_endpoint"

  kinesis_firehose_delivery_stream_kinesis_source_configuration = {}
  kinesis_firehose_delivery_stream_server_side_encryption = {
    # enabled  = null
    # key_type = null
    # key_arn  = null
  }

  kinesis_firehose_delivery_stream_extended_s3_configuration   = {}
  kinesis_firehose_delivery_stream_redshift_configuration      = {}
  kinesis_firehose_delivery_stream_elasticsearch_configuration = {}
  kinesis_firehose_delivery_stream_splunk_configuration        = {}
  kinesis_firehose_delivery_stream_http_endpoint_configuration = {
    url      = "https://aws-metrics-stream.io/"
    role_arn = "role_arn"

    name               = "HTTP endpoint"
    access_key         = null
    s3_backup_mode     = "FailedDataOnly"
    buffering_size     = 5
    buffering_interval = 60
    retry_duration     = 60

    cloudwatch_logging_options = {
      enabled         = null
      log_group_name  = null
      log_stream_name = null
    }
    processing_configuration = {
      # enabled = false

      # processors = [
      #   {
      #     type = null
      #     parameters = [
      #       {
      #         parameter_name  = null 
      #         parameter_value = null
      #       }
      #     ]
      #   }
      # ]
    }
  }

}
