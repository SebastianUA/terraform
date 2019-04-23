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
# newrelic_alert_channel
#-----------------------------------------------------------
variable "alert_channel" {
    description = "Enable newrelic alert channel at general"
    default     = "false"
}

#-----------------------------------------------------------
# newrelic_alert_channel_campfire
#-----------------------------------------------------------
variable "alert_channel_campfire" {
    description = "Enable newrelic alert channel campfire usage"
    default     = "false"
}

variable "alert_channel_campfire_name" {
    description = "Set custom name for newrelic_alert_channel"
    default     = ""
}

variable "alert_channel_campfire_configuration_room" {
    description = "Set room"
    default     = ""
}

variable "alert_channel_campfire_configuration_subdomain" {
    description = "Set subdomain"
    default     = ""
}

variable "alert_channel_campfire_configuration_token" {
    description = "Set token"
    default     = ""
}

#-----------------------------------------------------------
# newrelic_alert_channel_email
#-----------------------------------------------------------
variable "alert_channel_email" {
    description = "Enable newrelic alert channel email usage"
    default     = "false"
}

variable "alert_channel_email_name" {
    description = "Set custom name for newrelic_alert_channel"
    default     = ""
}

variable "alert_channel_email_configuration_recipients" {
    description = "Set reemail. In this case, its - email address"
    default     = ""
}

variable "alert_channel_email_configuration_include_json_attachment" {
    description = "Set include_json_attachment"
    default     = "true"
}

#-----------------------------------------------------------
# newrelic_alert_channel_opsgenie
#-----------------------------------------------------------
variable "alert_channel_opsgenie" {
    description = "Enable newrelic alert channel opsgenie"
    default     = "false"
}

variable "alert_channel_opsgenie_name" {
    description = "Set custom name for newrelic_alert_channel"
    default     = ""
}

variable "alert_channel_opsgenie_configuration_api_key" {
    description = "Set api_key"
    default     = ""
}

variable "alert_channel_opsgenie_configuration_recipients" {
    description = "Set reemail. In this case, its - email address"
    default     = ""
}

variable "alert_channel_opsgenie_configuration_tags" {
    description = "Set tags"
    type        = "list"
    default     = []
}


variable "alert_channel_opsgenie_configuration_teams" {
    description = "Set teams"
    type        = "list"
    default     = []
}

#-----------------------------------------------------------
# newrelic_alert_channel_pagerduty
#-----------------------------------------------------------
variable "alert_channel_pagerduty" {
    description = "Enable newrelic alert channel pagerduty usage"
    default     = "false"
}

variable "alert_channel_pagerduty_name" {
    description = "Set custom name for newrelic_alert_channel"
    default     = ""
}

variable "alert_channel_pagerduty_configuration_service_key" {
    description = "Set service_key"
    default     = ""
}

#-----------------------------------------------------------
# newrelic_alert_channel_slack
#-----------------------------------------------------------
variable "alert_channel_slack" {
    description = "Enable newrelic alert channel slack usage"
    default     = "false"
}

variable "alert_channel_slack_name" {
    description = "Set custom name for newrelic_alert_channel"
    default     = ""
}

variable "alert_channel_slack_configuration_channel" {
    description = "Set channel"
    default     = ""
}

variable "alert_channel_slack_configuration_url" {
    description = "Set url"
    default     = 1
}

#-----------------------------------------------------------
# newrelic_alert_channel_user
#-----------------------------------------------------------
variable "alert_channel_user" {
    description = "Enable newrelic alert channel user usage"
    default     = "false"
}

variable "alert_channel_user_name" {
    description = "Set custom name for newrelic_alert_channel"
    default     = ""
}

variable "alert_channel_user_configuration_user_id" {
    description = "Set user_id"
    default     = ""
}

#-----------------------------------------------------------
# newrelic_alert_channel_victorops
#-----------------------------------------------------------
variable "alert_channel_victorops" {
    description = "Enable newrelic alert channel victorops usage"
    default     = "false"
}

variable "alert_channel_victorops_name" {
    description = "Set custom name for newrelic_alert_channel"
    default     = ""
}

variable "alert_channel_victorops_configuration_key" {
    description = "Set key"
    default     = ""
}

variable "alert_channel_victorops_configuration_route_key" {
    description = "Set route_key"
    default     = ""
}

#-----------------------------------------------------------
# newrelic_alert_channel_webhook
#-----------------------------------------------------------
variable "alert_channel_webhook" {
    description = "Enable newrelic alert channel webhook usage"
    default     = "false"
}

variable "alert_channel_webhook_name" {
    description = "Set custom name for newrelic_alert_channel"
    default     = ""
}

variable "alert_channel_webhook_configuration_auth_password" {
    description = "Set auth_password"
    default     = ""
}

variable "alert_channel_webhook_configuration_auth_type" {
    description = "Set auth_type"
    default     = ""
}

variable "alert_channel_webhook_configuration_auth_username" {
    description = "Set auth_username"
    default     = ""
}

variable "alert_channel_webhook_configuration_base_url" {
    description = "Set base_url"
    default     = ""
}

variable "alert_channel_webhook_configuration_headers" {
    description = "Set headers"
    type        = "list" 
    default     = []
}

variable "alert_channel_webhook_configuration_payload_type" {
    description = "Set type"
    default     = ""
}

