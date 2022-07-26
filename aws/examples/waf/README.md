# Work with WAF via terraform

A terraform module for making WAF.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "waf" {
  source      = "../../modules/waf"
  name        = "TEST"
  environment = "stage"

  enable_waf_ipset = true
  waf_ipset_name   = ""
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

  enable_waf_rule      = true
  waf_rule_name        = "test-waf-rule"
  waf_rule_metric_name = "test"
  waf_rule_predicates  = []

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_waf_ipset` - Enable WAF ipset usage (`default = False`)
- `waf_ipset_name` - The name or description of the IPSet. (`default = ""`)
- `waf_ipset_ip_set_descriptors` - (Optional) One or more pairs specifying the IP address type (IPV4 or IPV6) and the IP address range (in CIDR format) from which web requests originate. (`default = []`)
- `enable_waf_rule` - Enable WAF rule usage (`default = False`)
- `waf_rule_name` - The name or description of the rule. (`default = ""`)
- `waf_rule_metric_name` - (Required) The name or description for the Amazon CloudWatch metric of this rule. The name can contain only alphanumeric characters (A-Z, a-z, 0-9); the name can't contain whitespace. (`default = ""`)
- `waf_rule_predicates` - (Optional) The objects to include in a rule (`default = []`)
- `enable_waf_rule_group` - Enable waf rule group usage (`default = False`)
- `waf_rule_group_name` - A friendly name of the rule group (`default = ""`)
- `waf_rule_group_metric_name` - (Required) A friendly name for the metrics from the rule group (`default = ""`)
- `waf_rule_group_activated_rule` - (Optional) A list of activated rules (`default = []`)
- `enable_waf_web_acl` - Enable waf web acl usage (`default = False`)
- `waf_web_acl_name` - The name or description of the web ACL. (`default = ""`)
- `waf_web_acl_metric_name` - (Required) The name or description for the Amazon CloudWatch metric of this web ACL. (`default = ""`)
- `waf_web_acl_default_action` - (Required) Configuration block with action that you want AWS WAF to take when a request doesn't match the criteria in any of the rules that are associated with the web ACL. (`default = []`)
- `waf_web_acl_rules` - (Optional) Configuration blocks containing rules to associate with the web ACL and the settings for each rule. (`default = []`)
- `waf_web_acl_logging_configuration` - (Optional) Configuration block to enable WAF logging. (`default = []`)
- `enable_waf_rate_based_rule` - Enable waf rate based rule usage (`default = False`)
- `waf_rate_based_rule_name` - The name or description of the rule. (`default = ""`)
- `waf_rate_based_rule_metric_name` - (Required) The name or description for the Amazon CloudWatch metric of this rule. (`default = ""`)
- `waf_rate_based_rule_rate_key` - (Required) Valid value is IP. (`default = IP`)
- `waf_rate_based_rule_rate_limit` - (Required) The maximum number of requests, which have an identical value in the field specified by the RateKey, allowed in a five-minute period. Minimum value is 100. (`default = 100`)
- `waf_rate_based_rule_predicates` - (Optional) The objects to include in a rule (`default = []`)
- `enable_waf_byte_match_set` - Enable waf byte match set usage (`default = False`)
- `waf_byte_match_set_name` - The name or description of the Byte Match Set. (`default = ""`)
- `waf_byte_match_set_byte_match_tuples` - Specifies the bytes (typically a string that corresponds with ASCII characters) that you want to search for in web requests, the location in requests that you want to search, and other settings. (`default = []`)
- `enable_waf_geo_match_set` - Enable waf geo match set usage (`default = False`)
- `waf_geo_match_set_name` - The name or description of the GeoMatchSet. (`default = ""`)
- `waf_geo_match_set_geo_match_constraint` - (Optional) The GeoMatchConstraint objects which contain the country that you want AWS WAF to search for. (`default = []`)
- `enable_waf_regex_match_set` - Enable waf regex match set usage (`default = False`)
- `waf_regex_match_set_name` - The name or description of the Regex Match Set. (`default = ""`)
- `waf_regex_match_set_regex_match_tuple` - (Required) The regular expression pattern that you want AWS WAF to search for in web requests, the location in requests that you want AWS WAF to search, and other settings. (`default = []`)
- `enable_waf_regex_pattern_set` - Enable waf regex pattern set usage (`default = False`)
- `waf_regex_pattern_set_name` - The name or description of the Regex Pattern Set. (`default = ""`)
- `waf_regex_pattern_set_regex_pattern_strings` - (Optional) A list of regular expression (regex) patterns that you want AWS WAF to search for, such as B[a@]dB[o0]t. (`default = []`)
- `enable_waf_size_constraint_set` - Enable waf size constraint set usage (`default = False`)
- `waf_size_constraint_set_name` - The name or description of the Size Constraint Set. (`default = ""`)
- `waf_size_constraint_set_size_constraints` - (Optional) Specifies the parts of web requests that you want to inspect the size of. (`default = []`)
- `enable_waf_sql_injection_match_set` - Enable waf sql injection match set usage (`default = False`)
- `waf_sql_injection_match_set_name` - The name or description of the SQL Injection Match Set. (`default = ""`)
- `sql_injection_match_tuples` - (Optional) The parts of web requests that you want AWS WAF to inspect for malicious SQL code and, if you want AWS WAF to inspect a header, the name of the header. (`default = []`)
- `enable_waf_xss_match_set` - Enable waf xss match set usage (`default = False`)
- `waf_xss_match_set_name` - The name or description of the SizeConstraintSet. (`default = ""`)
- `waf_xss_match_set_xss_match_tuples` - (Optional) The parts of web requests that you want to inspect for cross-site scripting attacks. (`default = []`)

## Module Output Variables
----------------------
- `waf_ipset_id` - The ID of the WAF IPSet.
- `waf_ipset_arn` - The ARN of the WAF IPSet.
- `waf_rule_id` - The ID of the WAF rule.
- `waf_rule_arn` - The ARN of the WAF rule.
- `waf_rule_group_id` - The ID of the WAF rule group.
- `waf_rule_group_arn` - The ARN of the WAF rule group.
- `waf_web_acl_id` - The ID of the WAF WebACL.
- `waf_web_acl_arn` - The ARN of the WAF WebACL.
- `waf_rate_based_rule_id` - The ID of the WAF rule.
- `waf_rate_based_rule_arn` - Amazon Resource Name (ARN)
- `waf_byte_match_set_id` - The ID of the WAF Byte Match Set.
- `waf_geo_match_set_id` - The ID of the WAF rule.
- `waf_geo_match_set_arn` - Amazon Resource Name (ARN)
- `waf_regex_match_set_id` - The ID of the WAF Regex Match Set.
- `waf_regex_match_set_arn` - Amazon Resource Name (ARN)
- `waf_regex_pattern_set_id` - The ID of the WAF Regex Pattern Set.
- `waf_regex_pattern_set_arn` - Amazon Resource Name (ARN)
- `waf_size_constraint_set_id` - The ID of the WAF Size Constraint Set.
- `waf_size_constraint_set_arn` - Amazon Resource Name (ARN)
- `waf_sql_injection_match_set_id` - The ID of the WAF SQL Injection Match Set.
- `waf_xss_match_set_id` - The ID of the WAF XssMatchSet.
- `waf_xss_match_set_arn` - Amazon Resource Name (ARN)


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
