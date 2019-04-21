#-----------------------------------------------------------
# Global 
#-----------------------------------------------------------
variable "name" {
    description = "The name for newrelic_alert resources"
    default     = "test"
}   

variable "environment" {
    description = "environment"
    default     = "prod"
}

#-----------------------------------------------------------
# newrelic_infra_alert_condition
#-----------------------------------------------------------
variable "infra_alert_condition" {
    description = "Enable newrelic_infra_alert_condition"
    default     = "false"
}

variable "infra_alert_condition_policy_id" {
    description = "(Required) The ID of the alert policy where this condition should be used."
    default     = ""
}

variable "infra_alert_condition_name" {
    description = "(Required) The Infrastructure alert condition's name."
    default     = ""
}

variable "infra_alert_condition_type" {
    description = "(Required) The type of Infrastructure alert condition: 'infra_process_running', 'infra_metric', or 'infra_host_not_reporting'."
    default     = "infra_metric"
}

variable "infra_alert_condition_event" {
    description = "(Required) The metric event; for example, system metrics, process metrics, storage metrics, or network metrics."
    default     = ""
}

variable "infra_alert_condition_select" {
    description = "(Required) The attribute name to identify the type of metric condition; for example, 'network', 'process', 'system', or 'storage'."
    default     = "system"
}

variable "infra_alert_condition_comparison" {
    description = "(Required) The operator used to evaluate the threshold value; 'above', 'below', 'equal'."
    default     = "equal"
}

variable "infra_alert_condition_enabled" {
    description = "(Optional) Set whether to enable the alert condition. Defaults to true."
    default     = "true"
}

variable "infra_alert_condition_where" {
    description = "(Optional) Infrastructure host filter for the alert condition."
    default     = ""
}

variable "infra_alert_condition_process_where" {
    description = "(Optional) Any filters applied to processes; for example: commandName = 'java'."
    default     = ""
}

variable "infra_alert_condition_integration_provider" {
    description = "(Optional) For alerts on integrations, use this instead of event."
    default     = ""
}


variable "infra_alert_condition_critical_duration" {
    description = "(Required) Identifies the number of minutes the threshold must be passed or met for the alert to trigger. Threshold durations must be between 1 and 60 minutes (inclusive)."
    default     = 1
}

variable "infra_alert_condition_critical_value" {
    description = "(Optional) Threshold value, computed against the comparison operator. Supported by 'infra_metric' and 'infra_process_running' alert condition types."
    default     = 1
}

variable "infra_alert_condition_critical_time_function" {
    description = "(Optional) Indicates if the condition needs to be sustained or to just break the threshold once; all or any. Supported by the 'infra_metric' alert condition type."
    default     = "all"
}

#-----------------------------------------------------------
# newrelic_infra_alert_condition with warning
#-----------------------------------------------------------
variable "infra_alert_condition_with_warning" {
    description = "Enable newrelic_infra_alert_condition with warning usage"
    default     = "false"
}

variable "infra_alert_condition_warning_duration" {
    description = "(Required) Identifies the number of minutes the threshold must be passed or met for the alert to trigger. Threshold durations must be between 1 and 60 minutes (inclusive)."
    default     = 1
}

variable "infra_alert_condition_warning_value" {
    description = "(Optional) Threshold value, computed against the comparison operator. Supported by 'infra_metric' and 'infra_process_running' alert condition types."
    default     = 1
}

variable "infra_alert_condition_warning_time_function" {
    description = "(Optional) Indicates if the condition needs to be sustained or to just break the threshold once; all or any. Supported by the 'infra_metric' alert condition type."
    default     = "all"
}
