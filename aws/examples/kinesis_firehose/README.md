# Work with KINESIS_FIREHOSE via terraform

A terraform module for making KINESIS_FIREHOSE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_kinesis_firehose_delivery_stream` - Enable kinesis firehose delivery stream usage (`default = False`)
- `kinesis_firehose_delivery_stream_name` - A name to identify the stream. This is unique to the AWS account and region the Stream is created in. (`default = ""`)
- `kinesis_firehose_delivery_stream_destination` - (Required) This is the destination to where the data is delivered. The only options are s3 (Deprecated, use extended_s3 instead), extended_s3, redshift, elasticsearch, splunk, and http_endpoint (`default = null`)
- `kinesis_firehose_delivery_stream_kinesis_source_configuration` - (Optional) Allows the ability to specify the kinesis stream that is used as the source of the firehose delivery stream. (`default = {}`)
- `kinesis_firehose_delivery_stream_server_side_encryption` - (Optional) Encrypt at rest options. Server-side encryption should not be enabled when a kinesis stream is configured as the source of the firehose delivery stream. (`default = {}`)
- `kinesis_firehose_delivery_stream_s3_configuration` - (Optional) Required for non-S3 destinations. For S3 destination, use extended_s3_configuration instead. Configuration options for the s3 destination (or the intermediate bucket if the destination is redshift). (`default = {}`)
- `kinesis_firehose_delivery_stream_extended_s3_configuration` - (Optional, only Required when destination is extended_s3) Enhanced configuration options for the s3 destination. (`default = {}`)
- `kinesis_firehose_delivery_stream_redshift_configuration` - (Optional) Configuration options if redshift is the destination. Using redshift_configuration requires the user to also specify a s3_configuration block.  (`default = {}`)
- `kinesis_firehose_delivery_stream_elasticsearch_configuration` - (Optional) Configuration options if elasticsearch is the destination. (`default = {}`)
- `kinesis_firehose_delivery_stream_splunk_configuration` - (Optional) Configuration options if splunk is the destination. (`default = {}`)
- `kinesis_firehose_delivery_stream_http_endpoint_configuration` - Optional) Configuration options if http_endpoint is the destination. requires the user to also specify a s3_configuration (`default = {}`)

## Module Output Variables
----------------------
- `kinesis_firehose_delivery_stream_id` - The ID specifying the Stream
- `kinesis_firehose_delivery_stream_arn` - The Amazon Resource Name (ARN) specifying the Stream


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
