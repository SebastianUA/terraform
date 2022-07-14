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

module "sns" {
  source      = "../../modules/sns"
  name        = "TEST"
  environment = "stage"

  # SNS topic
  enable_sns_topic          = true
  sns_topic_name            = "sns-test-stage"
  sns_topic_delivery_policy = file("./policies/sns_topic_delivery_policy_document.json.tpl")

  # SNS topic policy
  enable_sns_topic_policy    = true
  sns_topic_policy_topic_arn = ""
  sns_topic_policy_policy    = ""

  # SNS topic subscription
  enable_sns_topic_subscription = true

  sns_topic_subscription_sns_protocol  = "sqs"
  sns_topic_subscription_sns_endpoints = ["arn:aws:sqs:us-east-1:XXXXXXXXXXXXXXXX:my_sqs"]

  #
  enable_sns_platform_application = false
  sns_platform_application_name   = "test"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
