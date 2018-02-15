#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    profile = "default"
}
module "cloudwatch" {
    source                  = "../../modules/cloudwatch"

    dimensions = [
        {
          AutoScalingGroupName = ""
          #AutoScalingGroupName = "${aws_autoscaling_group.bar.name}"
        }
    ]

    alarm_name          = "My first alarm"
    #alarm_description  = "Test description"
    #alarm_actions      = "${aws_autoscaling_policy.bat.arn}"

    #
    #principal_for_event_permission  = "XXXXXXXXXXXXXXX"

    #arn_for_cloudwatch_event_target = "arn:aws:sns:us-east-1:XXXXXXXXXXXXXXX:test-sns-sns-prod"
    #
    #name_for_cloudwatch_log_group   = "test-log-group"
    #
    #name_for_cloudwatch_log_stream  = "test-log-steam"
}
