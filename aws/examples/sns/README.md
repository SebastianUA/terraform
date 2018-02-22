# Work with AWS SNS via terraform

A terraform module for making SNS.

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

module "sns" {
    source                              = "../../modules/sns"
    name                                = "TEST-SNS"
    environment                         = "PROD"

    #
    sns_protocol = "sqs"
    sns_endpoint = "arn:aws:sqs:us-east-1:XXXXXXXXXXXXXXXX:my_sqs"    
}

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix" (`default = "TEST"`).
- `account-id` - AWS Account ID (`default = ""`).
- `delivery_policy` - Delivery policy (`default = ""`).
- `sns_protocol` - The protocol to use. The possible values for this are: sqs, sms, lambda, application. (http or https are partially supported, see below) (email is option but unsupported) - (`efault = "sqs"`).
- `sns_endpoint` - The endpoint to send data to, the contents will vary with the protocol.
- `confirmation_timeout_in_minutes` - Set timeout in minutes. Integer indicating number of minutes to wait in retying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols (default is 1 minute) - (`default  = "1"`).
- `endpoint_auto_confirms` - Enable endpoint auto confirms. Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty (default is false) - (`default = "false"`).
- `raw_message_delivery` - Set raw message delivery.Boolean indicating whether or not to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property) (default is false) - (`default = "false"`).
- `minDelayTarget` - Set minDelayTarget. Max=20 (`default = "19"`).
- `maxDelayTarget` - Set maxDelayTarget. Max=20 (`default = "19"`).
- `numRetries` - Set numRetries (`default = "3"`).
- `numMaxDelayRetries` - Set numMaxDelayRetries (`default = "0"`).
- `numNoDelayRetries` - Set numNoDelayRetries (`default = "0"`).
- `numMinDelayRetries` - Set numMinDelayRetries (`default = "0"`).
- `backoffFunction` - Set backoffFunction. Can set: arithmetic, exponential or linear (`default = "linear"`).
- `disableSubscriptionOverrides` - Set disableSubscriptionOverrides (`default = "false"`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
