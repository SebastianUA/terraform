#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-WAF"
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

variable "enable_cloudfront_else_alb" {
    description = "Enable actions for cloudFront usage, else will use for App load balancer."
    default     = "false"
}

variable "ip_set_descriptors_type" {
    description = "Type of the IP address - IPV4 or IPV6."
    default     = "IPV4"
}

variable "ip_set_descriptors_value" {
    description = "An IPv4 or IPv6 address specified via CIDR notation. e.g. 192.0.2.44/32 or 1111:0000:0000:0000:0000:0000:0000:0000/64"
    default     = ""
}

variable "waf_rule_metric_name" {
    description = "The name or description for the Amazon CloudWatch metric of this rule."
    default     = "tfWAFRule"
}

variable "waf_rule_predicates_negated" {
    description = "Set this to false if you want to allow, block, or count requests based on the settings in the specified ByteMatchSet, IPSet, SqlInjectionMatchSet, XssMatchSet, or SizeConstraintSet. For example, if an IPSet includes the IP address 192.0.2.44, AWS WAF will allow or block requests based on that IP address. If set to true, AWS WAF will allow, block, or count requests based on all IP addresses except 192.0.2.44."
    default     = "false"
}

variable "waf_rule_predicates_type" {
    description = "The type of predicate in a rule, such as ByteMatchSet or IPSet"
    default     = "IPMatch"
}

variable "byte_match_tuples_text_transformation" {
    description = "Text transformations used to eliminate unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. If you specify a transformation, AWS WAF performs the transformation on target_string before inspecting a request for a match. e.g. CMD_LINE, HTML_ENTITY_DECODE or NONE. "
    default     = "NONE"
}

variable "byte_match_tuples_target_string" {
    description = "The value that you want to search for. e.g. HEADER, METHOD or BODY."
    default     = ""
}

variable "byte_match_tuples_positional_constraint" {
    description = "Within the portion of a web request that you want to search (for example, in the query string, if any), specify where you want to search. e.g. CONTAINS, CONTAINS_WORD or EXACTLY."
    default     = "CONTAINS"
}

variable "waf_byte_match_set_field_to_match_type" {
    description = "The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER, METHOD or BODY."
    default     = "HEADER"
}

variable "waf_byte_match_set_field_to_match_data" {
    description = "When type is HEADER, enter the name of the header that you want to search, e.g. User-Agent or Referer. If type is any other value, omit this field."
    default     = "referer"
}

variable "waf_rate_based_rule_rate_key" {
    description = "Valid value is IP."
    default     = "IP"
}

variable "waf_rate_based_rule_rate_limit" {
    description = "The maximum number of requests, which have an identical value in the field specified by the RateKey, allowed in a five-minute period. Minimum value is 2000."
    default     = 2000
}

variable "size_constraints_text_transformation" {
    description = "Text transformations used to eliminate unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. If you specify a transformation, AWS WAF performs the transformation on field_to_match before inspecting a request for a match. e.g. CMD_LINE, HTML_ENTITY_DECODE or NONE. Note: if you choose BODY as type, you must choose NONE because CloudFront forwards only the first 8192 bytes for inspection."
    default     = "NONE"
}

variable "size_constraints_comparison_operator" {
    description = "The type of comparison you want to perform. e.g. EQ, NE, LT, GT."
    default     = "EQ"
}

variable "size_constraints_size" {
    description = "The size in bytes that you want to compare against the size of the specified field_to_match. Valid values are between 0 - 21474836480 bytes (0 - 20 GB)."
    default     = "4096"
}

variable "size_constraint_set_field_to_match_type" {
    description = "The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER, METHOD or BODY."
    default     = "BODY"
}

variable "size_constraint_set_field_to_match_data" {
    description = "When type is HEADER, enter the name of the header that you want to search, e.g. User-Agent or Referer. If type is any other value, omit this field."
    default     = ""
}

variable "waf_web_acl_metric_name" {
    description = "The name or description for the Amazon CloudWatch metric of this web ACL."
    default     = "tfWebACL"
}

variable "waf_web_acl_default_action_type" {
    description = "Specifies how you want AWS WAF to respond to requests that match the settings in a rule. e.g. ALLOW, BLOCK or COUNT"
    default     = "ALLOW"
}

variable "waf_web_acl_rules_action_type" {
    description = "The rule type, either REGULAR, as defined by Rule, or RATE_BASED, as defined by RateBasedRule. The default is REGULAR. If you add a RATE_BASED rule, you need to set type as RATE_BASED."
    default     = "BLOCK"
}

variable "waf_web_acl_rules_priority" {
    description = "Specifies the order in which the rules in a WebACL are evaluated. Rules with a lower value are evaluated before rules with a higher value."
    default     = "1"
}

variable "waf_web_acl_rules_type" {
    description = "The rule type, either REGULAR, as defined by Rule, or RATE_BASED, as defined by RateBasedRule. The default is REGULAR. If you add a RATE_BASED rule, you need to set type as RATE_BASED."
    default     = "REGULAR"
}

