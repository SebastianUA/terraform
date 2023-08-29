#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = "~> 2.70"
  }
}

provider "aws" {
  region                   = "us-east-1"
  profile                  = "default"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  enable_s3_bucket    = true
  s3_bucket_name      = "aws-config-bucket-dev"
  s3_bucket_acl       = "private"
  s3_bucket_cors_rule = []

  s3_bucket_versioning  = []
  enable_lifecycle_rule = true

  # Add policy to the bucket
  enable_s3_bucket_policy = false

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

module "config" {
  source = "../../modules/config"

  region      = "us-east-1"
  name        = "testme"
  environment = "dev"


  enable_config_delivery_channel         = true
  config_delivery_channel_name           = ""
  config_delivery_channel_s3_bucket_name = module.s3.s3_bucket_id

  enable_organizations_organization           = true
  enable_config_organization_managed_rule     = true
  config_organization_managed_rule_name       = ""
  config_organization_managed_rule_identifier = "IAM_PASSWORD_POLICY"

  enable_config_configuration_recorder          = true
  config_configuration_recorder_name            = ""
  config_configuration_recorder_role_arn        = "arn:aws:iam::167127734783:role/aws-service-role/organizations.amazonaws.com/AWSServiceRoleForOrganizations"
  config_configuration_recorder_recording_group = []

  enable_config_configuration_recorder_status     = true
  config_configuration_recorder_status_is_enabled = true

  enable_config_aggregate_authorization     = true
  config_aggregate_authorization_account_id = "167127734783"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
