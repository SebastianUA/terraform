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

module "xray" {
  source      = "../../modules/xray"
  name        = "TEST"
  environment = "stage"

  enable_xray_sampling_rule         = true
  xray_sampling_rule_name           = "xray-test-sampling-rule"
  xray_sampling_rule_priority       = 1000
  xray_sampling_rule_version        = 1
  xray_sampling_rule_reservoir_size = 1
  xray_sampling_rule_fixed_rate     = 0.05
  xray_sampling_rule_url_path       = "*"
  xray_sampling_rule_host           = "*"
  xray_sampling_rule_http_method    = "*"
  xray_sampling_rule_service_type   = "*"
  xray_sampling_rule_service_name   = "*"
  xray_sampling_rule_resource_arn   = "*"

  xray_sampling_rule_attributes = tomap({
    "This"    = "is",
    "Vitaliy" = "Natarov"
  })

  # 
  enable_xray_encryption_config = true
  xray_encryption_config_type   = "NONE"

  # 
  enable_xray_group            = true
  xray_group_name              = "zray-group"
  xray_group_filter_expression = "responsetime > 5"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
