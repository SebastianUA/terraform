#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#---------------------------------------------------
# Create AWS CloudWatch dashboard
#---------------------------------------------------
variable "enable_cw_dashboard" {
  description = "Enable cw_dashboard"
  default     = false
}

variable "cw_dashboard_name" {
  description = "The name of the dashboard."
  default     = ""
}

variable "cw_dashboard_body" {
  description = "description"
  default     = ""
}

#---------------------------------------------------
# cloudwatch composite alarm
#---------------------------------------------------
variable "enable_cw_composite_alarm" {
  description = "Enable cw composite alarm usage"
  default     = false
}

variable "cw_composite_alarm_name" {
  description = "The name for the composite alarm. This name must be unique within the region."
  default     = ""
}

variable "cw_composite_alarm_rule" {
  description = "(Required) An expression that specifies which other alarms are to be evaluated to determine this composite alarm's state. For syntax, see Creating a Composite Alarm. The maximum length is 10240 characters."
  default     = null
}

variable "cw_composite_alarm_actions_enabled" {
  description = "(Optional, Forces new resource) Indicates whether actions should be executed during any changes to the alarm state of the composite alarm. Defaults to true."
  default     = null
}

variable "cw_composite_alarm_description" {
  description = "(Optional) The description for the composite alarm."
  default     = null
}

variable "cw_composite_alarm_actions" {
  description = "(Optional) The set of actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed."
  default     = null
}

variable "cw_composite_alarm_ok_actions" {
  description = "(Optional) The set of actions to execute when this alarm transitions to an OK state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed."
  default     = null
}

variable "cw_composite_alarm_insufficient_data_actions" {
  description = "(Optional) The set of actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed."
  default     = null
}

#---------------------------------------------------
# Cloudwatch metric alarm
#---------------------------------------------------
variable "enable_cw_metric_alarm" {
  description = "Enable metric alarm usage"
  default     = false
}

variable "cw_metric_alarm_name" {
  description = "The descriptive name for the alarm. This name must be unique within the user's AWS account"
  default     = ""
}

variable "cw_metric_alarm_comparison_operator" {
  description = "(Required) The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold. Additionally, the values LessThanLowerOrGreaterThanUpperThreshold, LessThanLowerThreshold, and GreaterThanUpperThreshold are used only for alarms based on anomaly detection models."
  default     = null
}

variable "cw_metric_alarm_evaluation_periods" {
  description = "(Required) The number of periods over which data is compared to the specified threshold."
  default     = null
}

variable "cw_metric_alarm_metric_name" {
  description = "(Optional) The name for the alarm's associated metric. See docs for supported metrics."
  default     = null
}

variable "cw_metric_alarm_namespace" {
  description = "(Optional) The namespace for the alarm's associated metric. See docs for the list of namespaces. See docs for supported metrics."
  default     = null
}

variable "cw_metric_alarm_period" {
  description = "(Optional) The period in seconds over which the specified statistic is applied."
  default     = null
}

variable "cw_metric_alarm_statistic" {
  description = "(Optional) The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = null
}

variable "cw_metric_alarm_threshold" {
  description = "(Optional) The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models."
  default     = null
}

variable "cw_metric_alarm_threshold_metric_id" {
  description = "(Optional) If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY_DETECTION_BAND function."
  default     = null
}

variable "cw_metric_alarm_actions_enabled" {
  description = "(Optional) Indicates whether or not actions should be executed during any changes to the alarm's state. Defaults to true."
  default     = null
}

variable "cw_metric_alarm_actions" {
  description = "(Optional) The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN)."
  default     = null
}

variable "cw_metric_alarm_description" {
  description = "Optional) The description for the alarm."
  default     = null
}

variable "cw_metric_alarm_datapoints_to_alarm" {
  description = "(Optional) The number of datapoints that must be breaching to trigger the alarm."
  default     = null
}

variable "cw_metric_alarm_dimensions" {
  description = "(Optional) The dimensions for the alarm's associated metric. For the list of available dimensions see the AWS documentation"
  default     = null
}

variable "cw_metric_alarm_insufficient_data_actions" {
  description = "(Optional) The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN)."
  default     = null
}

variable "cw_metric_alarm_ok_actions" {
  description = "(Optional) The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN)."
  default     = null
}

variable "cw_metric_alarm_unit" {
  description = "(Optional) The unit for the alarm's associated metric."
  default     = null
}

variable "cw_metric_alarm_extended_statistic" {
  description = "(Optional) The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100."
  default     = null
}

variable "cw_metric_alarm_treat_missing_data" {
  description = "(Optional) Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing."
  default     = null
}

variable "cw_metric_alarm_evaluate_low_sample_count_percentiles" {
  description = "(Optional) Used only for alarms based on percentiles. If you specify ignore, the alarm state will not change during periods with too few data points to be statistically significant. If you specify evaluate or omit this parameter, the alarm will always be evaluated and possibly change state no matter how many data points are available. The following values are supported: ignore, and evaluate."
  default     = null
}

variable "cw_metric_alarm_metric_query" {
  description = "(Optional) Enables you to create an alarm based on a metric math expression. You may specify at most 20."
  default     = []
}

#---------------------------------------------------
# AWS CloudWatch metric stream
#---------------------------------------------------
variable "enable_cw_metric_stream" {
  description = "Enable cw metric stream usage"
  default     = false
}

variable "cw_metric_stream_firehose_arn" {
  description = "(Required) ARN of the Amazon Kinesis Firehose delivery stream to use for this metric stream."
  default     = null
}

variable "cw_metric_stream_role_arn" {
  description = "(Required) ARN of the IAM role that this metric stream will use to access Amazon Kinesis Firehose resources. For more information about role permissions, see Trust between CloudWatch and Kinesis Data Firehose."
  default     = null
}

variable "cw_metric_stream_output_format" {
  description = "(Required) Output format for the stream. Possible values are json and opentelemetry0.7. For more information about output formats, see Metric streams output formats."
  default     = null
}

variable "cw_metric_stream_name" {
  description = "(Optional, Forces new resource) Friendly name of the metric stream. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix"
  default     = null
}

variable "cw_metric_stream_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique friendly name beginning with the specified prefix. Conflicts with name"
  default     = null
}

variable "cw_metric_stream_exclude_filter" {
  description = "(Optional) List of exclusive metric filters. If you specify this parameter, the stream sends metrics from all metric namespaces except for the namespaces that you specify here. Conflicts with include_filter."
  default     = []
}

variable "cw_metric_stream_include_filter" {
  description = "(Optional) List of inclusive metric filters. If you specify this parameter, the stream sends only the metrics from the metric namespaces that you specify here. Conflicts with exclude_filter."
  default     = []
}

# variable "cw_metric_stream_statistics_configuration" {
#   description = "(Optional) For each entry in this array, you specify one or more metrics and the list of additional statistics to stream for those metrics. The additional statistics that you can stream depend on the stream's output_format. If the OutputFormat is json, you can stream any additional statistic that is supported by CloudWatch, listed in CloudWatch statistics definitions. If the OutputFormat is opentelemetry0.7, you can stream percentile statistics (p99 etc.)."
#   default     = []
# }