variable "alert_channel_webhook_configuration_payload" {
    type        = "list"
    default     = []
}

#-----------------------------------------------------------
# newrelic_alert_policy
#-----------------------------------------------------------

variable "alert_policy" {
    description = "Enable newrelic_alert_policy usage"
    default     = "false"
}

variable "alert_policy_name" {
    description = "Set custom name for newrelic_alert_policy"
    default     = ""
}

variable "alert_policy_incident_preference" {
    description = "(Optional) The rollup strategy for the policy. Options include: PER_POLICY, PER_CONDITION, or PER_CONDITION_AND_TARGET. The default is PER_POLICY."
    default     = "PER_POLICY"
}
 
variable "alert_policy_simple_default" {
    description = "Enable newrelic_alert_policy_simple_default"
    default     = "false"
}

variable "alert_policy_simple_default_name" {
    description = "Name"
    default     = ""
}

#-----------------------------------------------------------
# newrelic_alert_condition
#-----------------------------------------------------------

variable "alert_condition" {
    description = "Enable newrelic_alert_condition"
    default     = "false"
}

variable "alert_condition_policy_id" {
    description = "(Required) The ID of the policy where this condition should be used."
    default     = ""
}

variable "alert_condition_name" {
    description = "(Required) The title of the condition"
    default     = ""
}

variable "alert_condition_type" {
    description = "(Required) The type of condition. One of: apm_app_metric, apm_jvm_metric, apm_kt_metric, servers_metric, browser_metric, mobile_metric"
    default     = "apm_app_metric"
}

variable "alert_condition_entities" {
    description = "(Required) The instance IDS associated with this condition."
    type        = "list"
    default     = []
}

variable "alert_condition_metric" {
    description = "(Required) The metric field accepts parameters based on the `type` set. Ex: `apdex`, `error_percentage`, `response_time_web`, `response_time_background`, `throughput_web`, `throughput_background`, `user_defined`"
    default     = "apdex"
}

#"apm_app_metric": {
#		"apdex",
#		"error_percentage",
#		"response_time_background",
#		"response_time_web",
#		"throughput_background",
#		"throughput_web",
#		"user_defined",
#	},
#	"apm_jvm_metric": {
#		"cpu_utilization_time",
#		"deadlocked_threads",
#		"gc_cpu_time",
#		"heap_memory_usage",
#	},
#	"apm_kt_metric": {
#		"apdex",
#		"error_count",
#		"error_percentage",
#		"response_time",
#		"throughput",
#	},
#	"browser_metric": {
#		"ajax_response_time",
#		"ajax_throughput",
#		"dom_processing",
#		"end_user_apdex",
#		"network",
#		"page_rendering",
#		"page_view_throughput",
#		"page_views_with_js_errors",
#		"request_queuing",
#		"total_page_load",
#		"user_defined",
#		"web_application",
#	},
#	"mobile_metric": {
#		"database",
#		"images",
#		"json",
#		"mobile_crash_rate",
#		"network_error_percentage",
#		"network",
#		"status_error_percentage",
#		"user_defined",
#		"view_loading",
#	},
#	"servers_metric": {
#		"cpu_percentage",
#		"disk_io_percentage",
#		"fullest_disk_percentage",
#		"load_average_one_minute",
#		"memory_percentage",
#		"user_defined",
#	},


variable "alert_condition_gc_metric" {
    description = "(Optional) A valid Garbage Collection metric e.g. GC/G1 Young Generation. This is required if you are using apm_jvm_metric with gc_cpu_time condition type."
    default     = "GC/G1 Young Generation"
}

variable "alert_condition_violation_close_timer" {
    description = "(Optional) Automatically close instance-based violations, including JVM health metric violations, after the number of hours specified. Must be: 1, 2, 4, 8, 12 or 24."
    default     = 1
}

variable "alert_condition_runbook_url" {
    description = "(Optional) Runbook URL to display in notifications."
    default     = ""
}

variable "alert_condition_condition_scope" {
    description = "(Optional) instance or application. This is required if you are using the JVM plugin in New Relic."
    default     = "application"
}

variable "alert_condition_user_defined_metric" {
    description = "(Optional) A custom metric to be evaluated."
    default     = ""
}

variable "alert_condition_user_defined_value_function" {
    description = "(Optional) One of: average, min, max, total, or sample_size."
    default     = "average"
}

variable "alert_condition_term_duration" {
    description = "(Required) In minutes, must be: 5, 10, 15, 30, 60, or 120."
    default     = 5
}

variable "alert_condition_term_operator" {
    description = "(Optional) above, below, or equal. Defaults to equal."
    default     = "equal"
}

variable "alert_condition_term_priority" {
    description = "(Optional) critical or warning. Defaults to critical."
    default     = "critical"
}

variable "alert_condition_term_threshold" {
    description = "(Required) Must be 0 or greater."
    default     = 0
}

variable "alert_condition_term_time_function" {
    description = "(Required) all or any."
    default     = "all"
}

#-----------------------------------------------------------
# newrelic_alert_policy_channel
#-----------------------------------------------------------
variable "alert_policy_channel" {
    description = "Enable newrelic_alert_policy_channel"
    default     = "false"
}

variable "alert_policy_policy_id" {
    description = "(Required) The ID of the policy."
    default     = ""
}

variable "alert_policy_channel_id" {
    description = "(Required) The ID of the channel."
    default     = ""
}
