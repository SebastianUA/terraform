#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "cloudwatch" {
    source                  = "../../modules/cloudwatch"

    alarm_name              = "my-application-logs-errors"
     alarm_description      = "Bad errors in my-application-logs"
    comparison_operator     = "GreaterThanOrEqualToThreshold"
    evaluation_periods      = 1
    threshold               = 10
    period                  = 60
    unit                    = "Count"

    namespace               = "MyApplication"
    metric_name             = "ErrorCount"
    statistic               = "Maximum"

    alarm_actions           = []
}
