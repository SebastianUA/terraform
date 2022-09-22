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

variable "cloudwatch_log_stream_names" {
  description = "The names of the log stream. Must not be longer than 512 characters and must not contain :"
  default     = []
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
