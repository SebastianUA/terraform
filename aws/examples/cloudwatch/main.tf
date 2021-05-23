#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  enable_cw_metric_alarm = true
  alarm_name             = "my-application-logs-errors"
  alarm_description      = "Bad errors in my-application-logs"
  comparison_operator    = "GreaterThanOrEqualToThreshold"
  evaluation_periods     = 1
  threshold              = 10
  period                 = 60
  unit                   = "Count"

  namespace   = "MyApplication"
  metric_name = "ErrorCount"
  statistic   = "Maximum"

  alarm_actions = []

  # CloudWatch LOG group
  enable_cw_log_group            = true
  cw_log_group_name              = "LogGroup"
  cw_log_group_retention_in_days = 30


  # CloudWatch LOG metric filter
  enable_cw_log_metric_filter  = true
  cw_log_metric_filter_name    = "log-filter"
  cw_log_metric_filter_pattern = ""
  cw_log_metric_filter_metric_transformation = [
    {
      name      = "EventCount"
      namespace = "YourNamespace"
      value     = "1"
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
