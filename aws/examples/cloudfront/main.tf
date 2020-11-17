#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "NonPROD"

  enable_s3_bucket = true
  s3_bucket_name   = "natarov-cloudfront-bucket"

  s3_bucket_acl       = "private"
  s3_bucket_cors_rule = []

  s3_bucket_versioning  = []
  enable_lifecycle_rule = true

  # Add policy to the bucket
  enable_s3_bucket_policy = true
  s3_bucket_policy        = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "AllowBucketUsage",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::natarov-cloudfronttest-bucket",
        "arn:aws:s3:::natarov-cloudfronttest-bucket/*"
      ]
    }
  ]
}
POLICY

}

module "cloudfront" {
  source      = "../../modules/cloudfront"
  name        = "TEST"
  environment = "stage"

  enable_cloudfront_distribution = true
  domain_name                    = module.s3.s3_bucket_bucket_bucket_regional_domain_name
  origin_id                      = "cloudfront"

  default_cache_behavior_target_origin_id = "cloudfront"
  logging_config_bucket                   = module.s3.s3_bucket_bucket_bucket_regional_domain_name

  tags = map("Env", "stage", "Orchestration", "Terraform")

}
