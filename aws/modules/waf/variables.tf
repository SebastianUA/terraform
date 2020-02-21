#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
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

#---------------------------------------------------
# AWS WAF web acl
#---------------------------------------------------
variable "enable_waf_web_acl" {
  description   = "Enable waf web acl usage"
  default       = false
}

variable "waf_web_acl_name" {
  description   = "The name or description of the web ACL."
  default       = ""
}

variable "waf_web_acl_metric_name" {
  description   = "(Required) The name or description for the Amazon CloudWatch metric of this web ACL."
  default       = ""
}

variable "waf_web_acl_default_action_type" {
  description   = "(Required) Specifies how you want AWS WAF to respond to requests that don't match the criteria in any of the rules. e.g. ALLOW, BLOCK or COUNT"
  default       = "COUNT"
}

variable "waf_web_acl_rules_action_type" {
  description   = "(Required) valid values are: BLOCK, ALLOW, or COUNT"
  default       = "COUNT"
}

variable "waf_web_acl_rules_override_action_type" {
  description   = "(Required) valid values are: NONE or COUNT"
  default       = "COUNT"
}

variable "waf_web_acl_rules_priority" {
  description   = "(Required) Specifies the order in which the rules in a WebACL are evaluated. Rules with a lower value are evaluated before rules with a higher value."
  default       = 1
}

variable "waf_web_acl_rules_rule_id" {
  description   = "ID of the associated WAF (Global) rule (e.g. aws_waf_rule). WAF (Regional) rules cannot be used."
  default       = ""
}

variable "waf_web_acl_rules_type" {
  description   = "(Optional) The rule type, either REGULAR, as defined by Rule, RATE_BASED, as defined by RateBasedRule, or GROUP, as defined by RuleGroup. The default is REGULAR. If you add a RATE_BASED rule, you need to set type as RATE_BASED. If you add a GROUP rule, you need to set type as GROUP."
  default       = "REGULAR"
}

variable "logging_configuration_log_destination" {
  description   = "(Required) Amazon Resource Name (ARN) of Kinesis Firehose Delivery Stream"
  default       = ""
}

variable "logging_configuration_redacted_fields_field_to_match_type" {
  description   = "(Required) The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER or METHOD"
  default       = "HEADER"
}

variable "logging_configuration_redacted_fields_field_to_match_data" {
  description   = "(Optional) When the value of type is HEADER, enter the name of the header that you want the WAF to search, for example, User-Agent or Referer. If the value of type is any other value, omit data."
  default       = null
}

#---------------------------------------------------
# AWS WAF rate based rule
#---------------------------------------------------
variable "enable_waf_rate_based_rule" {
  description   = "Enable waf rate based rule usage"
  default       = false
}

variable "waf_rate_based_rule_name" {
  description   = "The name or description of the rule."
  default       = ""
}

variable "waf_rate_based_rule_metric_name" {
  description   = "(Required) The name or description for the Amazon CloudWatch metric of this rule."
  default       = ""
}

variable "waf_rate_based_rule_rate_key" {
  description   = "(Required) Valid value is IP."
  default       = "IP"
}

variable "waf_rate_based_rule_rate_limit" {
  description   = "(Required) The maximum number of requests, which have an identical value in the field specified by the RateKey, allowed in a five-minute period. Minimum value is 100."
  default       = 100
}

variable "waf_rate_based_rule_predicates" {
  description   = "(Optional) The objects to include in a rule"
  default       = []
}

#---------------------------------------------------
# AWS WAF byte match set
#---------------------------------------------------
variable "enable_waf_byte_match_set" {
  description   = "Enable waf byte match set usage"
  default       = false
}

variable "waf_byte_match_set_name" {
  description   = "The name or description of the Byte Match Set."
  default       = ""
}

variable "byte_match_tuples_text_transformation" {
  description   = "(Required) Text transformations used to eliminate unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. If you specify a transformation, AWS WAF performs the transformation on target_string before inspecting a request for a match. e.g. CMD_LINE, HTML_ENTITY_DECODE or NONE. See docs for all supported values."
  default       = "NONE"
}

variable "byte_match_tuples_target_string" {
  description   = "(Optional) The value that you want to search for. e.g. HEADER, METHOD or BODY. See docs for all supported values."
  default       = null
}

variable "byte_match_tuples_positional_constraint" {
  description   = "(Required) Within the portion of a web request that you want to search (for example, in the query string, if any), specify where you want to search. e.g. CONTAINS, CONTAINS_WORD or EXACTLY. See docs for all supported values."
  default       = "CONTAINS"
}

variable "waf_byte_match_set_field_to_match_type" {
  description   = "(Required) The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER, METHOD or BODY. See docs for all supported values."
  default       = "HEADER"
}

