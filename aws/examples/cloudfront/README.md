# Work with AWS CLOUDFRONT via terraform

A terraform module for making CLOUDFRONT.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = ""`)
- `enable_cloudfront_distribution` - Enable cloudfront distribution usage (`default = ""`)
- `cloudfront_distribution_name` - Set name for cloudfront distribution (`default = ""`)
- `cloudfront_distribution_enabled` - (Required) - Whether the distribution is enabled to accept end user requests for content. (`default = True`)
- `cloudfront_distribution_default_root_object` - (Optional) - The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. (`default = null`)
- `cloudfront_distribution_aliases` - (Optional) - Extra CNAMEs (alternate domain names), if any, for this distribution. (`default = null`)
- `cloudfront_distribution_comment` - (Optional) - Any comments you want to include about the distribution. (`default = null`)
- `custom_error_response_error_code` - (Required) - The 4xx or 5xx HTTP status code that you want to customize. (`default = 404`)
- `custom_error_response_error_caching_min_ttl` - (Optional) - The minimum amount of time you want HTTP error codes to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. (`default = null`)
- `custom_error_response_response_code` - (Optional) - The HTTP status code that you want CloudFront to return with the custom error page to the viewer. (`default = null`)
- `custom_error_response_response_page_path` - (Optional) - The path of the custom error page (for example, /custom_404.html). (`default = null`)
- `cloudfront_distribution_is_ipv6_enabled` - (Optional) - Whether the IPv6 is enabled for the distribution. (`default = null`)
- `cloudfront_distribution_http_version` - (Optional) - The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2. (`default = http2`)
- `logging_config_bucket` - (Required) - The Amazon S3 bucket to store the access logs in, for example, myawslogbucket.s3.amazonaws.com. (`default = null`)
- `logging_config_include_cookies` - (Optional) - Specifies whether you want CloudFront to include cookies in access logs (default: false). (`default = ""`)
- `logging_config_prefix` - (Optional) - An optional string that you want CloudFront to prefix to the access log filenames for this distribution, for example, myprefix/. (`default = null`)
- `ordered_cache_behavior_path_pattern` - (Required) - The pattern (for example, images/*.jpg) that specifies which requests you want this cache behavior to apply to. (`default = /content/*`)
- `ordered_cache_behavior_allowed_methods` - (Required) - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. (`default = ['GET', 'HEAD', 'OPTIONS']`)
- `ordered_cache_behavior_cached_methods` - (Required) - Controls whether CloudFront caches the response to requests using the specified HTTP methods. (`default = ['GET', 'HEAD']`)
- `ordered_cache_behavior_target_origin_id` - (Required) - The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior. (`default = groupS3`)
- `ordered_cache_behavior_forwarded_values_query_string` - (Required) - Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior. (`default = ""`)
- `ordered_cache_behavior_cookies_forward` - (Required) - Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names (`default = none`)
- `ordered_cache_behavior_min_ttl` - (Optional) - The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds. (`default = ""`)
- `ordered_cache_behavior_default_ttl` - (Optional) - The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day. (`default = 3600`)
- `ordered_cache_behavior_max_ttl` - (Optional) - The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days. (`default = 86400`)
- `ordered_cache_behavior_compress` - (Optional) - Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false). (`default = True`)
- `ordered_cache_behavior_viewer_protocol_policy` - (Required) - Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https. (`default = redirect-to-https`)
- `origin_group_origin_id` - description (`default = ""`)
- `origin_group_failover_criteria_status_codes` - (Required) - A list of HTTP status codes for the origin group (`default = [403, 404, 500, 502]`)
- `origin_group_member_origin_id_1` - (Required) - The unique identifier of the member origin (`default = ""`)
- `origin_group_member_origin_id_2` - (Required) - The unique identifier of the member origin (`default = ""`)
- `cloudfront_distribution_price_class` - (Optional) - The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100 (`default = null`)
- `cloudfront_distribution_web_acl_id` - (Optional) - If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned. (`default = null`)
- `cloudfront_distribution_retain_on_delete` - Optional) - Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. Default: false. (`default = ""`)
- `cloudfront_distribution_wait_for_deployment` - (Optional) - If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. Default: true. (`default = True`)
- `geo_restriction_restriction_type` - (Required) - The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist. (`default = none`)
- `geo_restriction_locations` - (Optional) - The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist) (`default = ""`)
- `viewer_certificate_cloudfront_default_certificate` - cloudfront_default_certificate - true if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution. Specify this, acm_certificate_arn, or iam_certificate_id. (`default = True`)
- `viewer_certificate_acm_certificate_arn` - The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. Specify this, cloudfront_default_certificate, or iam_certificate_id. The ACM certificate must be in US-EAST-1. (`default = ""`)
- `viewer_certificate_iam_certificate_id` - The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain. Specify this, acm_certificate_arn, or cloudfront_default_certificate. (`default = null`)
- `viewer_certificate_minimum_protocol_version` - The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. Can only be set if cloudfront_default_certificate = false. One of SSLv3, TLSv1, TLSv1_2016, TLSv1.1_2016 or TLSv1.2_2018. Default: TLSv1. NOTE: If you are using a custom certificate (specified with acm_certificate_arn or iam_certificate_id), and have specified sni-only in ssl_support_method, TLSv1 or later must be specified. If you have specified vip in ssl_support_method, only SSLv3 or TLSv1 can be specified. If you have specified cloudfront_default_certificate, TLSv1 must be specified. (`default = TLSv1`)
- `viewer_certificate_ssl_support_method` - Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only. Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges. (`default = null`)
- `default_cache_behavior_allowed_methods` - (Required) - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. (`default = ['GET', 'HEAD', 'DELETE', 'OPTIONS', 'PATCH', 'POST', 'PUT']`)
- `default_cache_behavior_cached_methods` - (Required) - Controls whether CloudFront caches the response to requests using the specified HTTP methods. (`default = ['GET', 'HEAD']`)
- `custom_origin_config_origin_protocol_policy` - (Required) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer. (`default = http-only`)
- `custom_origin_config_http_port` - (Required) - The HTTP port the custom origin listens on. (`default = 80`)
- `custom_origin_config_https_port` - (Required) - The HTTPS port the custom origin listens on. (`default = 443`)
- `custom_origin_config_origin_ssl_protocols` - (Required) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. A list of one or more of SSLv3, TLSv1, TLSv1.1, and TLSv1.2. (`default = ['TLSv1']`)
- `custom_origin_config_origin_keepalive_timeout` - (Optional) The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase. (`default = 60`)
- `custom_origin_config_origin_read_timeout` - (Optional) The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase. (`default = 60`)
- `origin_path` - (Optional) - An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. (`default = null`)
- `s3_origin_config_origin_access_identity` - (Optional) - The CloudFront origin access identity to associate with the origin. (`default = ""`)
- `origin_id` - (Required) - A unique identifier for the origin. (`default = ""`)
- `domain_name` - (Required) - The DNS domain name of either the S3 bucket, or web site of your custom origin. (`default = ""`)
- `default_cache_behavior_cookies_forward` - (Required) - Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names (`default = none`)
- `default_cache_behavior_cookies_whitelisted_names` - (Optional) - If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin. (`default = null`)
- `default_cache_behavior_forwarded_values_query_string` - (Required) - Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior. (`default = ""`)
- `default_cache_behavior_min_ttl` - (Optional) - The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds. (`default = ""`)
- `default_cache_behavior_default_ttl` - (Optional) - The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day. (`default = 86400`)
- `default_cache_behavior_max_ttl` - (Optional) - The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days. (`default = 31536000`)
- `default_cache_behavior_target_origin_id` - (Required) - The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior. (`default = ""`)
- `default_cache_behavior_viewer_protocol_policy` - Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https. (`default = ""`)
- `default_cache_behavior_compress` - (Optional) - Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false). (`default = ""`)
- `default_cache_behavior_field_level_encryption_id` - (Optional) - Field level encryption configuration ID (`default = null`)
- `default_cache_behavior_smooth_streaming` - (Optional) - Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior. (`default = null`)
- `default_cache_behavior_trusted_signers` - (Optional) - The AWS accounts, if any, that you want to allow to create signed URLs for private content. (`default = null`)
- `default_cache_behavior_forwarded_values_headers` - (Optional) - Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers. (`default = null`)
- `default_cache_behavior_forwarded_values_query_string_cache_keys` - (Optional) - When specified, along with a value of true for query_string, all query strings are forwarded, however only the query string keys listed in this argument are cached. When omitted with a value of true for query_string, all query string keys are cached. (`default = null`)
- `enable_cloudfront_public_key` - Enable cloudfront public key usage (`default = ""`)
- `cloudfront_public_key_encoded_key` - (Required) The encoded public key that you want to add to CloudFront to use with features like field-level encryption. (`default = ""`)
- `cloudfront_public_key_comment` - (Optional) An optional comment about the public key. (`default = null`)
- `cloudfront_public_key_name` - (Optional) The name for the public key. By default generated by Terraform. (`default = null`)
- `cloudfront_public_key_name_prefix` - (Optional) The name for the public key. Conflicts with cloudfront_public_key_name. (`default = null`)
- `enable_cloudfront_origin_access_identity` - Enable cloudfront origin access identity usage (`default = ""`)
- `cloudfront_origin_access_identity` - (Optional) - An optional comment for the origin access identity. (`default = null`)

## Module Output Variables
----------------------


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
