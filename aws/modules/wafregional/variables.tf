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
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#---------------------------------------------------
# AWS WAF ipset
#---------------------------------------------------
variable "enable_waf_ipset" {
  description   = "Enable WAF ipset usage"
  default       = false
}

variable "waf_ipset_name" {
  description   = "The name or description of the IPSet."
  default       = ""
}

variable "waf_ipset_ip_set_descriptors" {
  description   = "(Optional) One or more pairs specifying the IP address type (IPV4 or IPV6) and the IP address range (in CIDR format) from which web requests originate."
  default       = []
}

#---------------------------------------------------
# AWS wafregional ipset
#---------------------------------------------------



#---------------------------------------------------
# AWS WAF rule
#---------------------------------------------------
variable "enable_waf_rule" {
  description   = "Enable WAF rule usage"
  default       = false
}

variable "waf_rule_name" {
  description   = "The name or description of the rule."
  default       = ""
}

variable "waf_rule_metric_name" {
  description   = "(Required) The name or description for the Amazon CloudWatch metric of this rule. The name can contain only alphanumeric characters (A-Z, a-z, 0-9); the name can't contain whitespace."
  default       = ""
}

variable "waf_rule_predicates" {
  description   = "(Optional) The objects to include in a rule"
  default       = []
}

#---------------------------------------------------
# AWS WAF rule group
#---------------------------------------------------
variable "enable_waf_rule_group" {
  description   = "Enable waf rule group usage"
  default       = false
}

variable "waf_rule_group_name" {
  description   = "A friendly name of the rule group"
  default       = ""
}

variable "waf_rule_group_metric_name" {
  description   = "(Required) A friendly name for the metrics from the rule group"
  default       = ""
}

variable "activated_rule_action_type" {
  description   = "(Required) e.g. BLOCK, ALLOW, or COUNT"
  default       = "COUNT"
}

variable "activated_rule_priority" {
  description   = "(Required) Specifies the order in which the rules are evaluated. Rules with a lower value are evaluated before rules with a higher value."
  default       = 50
}

variable "activated_rule_rule_id" {
  description   = "(Required) The ID of a rule"
  default       = ""
}

variable "activated_rule_type" {
  description   = "(Optional) The rule type, either REGULAR, RATE_BASED, or GROUP. Defaults to REGULAR."
  default       = "REGULAR"
}
