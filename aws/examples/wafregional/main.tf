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
