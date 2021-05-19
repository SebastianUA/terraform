#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket1"
  s3_bucket_acl    = "private"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}

module "cloudtrail" {
  source = "../../modules/cloudtrail"

  enable_cloudtrail = true
  cloudtrail_name   = "cloudtrail_name"

  cloudtrail_s3_bucket_name = module.s3.s3_bucket_id
  cloudtrail_s3_key_prefix  = "prefix"

  cloudtrail_include_global_service_events = false

  tags = map("Env", "stage", "Orchestration", "Terraform")

}

# Logging All Lambda Function Invocations
module "cloudtrail_event_selector_lambda" {
  source = "../../modules/cloudtrail"

  enable_cloudtrail = true
  cloudtrail_name   = "cloudtrail_event_selector_lambda"

  cloudtrail_s3_bucket_name = module.s3.s3_bucket_id
  cloudtrail_s3_key_prefix  = "prefix"

  cloudtrail_include_global_service_events = false

  cloudtrail_event_selector = [{
    read_write_type           = "All"
    include_management_events = true

    data_resource = {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }]

  tags = map("Env", "stage", "Orchestration", "Terraform")

}

# Logging All S3 Bucket Object Events
module "cloudtrail_event_selector_s3" {
  source = "../../modules/cloudtrail"


  enable_cloudtrail = true
  cloudtrail_name   = "cloudtrail_event_selector_s3"

  cloudtrail_s3_bucket_name = module.s3.s3_bucket_id
  cloudtrail_s3_key_prefix  = "prefix"

  cloudtrail_include_global_service_events = false

  cloudtrail_event_selector = [{
    read_write_type           = "All"
    include_management_events = true

    data_resource = {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }]

  tags = map("Env", "stage", "Orchestration", "Terraform")

}