variable "waf_byte_match_set_field_to_match_data" {
  description   = "(Optional) When type is HEADER, enter the name of the header that you want to search, e.g. User-Agent or Referer. If type is any other value, omit this field."
  default       = null
}

#---------------------------------------------------
# AWS WAF geo match set
#---------------------------------------------------
variable "enable_waf_geo_match_set" {
  description   = "Enable waf geo match set usage"
  default       = false
}

variable "waf_geo_match_set_name" {
  description   = "The name or description of the GeoMatchSet."
  default       = ""
}

variable "waf_geo_match_set_geo_match_constraint" {
  description   = "(Optional) The GeoMatchConstraint objects which contain the country that you want AWS WAF to search for."
  default       = []
}

#---------------------------------------------------
# AWS WAF regex match set
#---------------------------------------------------
variable "enable_waf_regex_match_set" {
  description   = "Enable waf regex match set usage"
  default       = false
}

variable "waf_regex_match_set_name" {
  description   = "The name or description of the Regex Match Set."
  default       = ""
}

variable "regex_match_tuple_field_to_match_data" {
  description   = "(Optional) When type is HEADER, enter the name of the header that you want to search, e.g. User-Agent or Referer. If type is any other value, omit this field."
  default       = null
}

variable "regex_match_tuple_field_to_match_type" {
  description   = "(Required) The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER, METHOD or BODY. See docs for all supported values."
  default       = "HEADER"
}

variable "regex_match_tuple_regex_pattern_set_id" {
  description   = "The ID of a Regex Pattern Set."
  default       = ""
}

variable "regex_match_tuple_text_transformation" {
  description   = "(Required) Text transformations used to eliminate unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. e.g. CMD_LINE, HTML_ENTITY_DECODE or NONE. See docs for all supported values."
  default       = "NONE"
}

#---------------------------------------------------
# AWS WAF regex pattern set
#---------------------------------------------------
variable "enable_waf_regex_pattern_set" {
  description   = "Enable waf regex pattern set usage"
  default       = false
}

variable "waf_regex_pattern_set_name" {
  description   = "The name or description of the Regex Pattern Set."
  default       = ""
}

variable "waf_regex_pattern_set_regex_pattern_strings" {
  description   = "(Optional) A list of regular expression (regex) patterns that you want AWS WAF to search for, such as B[a@]dB[o0]t."
  default       = []
}

#---------------------------------------------------
# AWS WAF size constraint set 
#---------------------------------------------------
variable "enable_waf_size_constraint_set" {
  description   = "Enable waf size constraint set usage"
  default       = false
}

variable "waf_size_constraint_set_name" {
  description   = "The name or description of the Size Constraint Set."
  default       = ""
}

variable "size_constraints_text_transformation" {
  description   = "(Required) Text transformations used to eliminate unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. If you specify a transformation, AWS WAF performs the transformation on field_to_match before inspecting a request for a match. e.g. CMD_LINE, HTML_ENTITY_DECODE or NONE. See docs for all supported values. Note: if you choose BODY as type, you must choose NONE because CloudFront forwards only the first 8192 bytes for inspection."
  default       = "NONE"
}

variable "size_constraints_comparison_operator" {
  description   = "(Required) The type of comparison you want to perform. e.g. EQ, NE, LT, GT. See docs for all supported values."
  default       = "EQ"
}

variable "size_constraints_size" {
  description   = "(Required) The size in bytes that you want to compare against the size of the specified field_to_match. Valid values are between 0 - 21474836480 bytes (0 - 20 GB)."
  default       = 4096
}

variable "size_constraint_set_field_to_match_type" {
  description   = "(Required) The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER, METHOD or BODY. See docs for all supported values."
  default       = "BODY"
}

variable "size_constraint_set_field_to_match_data" {
  description   = "(Optional) When type is HEADER, enter the name of the header that you want to search, e.g. User-Agent or Referer. If type is any other value, omit this field."
  default       = null
}

#---------------------------------------------------
# AWS WAF sql injection match set
#---------------------------------------------------
variable "enable_waf_sql_injection_match_set" {
  description   = "Enable waf sql injection match set usage"
  default       = false
}

variable "waf_sql_injection_match_set_name" {
  description   = "The name or description of the SQL Injection Match Set."
  default       = ""
}

variable "sql_injection_match_tuples" {
  description   = "(Optional) The parts of web requests that you want AWS WAF to inspect for malicious SQL code and, if you want AWS WAF to inspect a header, the name of the header."
  default       = []
}

#---------------------------------------------------
# AWS WAF xss match set
#---------------------------------------------------
variable "enable_waf_xss_match_set" {
  description   = "Enable waf xss match set usage"
  default       = false
}

variable "waf_xss_match_set_name" {
  description   = "The name or description of the SizeConstraintSet."
  default       = ""
}

variable "xss_match_tuples" {
  description   = "(Optional) The parts of web requests that you want to inspect for cross-site scripting attacks."
  default       = []
}