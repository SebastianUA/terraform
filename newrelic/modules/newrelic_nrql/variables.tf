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
# newrelic_nrql_alert_condition
#-----------------------------------------------------------
variable "nrql_alert_condition" {
    description = "Enable newrelic_nrql_alert_condition"
    default     = "false"
}

variable "nrql_alert_condition_name" {
    description = "(Required) The title of the condition"
    default     = ""
}

variable "nrql_alert_condition_policy_id" {
    description = "(Required) The ID of the policy where this condition should be used."
    default     = ""
}

variable "nrql_alert_condition_runbook_url" {
    description = "(Optional) Runbook URL to display in notifications."
    default     = ""
}

variable "nrql_alert_condition_enabled" {
    description = "(Optional) Set whether to enable the alert condition. Defaults to true."
    default     = "true"
}

variable "nrql_alert_condition_value_function" {
    description = "(Optional) Possible values are single_value, sum."
    default     = "single_value"
}

variable "nrql_alert_condition_term_duration" {
    description = "(Required) In minutes, must be: 1, 2, 3, 4, 5, 10, 15, 30, 60, or 120."
    default     = 5
}

variable "nrql_alert_condition_term_operator" {
    description = "(Optional) above, below, or equal. Defaults to equal."
    default     = "equal"
}

variable "nrql_alert_condition_term_priority" {
    description = "(Optional) critical or warning. Defaults to critical."
    default     = "critical"
}

variable "nrql_alert_condition_term_threshold" {
    description = "(Required) Must be 0 or greater."
    default     = 0
}

variable "nrql_alert_condition_term_time_function" {
    description = "(Required) all or any."
    default     = "all"
}


variable "nrql_alert_condition_nrql_query" {
    description = "(Required) The NRQL query to execute for the condition."
    default     = ""
}

variable "nrql_alert_condition_nrql_since_value" {
    description = "(Required) The value to be used in the SINCE <X> MINUTES AGO clause for the NRQL query. Must be: 1, 2, 3, 4, or 5."
    default     = 1
}
