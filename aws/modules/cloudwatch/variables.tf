#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-RDS"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
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
    default     = "2"
}

variable "metric_name" {
    description = "The name for the alarm's associated metric (ex: CPUUtilization)"
    default     = "CPUUtilization"
}

variable "namespace" {
    description = "The namespace for the alarm's associated metric (ex: AWS/EC2)"
    default     = "AWS/EC2"
}    

variable "period" {
    description = "The period in seconds over which the specified statistic is applied."
    default     = "120"
}

variable "statistic" {
    description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
    default     = "Average"
}

variable "threshold" {
    description = "The value against which the specified statistic is compared"
    default     = "80"
}

variable "actions_enabled" {
    description = "Indicates whether or not actions should be executed during any changes to the alarm's state. Defaults to true."
    default     = "true"
}

variable "alarm_actions" {
    description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
    type        = "list"
    default     = []
}

variable "alarm_description" {
    description = "The description for the alarm."
    default     = ""
}

variable "datapoints_to_alarm" {
    description = "The number of datapoints that must be breaching to trigger the alarm."
    default     = "0"
}

variable "dimensions" {
    description = "List of the dimensions for the alarm's associated metric"
    type        = "list"
    default     = []
}

variable "insufficient_data_actions" {
    description = "The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
    type        = "list"
    default     = []
}

variable "ok_actions" {
    description = "The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN)."
    type        = "list"
    default     = []
}

variable "unit" {
    description = "The unit for the alarm's associated metric."
    default     = ""
}

variable "extended_statistic" {
    description = "The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100."
    default     = "p100"
}

variable "treat_missing_data" {
    description = "Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing."
    default     = "missing"
}

variable "evaluate_low_sample_count_percentiles" {
    description = "Used only for alarms based on percentiles. If you specify ignore, the alarm state will not change during periods with too few data points to be statistically significant. If you specify evaluate or omit this parameter, the alarm will always be evaluated and possibly change state no matter how many data points are available. The following values are supported: ignore, and evaluate."
    default     = "ignore"
}

variable "principal_for_event_permission" { 
    description = "The 12-digit AWS account ID that you are permitting to put events to your default event bus. Specify * to permit any account to put events to your default event bus."
    default     = ""
}

variable "statement_id_for_event_permission" {
    description = "An identifier string for the external account that you are granting permissions to."
    default     = "DevAccountAccess"
}

variable "action_for_event_permission" {
    description = "The action that you are enabling the other account to perform. Defaults to events:PutEvents."
    default     = "events:PutEvents"
}

variable "is_enabled_for_event_rule" {
    description = "Whether the rule should be enabled (defaults to true)."
    default     = "true"
}

variable "arn_for_cloudwatch_event_target" {
    description = "The Amazon Resource Name (ARN) of the rule."
    default     = ""
}

variable "target_id_for_cloudwatch_event_target" {
    description = "target ID"
    default     = "SendToSNS"
}

variable "cloudwatch_dashboard_name" { 
    description = "The name of the dashboard."
    default     = ""
}
variable "name_for_cloudwatch_log_group" {
    description = "The name of the log group. If omitted, Terraform will assign a random, unique name."
    default     = ""
}

variable "retention_in_days_for_cloudwatch_log_group" {
    description = "Specifies the number of days you want to retain log events in the specified log group."
    default     = "0"
}

variable "kms_key_id_for_cloudwatch_log_group" {
    description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
    default     = ""
}

variable "name_for_cloudwatch_log_metric_filter" {
    description = "A name for the metric filter."
    default     = "metric-filter"
}

variable "pattern_for_cloudwatch_log_metric_filter" {
    description = "A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events."
    default     = ""
}

variable "name_for_metric_transformation" {
    description = "The name of the CloudWatch metric to which the monitored log information should be published (e.g. ErrorCount)"
    default     = "ErrorCount"
}

variable "namespace_for_metric_transformation" {
    description = "The destination namespace of the CloudWatch metric."
    default     = "NameSpace"
}

variable "value_for_metric_transformation" {                                                                                    
    description = "What to publish to the metric. For example, if you're counting the occurrences of a particular term like 'Error', the value will be '1' for each occurrence. If you're counting the bytes transferred the published value will be the value in the log event."
    default     = "1"
}

variable "name_for_cloudwatch_log_stream" {
    description = "The name of the log stream. Must not be longer than 512 characters and must not contain :"
    default     = ""
}

