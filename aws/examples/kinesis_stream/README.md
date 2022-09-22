# Work with KINESIS_STREAM via terraform

A terraform module for making KINESIS_STREAM.


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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_kinesis_stream` - Enable kinesis stream usage (`default = False`)
- `kinesis_stream_name` - A name to identify the stream. This is unique to the AWS account and region the Stream is created in. (`default = ""`)
- `kinesis_stream_shard_count` - (Optional) The number of shards that the stream will use. If the stream_mode is PROVISIONED, this field is required. Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream. See Amazon Kinesis Streams for more. (`default = null`)
- `kinesis_stream_retention_period` - (Optional) Length of time data records are accessible after they are added to the stream. The maximum value of a stream's retention period is 8760 hours. Minimum value is 24. Default is 24 (`default = null`)
- `kinesis_stream_shard_level_metrics` - (Optional) A list of shard-level CloudWatch metrics which can be enabled for the stream. See Monitoring with CloudWatch for more. Note that the value ALL should not be used; instead you should provide an explicit list of metrics you wish to enable. (`default = null`)
- `kinesis_stream_enforce_consumer_deletion` - (Optional) A boolean that indicates all registered consumers should be deregistered from the stream so that the stream can be destroyed without error. The default value is false (`default = null`)
- `kinesis_stream_encryption_type` - (Optional) The encryption type to use. The only acceptable values are NONE or KMS. The default value is NONE. (`default = null`)
- `kinesis_stream_kms_key_id` - (Optional) The GUID for the customer-managed KMS key to use for encryption. You can also use a Kinesis-owned master key by specifying the alias alias/aws/kinesis. (`default = null`)
- `kinesis_stream_stream_mode_details` - Optional) Indicates the capacity mode of the data stream. (`default = {}`)
- `kinesis_stream_timeouts` - Set timeouts for kinesis stream (`default = {}`)
- `enable_kinesis_stream_consumer` - Enable kinesis stream consumer usage (`default = False`)
- `kinesis_stream_consumer_name` - Name of the stream consumer. (`default = ""`)
- `kinesis_stream_consumer_stream_arn` - Amazon Resource Name (ARN) of the data stream the consumer is registered with. (`default = ""`)

## Module Output Variables
----------------------
- `kinesis_stream_id` - The unique Stream id
- `kinesis_stream_name` - The unique Stream name
- `kinesis_stream_shard_count` - The count of Shards for this Stream
- `kinesis_stream_arn` - The Amazon Resource Name (ARN) specifying the Stream (same as id)
- `kinesis_stream_consumer_id` - Amazon Resource Name (ARN) of the stream consumer.
- `kinesis_stream_consumer_arn` - Amazon Resource Name (ARN) of the stream consumer.
- `kinesis_stream_consumer_creation_timestamp` - Approximate timestamp in RFC3339 format of when the stream consumer was created.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
