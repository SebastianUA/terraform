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
  description = "Enable WAF ipset usage"
  default     = false
}

variable "waf_ipset_name" {
  description = "The name or description of the IPSet."
  default     = ""
}

variable "waf_ipset_ip_set_descriptors" {
  description = "(Optional) One or more pairs specifying the IP address type (IPV4 or IPV6) and the IP address range (in CIDR format) from which web requests originate."
  default     = []
}

#---------------------------------------------------
# AWS WAF rule
#---------------------------------------------------
variable "enable_waf_rule" {
  description = "Enable WAF rule usage"
  default     = false
}

variable "waf_rule_name" {
  description = "The name or description of the rule."
  default     = ""
}

variable "waf_rule_metric_name" {
  description = "(Required) The name or description for the Amazon CloudWatch metric of this rule. The name can contain only alphanumeric characters (A-Z, a-z, 0-9); the name can't contain whitespace."
  default     = ""
}

variable "waf_rule_predicates" {
  description = "(Optional) The objects to include in a rule"
  default     = []
}

#---------------------------------------------------
# AWS WAF rule group
#---------------------------------------------------
variable "enable_waf_rule_group" {
  description = "Enable waf rule group usage"
  default     = false
}

variable "waf_rule_group_name" {
  description = "A friendly name of the rule group"
  default     = ""
}

variable "waf_rule_group_metric_name" {
  description = "(Required) A friendly name for the metrics from the rule group"
  default     = ""
}

variable "waf_rule_group_activated_rule" {
  description = "(Optional) A list of activated rules"
  default     = []
}

#---------------------------------------------------
# AWS WAF web acl
#---------------------------------------------------
variable "enable_waf_web_acl" {
  description = "Enable waf web acl usage"
  default     = false
}

variable "waf_web_acl_name" {
  description = "The name or description of the web ACL."
  default     = ""
}

variable "waf_web_acl_metric_name" {
  description = "(Required) The name or description for the Amazon CloudWatch metric of this web ACL."
  default     = ""
}

variable "waf_web_acl_default_action" {
  description = "(Required) Configuration block with action that you want AWS WAF to take when a request doesn't match the criteria in any of the rules that are associated with the web ACL."
  default     = []
}

variable "waf_web_acl_rules" {
  description = "(Optional) Configuration blocks containing rules to associate with the web ACL and the settings for each rule."
  default     = []
}

variable "waf_web_acl_logging_configuration" {
  description = "(Optional) Configuration block to enable WAF logging."
  default     = []
}

#---------------------------------------------------
# AWS WAF rate based rule
#---------------------------------------------------
variable "enable_waf_rate_based_rule" {
  description = "Enable waf rate based rule usage"
  default     = false
}

variable "waf_rate_based_rule_name" {
  description = "The name or description of the rule."
  default     = ""
}

variable "waf_rate_based_rule_metric_name" {
  description = "(Required) The name or description for the Amazon CloudWatch metric of this rule."
  default     = ""
}

variable "waf_rate_based_rule_rate_key" {
  description = "(Required) Valid value is IP."
  default     = "IP"
}

variable "waf_rate_based_rule_rate_limit" {
  description = "(Required) The maximum number of requests, which have an identical value in the field specified by the RateKey, allowed in a five-minute period. Minimum value is 100."
  default     = 100
}

variable "waf_rate_based_rule_predicates" {
  description = "(Optional) The objects to include in a rule"
  default     = []
}

#---------------------------------------------------
# AWS WAF byte match set
#---------------------------------------------------
variable "enable_waf_byte_match_set" {
  description = "Enable waf byte match set usage"
  default     = false
}

variable "waf_byte_match_set_name" {
  description = "The name or description of the Byte Match Set."
  default     = ""
}

variable "waf_byte_match_set_byte_match_tuples" {
  description = "Specifies the bytes (typically a string that corresponds with ASCII characters) that you want to search for in web requests, the location in requests that you want to search, and other settings."
  default     = []
}

#---------------------------------------------------
# AWS WAF geo match set
#---------------------------------------------------
variable "enable_waf_geo_match_set" {
  description = "Enable waf geo match set usage"
  default     = false
}

variable "waf_geo_match_set_name" {
  description = "The name or description of the GeoMatchSet."
  default     = ""
}

variable "waf_geo_match_set_geo_match_constraint" {
  description = "(Optional) The GeoMatchConstraint objects which contain the country that you want AWS WAF to search for."
  default     = []
}

#---------------------------------------------------
# AWS WAF regex match set
#---------------------------------------------------
variable "enable_waf_regex_match_set" {
  description = "Enable waf regex match set usage"
  default     = false
}

variable "waf_regex_match_set_name" {
  description = "The name or description of the Regex Match Set."
  default     = ""
}

variable "waf_regex_match_set_regex_match_tuple" {
  description = "(Required) The regular expression pattern that you want AWS WAF to search for in web requests, the location in requests that you want AWS WAF to search, and other settings."
  default     = []
}

#---------------------------------------------------
# AWS WAF regex pattern set
#---------------------------------------------------
variable "enable_waf_regex_pattern_set" {
  description = "Enable waf regex pattern set usage"
  default     = false
}

variable "waf_regex_pattern_set_name" {
  description = "The name or description of the Regex Pattern Set."
  default     = ""
}

variable "waf_regex_pattern_set_regex_pattern_strings" {
  description = "(Optional) A list of regular expression (regex) patterns that you want AWS WAF to search for, such as B[a@]dB[o0]t."
  default     = []
}

#---------------------------------------------------
# AWS WAF size constraint set
#---------------------------------------------------
variable "enable_waf_size_constraint_set" {
  description = "Enable waf size constraint set usage"
  default     = false
}

variable "waf_size_constraint_set_name" {
  description = "The name or description of the Size Constraint Set."
  default     = ""
}

variable "waf_size_constraint_set_size_constraints" {
  description = "(Optional) Specifies the parts of web requests that you want to inspect the size of."
  default     = []
}

#---------------------------------------------------
# AWS WAF sql injection match set
#---------------------------------------------------
variable "enable_waf_sql_injection_match_set" {
  description = "Enable waf sql injection match set usage"
  default     = false
}

variable "waf_sql_injection_match_set_name" {
  description = "The name or description of the SQL Injection Match Set."
  default     = ""
}

variable "sql_injection_match_tuples" {
  description = "(Optional) The parts of web requests that you want AWS WAF to inspect for malicious SQL code and, if you want AWS WAF to inspect a header, the name of the header."
  default     = []
}

#---------------------------------------------------
# AWS WAF xss match set
#---------------------------------------------------
variable "enable_waf_xss_match_set" {
  description = "Enable waf xss match set usage"
  default     = false
}

variable "waf_xss_match_set_name" {
  description = "The name or description of the SizeConstraintSet."
  default     = ""
}

variable "waf_xss_match_set_xss_match_tuples" {
  description = "(Optional) The parts of web requests that you want to inspect for cross-site scripting attacks."
  default     = []
}
