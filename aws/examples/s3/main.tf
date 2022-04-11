#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
  }

}

provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "default"
}

module "s3_private_bucket" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket1"

  // Enable S3 bucket ACL
  enable_s3_bucket_acl = true
  s3_bucket_acl_acl    = "private"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  // AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket2"

  // Enable versioning for S3 bucket
  enable_s3_bucket_versioning = true
  s3_bucket_versioning_versioning_configuration = {
    status = "Enabled"
  }

  // Enable S3 bucket CORS configuration
  enable_s3_bucket_cors_configuration = true
  s3_bucket_cors_configuration_cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://s3-website-test.hashicorp.com"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    },
    {
      allowed_headers = ["tmp"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://s3-website.hashicorp.com"]
      expose_headers  = ["ETag"]
      max_age_seconds = 300
    }
  ]

  // Enable S3 bucket logging
  enable_s3_bucket_logging        = true
  s3_bucket_logging_target_prefix = "logs/"
  s3_bucket_logging_target_bucket = "log_bucket_here"
  s3_bucket_logging_target_grant  = []


  // Enable S3 bucket server side encryption configuration
  enable_s3_bucket_server_side_encryption_configuration = false
  s3_bucket_server_side_encryption_configuration_rule = [
    {
      kms_master_key_id = "kms_key_arn_here"

      sse_algorithm = "aws:kms"
    }
  ]

  // Enable S3 bucket ACL
  enable_s3_bucket_acl = true
  s3_bucket_acl_acl    = "private"


  // Enable S3 bucket website configuration
  enable_s3_bucket_website_configuration = true
  s3_bucket_website_configuration_index_document = {
    suffix = "index.tml"
  }
  s3_bucket_website_configuration_error_document = {
    key = "error.tml"
  }

  s3_bucket_website_configuration_routing_rule = [
    {
      condition = {
        key_prefix_equals = "docs/"
      }
      redirect = {
        replace_key_prefix_with = "documents/"
      }
    }
  ]


  // Enable S3 bucket lifecycle configuration
  enable_s3_bucket_lifecycle_configuration = true
  s3_bucket_lifecycle_configuration_rule = [
    {
      id     = "log"
      status = "Enabled"

      filter = {
        and = [
          {
            prefix = "log/"
            tags = {
              rule      = "log"
              autoclean = "true"
            }
          }
        ]
      }

      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "GLACIER"
        }
      ]

      expiration = {
        days = 90
      }

      noncurrent_version_expiration = {
        days = 30
      }

      noncurrent_version_transition = [
        {
          days          = 60
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "ONEZONE_IA"
        },
        {
          days          = 180
          storage_class = "GLACIER"
        }
      ]

    }
  ]

  // Add files to bucket
  enable_s3_object = true
  s3_object_stack = [
    {
      key = "additional_files/test.txt"
    },
    {
      key                 = "additional_files/test2.txt"
      source              = null
      content_type        = null
      content             = null
      content_base64      = null
      content_disposition = null
      content_encoding    = null
      content_language    = null

      acl              = null
      cache_control    = null
      website_redirect = null
      storage_class    = null
      etag             = null
      metadata         = null
      force_destroy    = null

      server_side_encryption = null
      kms_key_id             = null

      object_lock_legal_hold_status = null
      object_lock_mode              = null
      object_lock_retain_until_date = null
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "s3_bucket_public_access_block" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket3"

  # Enable S3 bucket ACL
  enable_s3_bucket_acl = true
  s3_bucket_acl_acl    = "private"

  # AWS S3 bucket public access block
  enable_s3_bucket_public_access_block = true

  s3_bucket_public_access_block_block_public_acls       = true
  s3_bucket_public_access_block_block_public_policy     = true
  s3_bucket_public_access_block_ignore_public_acls      = true
  s3_bucket_public_access_block_restrict_public_buckets = true

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}