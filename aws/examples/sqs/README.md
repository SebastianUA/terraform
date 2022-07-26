# Work with SQS via terraform

A terraform module for making SQS.


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

module "sqs" {
  source      = "../../modules/sqs"
  name        = "TEST"
  environment = "stage"

  # SQS queue
  enable_sqs_queue = true
  sqs_queue_name   = "test-sqs-here"

  #redrive_policy                      = file("policies/redrive_policy.json.tpl")
  sqs_queue_dead_letter_queue_arn = "arn:aws:sqs:us-east-1:XXXXXXXXXXXXXXX:my_sqs"
  sqs_queue_maxReceiveCount       = 10

  # SQS queue policy
  enable_sqs_queue_policy    = true
  sqs_queue_policy_queue_url = ""
  sqs_queue_policy           = file("policies/sqs_queue_policy.json.tpl")

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
- `enable_sqs_queue` - Enable SQS queue usage (`default = False`)
- `sqs_queue_name` - description (`default = ""`)
- `sqs_queue_name_prefix` - description (`default = (Optional) Creates a unique name beginning with the specified prefix. Conflicts with sqs_queue_name`)
- `sqs_queue_delay_seconds` - The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds. (`default = 90`)
- `sqs_queue_max_message_size` - The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB). (`default = 2048`)
- `sqs_queue_message_retention_seconds` - The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days). (`default = 86400`)
- `sqs_queue_receive_wait_time_seconds` - The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately. (`default = 10`)
- `sqs_queue_fifo_queue` - Boolean designating a FIFO queue. If not set, it defaults to false making it standard. (`default = False`)
- `sqs_queue_content_based_deduplication` - Enables content-based deduplication for FIFO queues. (`default = False`)
- `sqs_queue_kms_master_key_id` - The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. (`default = alias/aws/sqs`)
- `sqs_queue_kms_data_key_reuse_period_seconds` - The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes). (`default = 300`)
- `sqs_queue_maxReceiveCount` - Value for redrive_policy (set maxReceiveCount for dead_letter_queue) (`default = 10`)
- `sqs_queue_dead_letter_queue_arn` - Set sqs arn for dead_letter_queue (`default = 0`)
- `sqs_queue_visibility_timeout_seconds` - the timeout in seconds of visibility of the message (`default = 30`)
- `sqs_queue_policy` - (Optional) The JSON policy for the SQS queue. For more information about building AWS IAM policy documents with Terraform (`default = null`)
- `enable_sqs_queue_policy` - Enable SQS queue policy (`default = False`)
- `sqs_queue_policy_queue_url` - (Required) The URL of the SQS Queue to which to attach the policy (`default = ""`)

## Module Output Variables
----------------------
- `sqs_queue_arn` - The URL for the created Amazon SQS queue.
- `sqs_queue_id` - The ARN of the SQS queue


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
