# Work with CLOUDWATCH via terraform

A terraform module for making CLOUDWATCH.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_cw_dashboard` - Enable cw_dashboard (`default = False`)
- `cw_dashboard_name` - The name of the dashboard. (`default = ""`)
- `cw_dashboard_body` - description (`default = ""`)
- `enable_cw_composite_alarm` - Enable cw composite alarm usage (`default = False`)
- `cw_composite_alarm_name` - The name for the composite alarm. This name must be unique within the region. (`default = ""`)
- `cw_composite_alarm_rule` - (Required) An expression that specifies which other alarms are to be evaluated to determine this composite alarm's state. For syntax, see Creating a Composite Alarm. The maximum length is 10240 characters. (`default = null`)
- `cw_composite_alarm_actions_enabled` - (Optional, Forces new resource) Indicates whether actions should be executed during any changes to the alarm state of the composite alarm. Defaults to true. (`default = null`)
- `cw_composite_alarm_description` - (Optional) The description for the composite alarm. (`default = null`)
- `cw_composite_alarm_actions` - (Optional) The set of actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed. (`default = null`)
- `cw_composite_alarm_ok_actions` - (Optional) The set of actions to execute when this alarm transitions to an OK state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed. (`default = null`)
- `cw_composite_alarm_insufficient_data_actions` - (Optional) The set of actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed. (`default = null`)
- `enable_cw_metric_alarm` - Enable metric alarm usage (`default = False`)
- `cw_metric_alarm_name` - The descriptive name for the alarm. This name must be unique within the user's AWS account (`default = ""`)
- `cw_metric_alarm_comparison_operator` - (Required) The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold. Additionally, the values LessThanLowerOrGreaterThanUpperThreshold, LessThanLowerThreshold, and GreaterThanUpperThreshold are used only for alarms based on anomaly detection models. (`default = null`)
- `cw_metric_alarm_evaluation_periods` - (Required) The number of periods over which data is compared to the specified threshold. (`default = null`)
- `cw_metric_alarm_metric_name` - (Optional) The name for the alarm's associated metric. See docs for supported metrics. (`default = null`)
- `cw_metric_alarm_namespace` - (Optional) The namespace for the alarm's associated metric. See docs for the list of namespaces. See docs for supported metrics. (`default = null`)
- `cw_metric_alarm_period` - (Optional) The period in seconds over which the specified statistic is applied. (`default = null`)
- `cw_metric_alarm_statistic` - (Optional) The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum (`default = null`)
- `cw_metric_alarm_threshold` - (Optional) The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models. (`default = null`)
- `cw_metric_alarm_threshold_metric_id` - (Optional) If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY_DETECTION_BAND function. (`default = null`)
- `cw_metric_alarm_actions_enabled` - (Optional) Indicates whether or not actions should be executed during any changes to the alarm's state. Defaults to true. (`default = null`)
- `cw_metric_alarm_actions` - (Optional) The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN). (`default = null`)
- `cw_metric_alarm_description` - Optional) The description for the alarm. (`default = null`)
- `cw_metric_alarm_datapoints_to_alarm` - (Optional) The number of datapoints that must be breaching to trigger the alarm. (`default = null`)
- `cw_metric_alarm_dimensions` - (Optional) The dimensions for the alarm's associated metric. For the list of available dimensions see the AWS documentation (`default = null`)
- `cw_metric_alarm_insufficient_data_actions` - (Optional) The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN). (`default = null`)
- `cw_metric_alarm_ok_actions` - (Optional) The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN). (`default = null`)
- `cw_metric_alarm_unit` - (Optional) The unit for the alarm's associated metric. (`default = null`)
- `cw_metric_alarm_extended_statistic` - (Optional) The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100. (`default = null`)
- `cw_metric_alarm_treat_missing_data` - (Optional) Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing. (`default = null`)
- `cw_metric_alarm_evaluate_low_sample_count_percentiles` - (Optional) Used only for alarms based on percentiles. If you specify ignore, the alarm state will not change during periods with too few data points to be statistically significant. If you specify evaluate or omit this parameter, the alarm will always be evaluated and possibly change state no matter how many data points are available. The following values are supported: ignore, and evaluate. (`default = null`)
- `cw_metric_alarm_metric_query` - (Optional) Enables you to create an alarm based on a metric math expression. You may specify at most 20. (`default = []`)
- `enable_cw_metric_stream` - Enable cw metric stream usage (`default = False`)
- `cw_metric_stream_firehose_arn` - (Required) ARN of the Amazon Kinesis Firehose delivery stream to use for this metric stream. (`default = null`)
- `cw_metric_stream_role_arn` - (Required) ARN of the IAM role that this metric stream will use to access Amazon Kinesis Firehose resources. For more information about role permissions, see Trust between CloudWatch and Kinesis Data Firehose. (`default = null`)
- `cw_metric_stream_output_format` - (Required) Output format for the stream. Possible values are json and opentelemetry0.7. For more information about output formats, see Metric streams output formats. (`default = null`)
- `cw_metric_stream_name` - (Optional, Forces new resource) Friendly name of the metric stream. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix (`default = null`)
- `cw_metric_stream_name_prefix` - (Optional, Forces new resource) Creates a unique friendly name beginning with the specified prefix. Conflicts with name (`default = null`)
- `cw_metric_stream_exclude_filter` - (Optional) List of exclusive metric filters. If you specify this parameter, the stream sends metrics from all metric namespaces except for the namespaces that you specify here. Conflicts with include_filter. (`default = []`)
- `cw_metric_stream_include_filter` - (Optional) List of inclusive metric filters. If you specify this parameter, the stream sends only the metrics from the metric namespaces that you specify here. Conflicts with exclude_filter. (`default = []`)

## Module Output Variables
----------------------
- `cw_dashboard_id` - The Amazon ID of the dashboard.
- `cw_dashboard_arn` - The Amazon Resource Name (ARN) of the dashboard.
- `cw_composite_alarm_id` - The ID of the composite alarm resource, which is equivalent to its alarm_name.
- `cw_composite_alarm_arn` - The ARN of the composite alarm.
- `cw_metric_alarm_id` - The ID of the health check.
- `cw_metric_alarm_arm` - The ARN of the CloudWatch Metric Alarm.
- `cw_metric_stream_id` - The ID of metric stream.
- `cw_metric_stream_arn` - ARN of the metric stream.
- `cw_metric_stream_creation_date` - Date and time in RFC3339 format that the metric stream was created.
- `cw_metric_stream_last_update_date` - Date and time in RFC3339 format that the metric stream was last updated.
- `cw_metric_stream_state` - State of the metric stream. Possible values are running and stopped.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
