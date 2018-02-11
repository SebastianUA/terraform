# Work with AWS SQS via terraform

A terraform module for making SQS.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    # alias = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
     # access_key = "${var.aws_access_key}"
     # secret_key = "${var.aws_secret_key}"
}

module "sqs" {
    source                              = "../../modules/sqs"
    name                                = "TEST-SQS"
    environment                         = "PROD"

    #Enable Fifo
    #enable_fifo_queue           = true
    #content_based_deduplication = true

    #sqs_dead_letter_queue_arn   = "arn:aws:sqs:us-east-1:XXXXXXXXXXXXXXX:my_sqs"
}


```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default = "TEST-SQS"`).
- `environment` - Environment for service (`default  = "STAGE"`).
- `orchestration` - Type of orchestration (`default  = "Terraform"`).
- `createdby` - Created by (`default  = "Vitaliy Natarov"`).
- `delay_seconds`- The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds (`default = "90"`).
- `max_message_size` - The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB) - (`default  = "2048"`).
- `message_retention_seconds` - The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days) - (`default = "86400"`).
- `receive_wait_time_seconds`- The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately (`default  = "10"`).
- `enable_fifo_queue` - Boolean designating a FIFO queue. If not set, it defaults to false making it standard (`default = "false"`).
- `content_based_deduplication` - Enables content-based deduplication for FIFO queues (`default  = "false"`).
- `kms_master_key_id` - The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK (`default = "alias/aws/sqs"`).
- `kms_data_key_reuse_period_seconds` - "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes) - (`default = "300"`).
- `maxReceiveCount` - Value for redrive_policy (set maxReceiveCount for dead_letter_queue) - (`default = "10"`).
- `sqs_dead_letter_queue_arn`- Set sqs arn for dead_letter_queue (`default  = ""`).
- `visibility_timeout_seconds` - the timeout in seconds of visibility of the message (`default = 30`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
