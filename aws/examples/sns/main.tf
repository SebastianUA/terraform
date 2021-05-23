#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "sns" {
  source      = "../../modules/sns"
  name        = "TEST"
  environment = "stage"

  # SNS topic
  enable_sns_topic          = true
  sns_topic_name            = "sns-test-stage"
  sns_topic_delivery_policy = file("./policies/sns_topic_delivery_policy_document.json.tpl")

  # SNS topic policy
  enable_sns_topic_policy = true
  topic_arn               = ""
  sns_topic_policy        = ""

  # SNS topic subscription
  enable_sns_topic_subscription = true

  sns_protocol = "sqs"
  sns_endpoint = "arn:aws:sqs:us-east-1:XXXXXXXXXXXXXXXX:my_sqs"

  #
  enable_sns_platform_application = false
  sns_platform_application_name   = "test"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
