#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  enable_cw_metric_alarm              = true
  cw_metric_alarm_name                = "my-application-logs-errors"
  cw_metric_alarm_description         = "Bad errors in my-application-logs"
  cw_metric_alarm_comparison_operator = "GreaterThanOrEqualToThreshold"
  cw_metric_alarm_evaluation_periods  = 1
  cw_metric_alarm_threshold           = 10
  cw_metric_alarm_period              = 60
  cw_metric_alarm_unit                = "Count"

  cw_metric_alarm_namespace   = "MyApplication"
  cw_metric_alarm_metric_name = "ErrorCount"
  cw_metric_alarm_statistic   = "Maximum"

  cw_metric_alarm_actions = []

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
