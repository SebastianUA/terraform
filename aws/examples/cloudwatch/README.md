# Work with AWS CloudWatch via terraform

A terraform module for making CloudWatch.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

```

Module Input Variables
----------------------

- `name`- Name to be used on tags (`default = TEST-CW`).
- `environment` - Environment for service (`default = stage`). Just uses for tag.
- `orchestration` - Type of orchestration (`default = Terraform`). Just uses for tag.
- `region` - The region where to deploy this code (e.g. us-east-1) - (`default     = "us-east-1"`).
- `alarm_name` - The descriptive name for the alarm. This name must be unique within the user's AWS account (`default     = ""`).
- `comparison_operator` - The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold (`default     = "GreaterThanOrEqualToThreshold"`).
- `evaluation_periods` - The number of periods over which data is compared to the specified threshol (`default     = "2"`).
- `metric_name` - The name for the alarm's associated metric (ex: CPUUtilization) - (`default     = "CPUUtilization"`).
- `namespace` - The namespace for the alarm's associated metric (ex: AWS/EC2) - (`default     = "AWS/EC2"`).
- `period` - The period in seconds over which the specified statistic is applied (`default     = "120"`).
- `statistic` - The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum (`efault     = "Average"`).
- `threshold` - The value against which the specified statistic is compared (`default     = "80"`).
- `actions_enabled` - Indicates whether or not actions should be executed during any changes to the alarm's state. Defaults to true (`default     = "true"`).
- `alarm_actions` - The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Number (ARN) - (`default     = []`).
- `alarm_description` - The description for the alarm (`default     = ""`).
- `datapoints_to_alarm` - The number of datapoints that must be breaching to trigger the alarm (`default     = "0"`).
- `dimensions` - List of the dimensions for the alarm's associated metric (`default     = []`).
- `insufficient_data_actions` - he list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Number (ARN) - (`default     = []`).
- `ok_actions` - The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN) - (`default     = []`).
- `unit` - The unit for the alarm's associated metric (`default     = ""`).
- `extended_statistic` - The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100 (`default     = "p100"`).
- `treat_missing_data` - Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing (`default     = "missing"`).
- `evaluate_low_sample_count_percentiles` - Used only for alarms based on percentiles. If you specify ignore, the alarm state will not change during periods with too few data points to be statistically significant. If you specify evaluate or omit this parameter, the alarm will always be evaluated and possibly change state no matter how many data points are available. The following values are supported: ignore, and evaluate (`default     = "ignore"`).
- `principal_for_event_permission` -  The 12-digit AWS account ID that you are permitting to put events to your default event bus. Specify * to permit any account to put events to your default event bus (`default     = ""`).
- `statement_id_for_event_permission` - An identifier string for the external account that you are granting permissions to (`default     = "DevAccountAccess"`).
- `action_for_event_permission` - The action that you are enabling the other account to perform. Defaults to events:PutEvents (`default     = "events:PutEvents"`).
- `is_enabled_for_event_rule` - Whether the rule should be enabled (defaults to true) - (`default     = "true"`).
- `arn_for_cloudwatch_event_target` -  The Amazon Resource Name (ARN) of the rule (`default     = ""`).
- `target_id_for_cloudwatch_event_target` - target ID (`default     = "SendToSNS"`).
- `cloudwatch_dashboard_name` -  The name of the dashboard (`default     = ""`).
- `name_for_cloudwatch_log_group` - The name of the log group. If omitted, Terraform will assign a random, unique name (`default     = ""`).
- `retention_in_days_for_cloudwatch_log_group` - Specifies the number of days you want to retain log events in the specified log group (`default     = "0"`).
- `kms_key_id_for_cloudwatch_log_group` - The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested (`default     = ""`).
- `name_for_cloudwatch_log_metric_filter` - A name for the metric filter (`default     = "metric-filter"`).
- `pattern_for_cloudwatch_log_metric_filter` - A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events (`default     = ""`).
- `name_for_metric_transformation` - The name of the CloudWatch metric to which the monitored log information should be published (e.g. ErrorCount) - (`default     = "ErrorCount"`).
- `namespace_for_metric_transformation` - The destination namespace of the CloudWatch metric (`default     = "NameSpace"`).
- `value_for_metric_transformation` - What to publish to the metric. For example, if you're counting the occurrences of a particular term like 'Error', the value will be '1' for each occurrence. If you're counting the bytes transferred the published value will be the value in the log even (`default     = "1"`).                                                                                    
- `name_for_cloudwatch_log_stream` - The name of the log stream. Must not be longer than 512 characters and must not contain : (`default     = ""`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
