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

module "cloudwatch_logs" {
  source      = "../../modules/cloudwatch_logs"
  name        = ""
  environment = "staging"

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
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}