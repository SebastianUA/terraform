#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "NonPROD"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-cloudfront-bucket"
  s3_bucket_acl    = "private"

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

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "cloudfront" {
  source      = "../../modules/cloudfront"
  name        = "TEST"
  environment = "stage"

  # AWS cloudfront distribution
  enable_cloudfront_distribution = true
  cloudfront_distribution_stack = [
    {
      // Requireds
      name    = "cloudfront-distribution-1"
      enabled = true

      origin = {
        origin_id   = "origin_id"
        domain_name = "domain_name"

        origin_path = ""

        custom_header = [
          {
            name  = "X-Forwarded-Scheme"
            value = "https"
          },
          {
            name  = "X-Frame-Options"
            value = "SAMEORIGIN"
          }
        ]

        custom_origin_config = {
          origin_protocol_policy   = "match-viewer"
          http_port                = 80
          https_port               = 443
          origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
          origin_keepalive_timeout = 60
          origin_read_timeout      = 60
        }

        s3_origin_config = {
          origin_access_identity = ""
        }
      }

      restrictions = {
        geo_restriction = {
          restriction_type = "whitelist"
          locations        = ["UA", "USA", "NL"]
        }
      }

      viewer_certificate = {
        cloudfront_default_certificate = true
        acm_certificate_arn            = ""
        iam_certificate_id             = ""
        minimum_protocol_version       = "TLSv1"
        ssl_support_method             = "sni-only"
      }

      default_cache_behavior = {
        allowed_methods = ["GET", "HEAD", "OPTIONS"]
        cached_methods  = ["GET", "HEAD"]
      }

      // Optionals 
      comment             = "test cloudfront"
      aliases             = ["cloudfront.linux-notes.org", "linux-notes.org"]
      default_root_object = "index.html"
      is_ipv6_enabled     = true
      http_version        = "http2"
      price_class         = "PriceClass_200"
      web_acl_id          = null
      retain_on_delete    = false
      wait_for_deployment = true

      custom_error_response  = {}
      logging_config         = {}
      ordered_cache_behavior = []
      origin_group           = {}
    }
  ]

  # AWS cloudfront cache policy
  enable_cloudfront_cache_policy = true
  cloudfront_cache_policy_stack = [
    {
      name        = "cloudfront-cache-policy-1"
      comment     = "cloudfront-cache-policy-1"
      default_ttl = 50
      max_ttl     = 100
      min_ttl     = 60

      parameters_in_cache_key_and_forwarded_to_origin = {
        cookies_config = {
          cookie_behavior = "whitelist"
          cookies = {
            items = ["example"]
          }
        }

        query_strings_config = {
          query_string_behavior = "whitelist"
          query_strings = {
            items = ["example"]
          }
        }

        headers_config = {
          header_behavior = "whitelist"
          headers = {
            items = ["example"]
          }
        }

        query_string_behavior = {
          query_string_behavior = "whitelist"
          query_strings = {
            items = ["example"]
          }
        }
      }
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
