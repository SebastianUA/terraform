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

module "dlm" {
  source      = "../../modules/dlm"
  name        = "TEST"
  environment = "dev"

  enable_dlm_lifecycle_policy                                     = true
  dlm_lifecycle_policy_description                                = "Test DML lifecycle policy"
  dlm_lifecycle_policy_execution_role_arn                         = "arn:aws:iam::167127734783:role/admin-role"
  dlm_lifecycle_policy_state                                      = "ENABLED"
  dlm_lifecycle_policy_details_resource_types                     = ["VOLUME"]
  dlm_lifecycle_policy_details_schedule_name                      = ""
  dlm_lifecycle_policy_details_schedule_create_rule_interval      = 24
  dlm_lifecycle_policy_details_schedule_create_rule_interval_unit = "HOURS"
  dlm_lifecycle_policy_details_schedule_create_rule_times         = ["23:45"]
  dlm_lifecycle_policy_details_schedule_retain_rule_count         = 14
  dlm_lifecycle_policy_details_schedule_copy_tags                 = false

  target_tags = {}
  tags_to_add = {}
}
