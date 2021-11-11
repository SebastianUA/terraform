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
