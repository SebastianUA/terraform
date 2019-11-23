#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "waf" {
    source                      = "../../modules/waf"
    name                        = "TEST-WAF"
    environment                 = "PROD"

    enable_cloudfront_else_alb      = true
    ip_set_descriptors_value        = "0.0.0.0/8"
    byte_match_tuples_target_string = "badrefer1"
    waf_rate_based_rule_rate_limit  = "2001"
}

