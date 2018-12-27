variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "enable_compute_security_policy" {
    description = "Enable compute security policy usage"
    default     = "true"
}

variable "description" {
    description = "(Optional) An optional description of this security policy. Max size is 2048."
    default     = ""
}

variable "rule_action" {
    description = "(Required) Action to take when match matches the request. Valid values: 'allow': allow access to target; 'deny(status)': deny access to target, returns the HTTP response code specified (valid values are 403, 404 and 502)"
    default     = "allow"
}

variable "rule_priority" {
    description = "(Required) An unique positive integer indicating the priority of evaluation for a rule. Rules are evaluated from highest priority (lowest numerically) to lowest priority (highest numerically) in order."
    default     = "2147483647"
}

variable "rule_description" {
    description = "(Optional) An optional description of this rule. Max size is 64."
    default     = ""
}

variable "rule_preview" {
    description = "(Optional) When set to true, the action specified above is not enforced. Stackdriver logs for requests that trigger a preview action are annotated as such."
    default     = ""
}

variable "match_versioned_expr" {
    description = "(Required) Predefined rule expression. Available options: SRC_IPS_V1: Must specify the corresponding src_ip_ranges field in config."
    default     = "SRC_IPS_V1"
}

variable "match_config_src_ip_ranges" {
    description = "(Required) Set of IP addresses or ranges (IPV4 or IPV6) in CIDR notation to match against inbound traffic. There is a limit of 5 IP ranges per rule. A value of '*' matches all IPs (can be used to override the default behavior)."
    default     = ["*"]
}

variable "rule" {
    description = "(Optional) The set of rules that belong to this policy. There must always be a default rule (rule with priority 2147483647 and match '*'). If no rules are provided when creating a security policy, a default rule with action 'allow' will be added. Structure is documented below."
    default     = []
}
