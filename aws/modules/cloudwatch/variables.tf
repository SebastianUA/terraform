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

#-----------------------------------------------------------
# AWS cloudwatch metric
#-----------------------------------------------------------
variable "enable_cw_metric_alarm" {
  description = "Enable cw_metric_alarm usage"
  default     = false
}

variable "alarm_name" {
  description = "The descriptive name for the alarm. This name must be unique within the user's AWS account"
  default     = ""
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  default     = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  default     = 2
}

variable "metric_name" {
  description = "The name for the alarm's associated metric (ex: CPUUtilization)"
  default     = null
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric (ex: AWS/EC2)"
  default     = null
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
  default     = null
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = null
}

variable "threshold" {
  description = "The value against which the specified statistic is compared"
  default     = 80
}

variable "unit" {
  description = "(Optional) The unit for the alarm's associated metric."
  default     = null
}

# variable "metric" {
#   description = "(Optional) The metric to be returned, along with statistics, period, and units. Use this parameter only if this object is retrieving a metric and not performing a math expression on returned data."
#   default     = []
# }

variable "metric_query" {
  description = "(Optional) Enables you to create an alarm based on a metric math expression. You may specify at most 20."
  default     = []
}

variable "actions_enabled" {
  description = "Indicates whether or not actions should be executed during any changes to the alarm's state. Defaults to true."
  default     = true
}

variable "alarm_actions" {
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
  default     = []
}

variable "alarm_description" {
  description = "The description for the alarm."
  default     = null
}

variable "datapoints_to_alarm" {
  description = "The number of datapoints that must be breaching to trigger the alarm."
  default     = null
}

variable "dimensions" {
  description = "(Optional) The dimensions for the alarm's associated metric. For the list of available dimensions see the AWS documentation"
  default     = null
}

variable "insufficient_data_actions" {
  description = "The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
  default     = []
}

variable "ok_actions" {
  description = "The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
  default     = []
}

variable "extended_statistic" {
  description = "The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100."
  default     = null
}

variable "treat_missing_data" {
  description = "Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing."
  default     = "missing"
}

variable "evaluate_low_sample_count_percentiles" {
  description = "Used only for alarms based on percentiles. If you specify ignore, the alarm state will not change during periods with too few data points to be statistically significant. If you specify evaluate or omit this parameter, the alarm will always be evaluated and possibly change state no matter how many data points are available. The following values are supported: ignore, and evaluate."
  default     = null
}

#-----------------------------------------------------------
# AWS cloudwatch event
#-----------------------------------------------------------
variable "enable_cw_event_permission" {
  description = "Enable cw_event_permission usage"
  default     = false
}

variable "cw_event_permission_principal" {
  description = "The 12-digit AWS account ID that you are permitting to put events to your default event bus. Specify * to permit any account to put events to your default event bus."
  default     = ""
}

variable "cw_event_permission_statement_id" {
  description = "An identifier string for the external account that you are granting permissions to."
  default     = "DevAccountAccess"
}

variable "cw_event_permission_action" {
  description = "The action that you are enabling the other account to perform. Defaults to events:PutEvents."
  default     = "events:PutEvents"
}

variable "is_enabled_for_event_rule" {
  description = "Whether the rule should be enabled (defaults to true)."
  default     = true
}

variable "cw_event_rule_event_pattern" {
  description = "description"
  default     = ""
}

variable "enable_cw_event_rule" {
  description = "Enable cw_event_rule usage"
  default     = false
}

variable "enbale_cw_event_target" {
  description = "Enable enbale_cw_event_target usage"
  default     = false
}

variable "cw_event_target_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  default     = ""
}

variable "cw_event_rule_name" {
  description = "description"
  default     = ""
}

variable "cw_event_rule_description" {
  description = "description"
  default     = ""
}

variable "cw_event_target_target_id" {
  description = "target ID"
  default     = "SendToSNS"
}

#---------------------------------------------------
# Create AWS CloudWatch LOG
#---------------------------------------------------
variable "enable_cw_log_group" {
  description = "Enable cw_log_group usage"
  default     = false
}

variable "enable_cw_log_stream" {
  description = "Enable cw_log_stream usage"
  default     = false
}

variable "enable_cw_log_metric_filter" {
  description = "Enable cw_log_metric_filter usage"
  default     = false
}

variable "cw_log_group" {
  description = "Enable cw_log_group usage"
  default     = false
}

variable "cw_log_group_name" {
  description = "The name of the log group. If omitted, Terraform will assign a random, unique name."
  default     = ""
}

variable "cw_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group."
  default     = 0
}

variable "cw_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  default     = ""
}

variable "cw_log_metric_filter_name" {
  description = "A name for the metric filter."
  default     = "metric-filter"
}

variable "cw_log_metric_filter_pattern" {
  description = "A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events."
  default     = ""
}

variable "cw_log_metric_filter_metric_transformation" {
  description = "(Required) A block defining collection of information needed to define how metric data gets emitted."
  default     = []
}

variable "cloudwatch_log_stream_name" {
  description = "The name of the log stream. Must not be longer than 512 characters and must not contain :"
  default     = ""
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
