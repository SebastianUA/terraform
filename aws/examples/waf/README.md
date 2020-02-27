# Work with AWS WAF via terraform

A terraform module for making WAF.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}
provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "waf" {
    source                          = "../../modules/waf"
    name                            = "TEST"
    environment                     = "stage"

    enable_waf_ipset                = true
    waf_ipset_name                  = ""
    #waf_ipset_ip_set_descriptors    = [
    #    {
    #        "value"     = "1.2.3.4/32",
    #        "type"      ="IPV4"
    #    },
    #    {
    #        "value"     = "2.3.4.5/28",
    #        "type"      = "IPV4"
    #    }
    #]

    enable_waf_rule                 = true
    waf_rule_name                   = "test-waf-rule"
    waf_rule_metric_name            = "test"
    waf_rule_predicates             = []
}

```


Module Input Variables
----------------------


- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`  default     = "us-east-1"`).
- `environment` - Environment for service (`  default     = "STAGE"`).
- `orchestration` - Type of orchestration (`  default     = "Terraform"`).
- `createdby` - Created by (`  default     = "Vitaliy Natarov"`).
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default     = {}`).
- `enable_waf_ipset` - Enable WAF ipset usage (`default       = false`).
- `waf_ipset_name` - The name or description of the IPSet. (`default       = ""`).
- `waf_ipset_ip_set_descriptors` - (Optional) One or more pairs specifying the IP address type (IPV4 or IPV6) and the IP address range (in CIDR format) from which web requests originate. (`default       = []`).
- `enable_waf_rule` - Enable WAF rule usage (`default       = false`).
- `waf_rule_name` - The name or description of the rule. (`default       = ""`).
- `waf_rule_metric_name` - (Required) The name or description for the Amazon CloudWatch metric of this rule. The name can contain only alphanumeric characters (A-Z, a-z, 0-9); the name can't contain whitespace. (`default       = ""`).
- `waf_rule_predicates` - (Optional) The objects to include in a rule (`default       = []`).
- `enable_waf_rule_group` - Enable waf rule group usage (`default       = false`).
- `waf_rule_group_name` - A friendly name of the rule group (`default       = ""`).
- `waf_rule_group_metric_name` - (Required) A friendly name for the metrics from the rule group (`default       = ""`).
- `activated_rule_action_type` - (Required) e.g. BLOCK, ALLOW, or COUNT (`default       = "COUNT"`).
- `activated_rule_priority` - (Required) Specifies the order in which the rules are evaluated. Rules with a lower value are evaluated before rules with a higher value. (`default       = 50`).
- `activated_rule_rule_id` - (Required) The ID of a rule (`default       = ""`).
- `activated_rule_type` - (Optional) The rule type, either REGULAR, RATE_BASED, or GROUP. Defaults to REGULAR. (`default       = "REGULAR"`).
- `enable_waf_web_acl` - Enable waf web acl usage (`default       = false`).
- `waf_web_acl_name` - The name or description of the web ACL. (`default       = ""`).
- `waf_web_acl_metric_name` - (Required) The name or description for the Amazon CloudWatch metric of this web ACL. (`default       = ""`).
- `waf_web_acl_default_action_type` - (Required) Specifies how you want AWS WAF to respond to requests that don't match the criteria in any of the rules. e.g. ALLOW, BLOCK or COUNT (`default       = "COUNT"`).
- `waf_web_acl_rules_action_type` - (Required) valid values are: BLOCK, ALLOW, or COUNT (`default       = "COUNT"`).
- `waf_web_acl_rules_override_action_type` - (Required) valid values are: NONE or COUNT (`default       = "COUNT"`).
- `waf_web_acl_rules_priority` - (Required) Specifies the order in which the rules in a WebACL are evaluated. Rules with a lower value are evaluated before rules with a higher value. (`default       = 1`).
- `waf_web_acl_rules_rule_id` - ID of the associated WAF (Global) rule (e.g. aws_waf_rule). WAF (Regional) rules cannot be used. (`default       = ""`).
- `waf_web_acl_rules_type` - (Optional) The rule type, either REGULAR, as defined by Rule, RATE_BASED, as defined by RateBasedRule, or GROUP, as defined by RuleGroup. The default is REGULAR. If you add a RATE_BASED rule, you need to set type as RATE_BASED. If you add a GROUP rule, you need to set type as GROUP. (`default       = "REGULAR"`).
- `logging_configuration_log_destination` - (Required) Amazon Resource Name (ARN) of Kinesis Firehose Delivery Stream (`default       = ""`).
- `logging_configuration_redacted_fields_field_to_match_type` - (Required) The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER or METHOD (`default       = "HEADER"`).
- `logging_configuration_redacted_fields_field_to_match_data` - (Optional) When the value of type is HEADER, enter the name of the header that you want the WAF to search, for example, User-Agent or Referer. If the value of type is any other value, omit data. (`default       = null`).
- `enable_waf_rate_based_rule` - Enable waf rate based rule usage (`default       = false`).
- `waf_rate_based_rule_name` - The name or description of the rule. (`default       = ""`).
- `waf_rate_based_rule_metric_name` - (Required) The name or description for the Amazon CloudWatch metric of this rule. (`default       = ""`).
- `waf_rate_based_rule_rate_key` - (Required) Valid value is IP. (`default       = "IP"`).
- `waf_rate_based_rule_rate_limit` - (Required) The maximum number of requests, which have an identical value in the field specified by the RateKey, allowed in a five-minute period. Minimum value is 100. (`default       = 100`).
- `waf_rate_based_rule_predicates` - (Optional) The objects to include in a rule (`default       = []`).
- `enable_waf_byte_match_set` - Enable waf byte match set usage (`default       = false`).
- `waf_byte_match_set_name` - The name or description of the Byte Match Set. (`default       = ""`).
- `byte_match_tuples_text_transformation` - (Required) Text transformations used to eliminate unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. If you specify a transformation, AWS WAF performs the transformation on target_string before inspecting a request for a match. e.g. CMD_LINE, HTML_ENTITY_DECODE or NONE. See docs for all supported values. (`default       = "NONE"`).
- `byte_match_tuples_target_string` - (Optional) The value that you want to search for. e.g. HEADER, METHOD or BODY. See docs for all supported values. (`default       = null`).
- `byte_match_tuples_positional_constraint` - (Required) Within the portion of a web request that you want to search (for example, in the query string, if any), specify where you want to search. e.g. CONTAINS, CONTAINS_WORD or EXACTLY. See docs for all supported values. (`default       = "CONTAINS"`).
- `waf_byte_match_set_field_to_match_type` - (Required) The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER, METHOD or BODY. See docs for all supported values. (`default       = "HEADER"`).
- `waf_byte_match_set_field_to_match_data` - (Optional) When type is HEADER, enter the name of the header that you want to search, e.g. User-Agent or Referer. If type is any other value, omit this field. (`default       = null`).
- `enable_waf_geo_match_set` - Enable waf geo match set usage (`default       = false`).
- `waf_geo_match_set_name` - The name or description of the GeoMatchSet. (`default       = ""`).
- `waf_geo_match_set_geo_match_constraint` - (Optional) The GeoMatchConstraint objects which contain the country that you want AWS WAF to search for. (`default       = []`).
- `enable_waf_regex_match_set` - Enable waf regex match set usage (`default       = false`).
- `waf_regex_match_set_name` - The name or description of the Regex Match Set. (`default       = ""`).
- `regex_match_tuple_field_to_match_data` - (Optional) When type is HEADER, enter the name of the header that you want to search, e.g. User-Agent or Referer. If type is any other value, omit this field. (`default       = null`).
- `regex_match_tuple_field_to_match_type` - (Required) The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER, METHOD or BODY. See docs for all supported values. (`default       = "HEADER"`).
- `regex_match_tuple_regex_pattern_set_id` - The ID of a Regex Pattern Set. (`default       = ""`).
- `regex_match_tuple_text_transformation` - (Required) Text transformations used to eliminate unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. e.g. CMD_LINE, HTML_ENTITY_DECODE or NONE. See docs for all supported values. (`default       = "NONE"`).
- `enable_waf_regex_pattern_set` - Enable waf regex pattern set usage (`default       = false`).
- `waf_regex_pattern_set_name` - The name or description of the Regex Pattern Set. (`default       = ""`).
- `waf_regex_pattern_set_regex_pattern_strings` - (Optional) A list of regular expression (regex) patterns that you want AWS WAF to search for, such as B[a@]dB[o0]t. (`default       = []`).
- `enable_waf_size_constraint_set` - Enable waf size constraint set usage (`default       = false`).
- `waf_size_constraint_set_name` - The name or description of the Size Constraint Set. (`default       = ""`).
- `size_constraints_text_transformation` - (Required) Text transformations used to eliminate unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. If you specify a transformation, AWS WAF performs the transformation on field_to_match before inspecting a request for a match. e.g. CMD_LINE, HTML_ENTITY_DECODE or NONE. See docs for all supported values. Note: if you choose BODY as type, you must choose NONE because CloudFront forwards only the first 8192 bytes for inspection. (`default       = "NONE"`).
- `size_constraints_comparison_operator` - (Required) The type of comparison you want to perform. e.g. EQ, NE, LT, GT. See docs for all supported values. (`default       = "EQ"`).
- `size_constraints_size` - (Required) The size in bytes that you want to compare against the size of the specified field_to_match. Valid values are between 0 - 21474836480 bytes (0 - 20 GB). (`default       = 4096`).
- `size_constraint_set_field_to_match_type` - (Required) The part of the web request that you want AWS WAF to search for a specified string. e.g. HEADER, METHOD or BODY. See docs for all supported values. (`default       = "BODY"`).
- `size_constraint_set_field_to_match_data` - (Optional) When type is HEADER, enter the name of the header that you want to search, e.g. User-Agent or Referer. If type is any other value, omit this field. (`default       = null`).
- `enable_waf_sql_injection_match_set` - Enable waf sql injection match set usage (`default       = false`).
- `waf_sql_injection_match_set_name` - The name or description of the SQL Injection Match Set. (`default       = ""`).
- `sql_injection_match_tuples` - (Optional) The parts of web requests that you want AWS WAF to inspect for malicious SQL code and, if you want AWS WAF to inspect a header, the name of the header. (`default       = []`).
- `enable_waf_xss_match_set` - Enable waf xss match set usage (`default       = false`).
- `waf_xss_match_set_name` - The name or description of the SizeConstraintSet. (`default       = ""`).
- `xss_match_tuples` - (Optional) The parts of web requests that you want to inspect for cross-site scripting attacks. (`default       = []`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
