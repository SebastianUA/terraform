# Work with CLOUDFRONT via terraform

A terraform module for making CLOUDFRONT.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_cloudfront_distribution` - Enable cloudfront distribution usage (`default = False`)
- `cloudfront_distribution_stack` - Set properties for cloudfront distribution (`default = []`)
- `enable_cloudfront_public_key` - Enable cloudfront public key usage (`default = False`)
- `cloudfront_public_key_encoded_key` - (Required) The encoded public key that you want to add to CloudFront to use with features like field-level encryption. (`default = ""`)
- `cloudfront_public_key_comment` - (Optional) An optional comment about the public key. (`default = null`)
- `cloudfront_public_key_name` - (Optional) The name for the public key. By default generated by Terraform. (`default = null`)
- `cloudfront_public_key_name_prefix` - (Optional) The name for the public key. Conflicts with cloudfront_public_key_name. (`default = null`)
- `enable_cloudfront_origin_access_identity` - Enable cloudfront origin access identity usage (`default = False`)
- `cloudfront_origin_access_identity_comment` - (Optional) - An optional comment for the origin access identity. (`default = null`)
- `enable_cloudfront_realtime_log_config` - Enable cloudfront realtime log config usage (`default = False`)
- `cloudfront_realtime_log_config_name` - The unique name to identify this real-time log configuration. (`default = ""`)
- `cloudfront_realtime_log_config_sampling_rate` - (Required) The sampling rate for this real-time log configuration. The sampling rate determines the percentage of viewer requests that are represented in the real-time log data. An integer between 1 and 100, inclusive. (`default = 1`)
- `cloudfront_realtime_log_config_fields` - (Required) The fields that are included in each real-time log record. (`default = []`)
- `cloudfront_realtime_log_config_endpoints` - (Required) The Amazon Kinesis data streams where real-time log data is sent. (`default = {}`)
- `enable_cloudfront_origin_request_policy` - Enable cloudfront origin request policy usage (`default = False`)
- `cloudfront_origin_request_policy_name` - Unique name to identify the origin request policy. (`default = ""`)
- `cloudfront_origin_request_policy_comment` - (Optional) Comment to describe the origin request policy. (`default = null`)
- `cloudfront_origin_request_policy_cookies_config` - (Required) Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the origin request key and automatically included in requests that CloudFront sends to the origin. See Cookies Config for more information. (`default = {}`)
- `cloudfront_origin_request_policy_headers_config` - (Required) Object that determines whether any HTTP headers (and if so, which headers) are included in the origin request key and automatically included in requests that CloudFront sends to the origin. See Headers Config for more information. (`default = {}`)
- `cloudfront_origin_request_policy_query_strings_config` - (Required) Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the origin request key and automatically included in requests that CloudFront sends to the origin. See Query Strings Config for more information. (`default = {}`)
- `enable_cloudfront_cache_policy` - Enable cloudfront cache policy usage (`default = False`)
- `cloudfront_cache_policy_stack` - Set properties for cloudfront cache policy (`default = []`)

## Module Output Variables
----------------------
- `cloudfront_distribution_id` - The identifier for the distribution. For example: EDFDVBD632BHDS5.
- `cloudfront_distribution_arn` - The ARN (Amazon Resource Name) for the distribution. For example: arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5, where 123456789012 is your AWS account ID.
- `cloudfront_distribution_caller_reference` - Internal value used by CloudFront to allow future updates to the distribution configuration.
- `cloudfront_distribution_status` - The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system.
- `cloudfront_distribution_domain_name` - The domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net.
- `cloudfront_distribution_last_modified_time` - The date and time the distribution was last modified.
- `cloudfront_distribution_in_progress_validation_batches` - The number of invalidation batches currently in progress.
- `cloudfront_distribution_etag` - The current version of the distribution's information. For example: E2QWRUHAPOMQZL.
- `cloudfront_distribution_hosted_zone_id` - The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2.
- `cloudfront_public_key_id` - The identifier for the public key. For example: K3D5EWEUDCCXON.
- `cloudfront_public_key_caller_reference` - Internal value used by CloudFront to allow future updates to the public key configuration.
- `cloudfront_public_key_etag` - The current version of the public key. For example: E2QWRUHAPOMQZL.
- `cloudfront_origin_access_identity_id` - The identifier for the distribution. For example: EDFDVBD632BHDS5.
- `cloudfront_origin_access_identity_caller_reference` - Internal value used by CloudFront to allow future updates to the origin access identity.
- `cloudfront_origin_access_identity_cloudfront_access_identity_path` - A shortcut to the full path for the origin access identity to use in CloudFront, see below.
- `cloudfront_origin_access_identity_etag` - The current version of the origin access identity's information. For example: E2QWRUHAPOMQZL.
- `cloudfront_origin_access_identity_iam_arn` - A pre-generated ARN for use in S3 bucket policies (see below). Example: arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2QWRUHAPOMQZL.
- `cloudfront_origin_access_identity_s3_canonical_user_id` - The Amazon S3 canonical user ID for the origin access identity, which you use when giving the origin access identity read permission to an object in Amazon S3.
- `cloudfront_realtime_log_config_id` - The ID of the CloudFront real-time log configuration.
- `cloudfront_realtime_log_config_arn` - The ARN (Amazon Resource Name) of the CloudFront real-time log configuration.
- `cloudfront_origin_request_policy_id` - The identifier for the origin request policy.
- `cloudfront_origin_request_policy_etag` - The current version of the origin request policy.
- `cloudfront_cache_policy_id` - The identifier for the cache policy.
- `cloudfront_cache_policy_etag` - The current version of the cache policy.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
