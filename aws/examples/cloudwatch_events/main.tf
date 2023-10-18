terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "cloudwatch" {
  source = "../../modules/cloudwatch_events"

  enable_cloudwatch_event_rule      = true
  cloudwatch_event_rule_name        = "test-cw-rule"
  cloudwatch_event_rule_name_prefix = null
  cloudwatch_event_rule_description = "test"

  cloudwatch_event_rule_event_pattern = jsonencode({
    detail-type = [
      "AWS Console Sign In via CloudTrail"
    ]
  })

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}