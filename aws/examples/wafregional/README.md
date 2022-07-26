# Work with WAFREGIONAL via terraform

A terraform module for making WAFREGIONAL.


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
- `activated_rule_action_type` - (Required) e.g. BLOCK, ALLOW, or COUNT (`default = COUNT`)
- `activated_rule_priority` - (Required) Specifies the order in which the rules are evaluated. Rules with a lower value are evaluated before rules with a higher value. (`default = 50`)
- `activated_rule_rule_id` - (Required) The ID of a rule (`default = ""`)
- `activated_rule_type` - (Optional) The rule type, either REGULAR, RATE_BASED, or GROUP. Defaults to REGULAR. (`default = REGULAR`)

## Module Output Variables
----------------------
- `waf_ipset_id` - The ID of the WAF IPSet.
- `waf_ipset_arn` - The ARN of the WAF IPSet.
- `waf_rule_id` - The ID of the WAF rule.
- `waf_rule_arn` - The ARN of the WAF rule.
- `waf_rule_group_id` - The ID of the WAF rule group.
- `waf_rule_group_arn` - The ARN of the WAF rule group.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
