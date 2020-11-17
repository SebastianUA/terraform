#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "NonPROD"

  enable_s3_bucket    = true
  s3_bucket_name      = "test-bucket"
  s3_bucket_acl       = "private"
  s3_bucket_cors_rule = []

  s3_bucket_versioning  = []
  enable_lifecycle_rule = true

  # Add policy to the bucket
  enable_s3_bucket_policy = false
}

module "cloudtrail" {
  source            = "../../modules/cloudtrail"
  enable_cloudtrail = true
  cloudtrail_name   = "cloudtrail_name"

  s3_bucket_name = module.s3.s3_bucket_id
  s3_key_prefix  = "prefix"

  include_global_service_events = false

  tags = map("Env", "stage", "Orchestration", "Terraform")

}

# Logging All Lambda Function Invocations
module "cloudtrail_event_selector_lambda" {
  source                           = "../../modules/cloudtrail"
  enable_cloudtrail                = true
  enable_cloudtrail_event_selector = true
  cloudtrail_name                  = "cloudtrail_event_selector_lambda"

  s3_bucket_name = module.s3.s3_bucket_id
  s3_key_prefix  = "prefix"

  include_global_service_events = false

  event_selector_read_write_type           = "All"
  event_selector_include_management_events = true

  event_selector_data_resource_type   = "AWS::Lambda::Function"
  event_selector_data_resource_values = ["arn:aws:lambda"]

  tags = map("Env", "stage", "Orchestration", "Terraform")

}

# Logging All S3 Bucket Object Events
module "cloudtrail_event_selector_s3" {
  source                           = "../../modules/cloudtrail"
  enable_cloudtrail                = true
  enable_cloudtrail_event_selector = true
  cloudtrail_name                  = "cloudtrail_event_selector_s3"

  s3_bucket_name = module.s3.s3_bucket_id
  s3_key_prefix  = "prefix"

  include_global_service_events = false

  event_selector_read_write_type           = "All"
  event_selector_include_management_events = true

  event_selector_data_resource_type   = "AWS::S3::Object"
  event_selector_data_resource_values = ["arn:aws:s3:::"]

  tags = map("Env", "stage", "Orchestration", "Terraform")

}
