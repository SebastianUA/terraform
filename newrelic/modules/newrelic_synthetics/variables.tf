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
variable "synthetics_alert_condition" {
    description = "Enable synthetics_alert_condition"
    default     = "false"
}

variable "synthetics_alert_condition_name" {
    description = "(Required) The title of the condition"
    default     = ""
}

variable "synthetics_alert_condition_policy_id" {
    description = "(Required) The ID of the policy where this condition should be used."
    default     = ""
}

variable "synthetics_monitor_name" {
    description = " (Required) The title of this condition."
    default     = ""
}

variable "synthetics_alert_condition_runbook_url" {
    description = "(Optional) Runbook URL to display in notifications."
    default     = ""
}

variable "synthetics_alert_condition_enabled" {
    description = "(Optional) Set whether to enable the alert condition. Defaults to true."
    default     = "true"
}
