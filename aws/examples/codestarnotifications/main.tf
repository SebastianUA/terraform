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

module "codestarnotifications" {
  source      = "../../modules/codestarnotifications"
  name        = "TEST"
  environment = "stage"

  enable_codestarnotifications_notification_rule         = true
  codestarnotifications_notification_rule_name           = ""
  codestarnotifications_notification_rule_resource       = "arn:aws:codecommit:us-east-2:111111111111:MyDemoRepo"
  codestarnotifications_notification_rule_detail_type    = "FULL"
  codestarnotifications_notification_rule_event_type_ids = ["codecommit-repository-comments-on-commits"]
  codestarnotifications_notification_rule_status         = "ENABLED"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
