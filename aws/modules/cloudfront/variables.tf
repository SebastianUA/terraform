#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

variable "tags" {
  description   = "Add additional tags"
  default       = {}
}

#---------------------------------------------------
# AWS cloudfront distribution
#---------------------------------------------------
variable "enable_cloudfront_distribution" {
  description = "Enable cloudfront distribution usage"
  default     = false
}

variable "cloudfront_distribution_name" {
  description = "Set name for cloudfront distribution"
  default     = ""
}

variable "cloudfront_distribution_enabled" {
  description = "(Required) - Whether the distribution is enabled to accept end user requests for content."
  default     = true
}

variable "cloudfront_distribution_default_root_object" {
  description = "(Optional) - The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  default     = null
}

variable "cloudfront_distribution_aliases" {
  description = "(Optional) - Extra CNAMEs (alternate domain names), if any, for this distribution."
  default     = null
}

variable "cloudfront_distribution_comment" {
  description = "(Optional) - Any comments you want to include about the distribution."
  default     = null
}

#variable "cloudfront_distribution_custom_error_response" {
#  description = "(Optional) - One or more custom error response elements (multiples allowed)."
#  default     = null
#}

variable "custom_error_response_error_code" {
  description = "(Required) - The 4xx or 5xx HTTP status code that you want to customize."
  default     = 404
}

variable "custom_error_response_error_caching_min_ttl" {
  description = "(Optional) - The minimum amount of time you want HTTP error codes to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
  default     = null
}

variable "custom_error_response_response_code" {
  description = "(Optional) - The HTTP status code that you want CloudFront to return with the custom error page to the viewer."
  default     = null
}

variable "custom_error_response_response_page_path" {
  description = "(Optional) - The path of the custom error page (for example, /custom_404.html)."
  default     = null
}

variable "cloudfront_distribution_is_ipv6_enabled" {
  description = "(Optional) - Whether the IPv6 is enabled for the distribution."
  default     = null
}

variable "cloudfront_distribution_http_version" {
  description = "(Optional) - The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2."
  default     = "http2"
}

#variable "cloudfront_distribution_logging_config" {
#  description = "(Optional) - The logging configuration that controls how logs are written to your distribution (maximum one)."
#  default     = null
#}

variable "logging_config_bucket" {
  description = "(Required) - The Amazon S3 bucket to store the access logs in, for example, myawslogbucket.s3.amazonaws.com."
  default     = null
}

variable "logging_config_include_cookies" {
  description = "(Optional) - Specifies whether you want CloudFront to include cookies in access logs (default: false)."
  default     = false
}

variable "logging_config_prefix" {
  description = "(Optional) - An optional string that you want CloudFront to prefix to the access log filenames for this distribution, for example, myprefix/."
  default     = null
}

variable "ordered_cache_behavior_path_pattern" {
  description = "(Required) - The pattern (for example, images/*.jpg) that specifies which requests you want this cache behavior to apply to."
  default     = "/content/*"
}

variable "ordered_cache_behavior_allowed_methods" {
  description = "(Required) - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "ordered_cache_behavior_cached_methods" {
  description = "(Required) - Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  default     = ["GET", "HEAD"]
}

variable "ordered_cache_behavior_target_origin_id" {
  description = "(Required) - The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior."
  default     = "groupS3"
}

variable "ordered_cache_behavior_forwarded_values_query_string" {
  description = "(Required) - Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
  default     = false
}

variable "ordered_cache_behavior_cookies_forward" {
  description = "(Required) - Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names"
  default     = "none"
}

variable "ordered_cache_behavior_min_ttl" {
  description = "(Optional) - The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds."
  default     = 0
}

variable "ordered_cache_behavior_default_ttl" {
  description = "(Optional) - The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day."
  default     = 3600
}

variable "ordered_cache_behavior_max_ttl" {
  description = "(Optional) - The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days."
  default     = 86400
}

variable "ordered_cache_behavior_compress" {
  description = "(Optional) - Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)."
  default     = true
}

variable "ordered_cache_behavior_viewer_protocol_policy" {
  description = "(Required) - Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
  default     = "redirect-to-https"
}

variable "origin_group_origin_id" {
  description = "description"
  default     = ""
}

variable "origin_group_failover_criteria_status_codes" {
  description = "(Required) - A list of HTTP status codes for the origin group"
  default     = [403, 404, 500, 502]
}

variable "origin_group_member_origin_id_1" {
  description = "(Required) - The unique identifier of the member origin"
  default     = ""
}

variable "origin_group_member_origin_id_2" {
  description = "(Required) - The unique identifier of the member origin"
  default     = ""
}

variable "cloudfront_distribution_price_class" {
  description = "(Optional) - The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  default     = null
}

variable "cloudfront_distribution_web_acl_id" {
  description = "(Optional) - If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned."
  default     = null
}

variable "cloudfront_distribution_retain_on_delete" {
  description = "Optional) - Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. Default: false."
  default     = false
}

variable "cloudfront_distribution_wait_for_deployment" {
  description = "(Optional) - If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. Default: true."
  default     = true
}

#variable "cloudfront_distribution_geo_restriction" {
#  description = "The restrictions sub-resource takes another single sub-resource named geo_restriction (see the example for usage)."
#  default     = {
#    restriction_type = "none"
#    locations = []
#  }
#}

variable "geo_restriction_restriction_type" {
  description = "(Required) - The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "(Optional) - The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)"
  default     = []
}

#variable "cloudfront_distribution_viewer_certificate" {
#  description = "(Required) - The SSL configuration for this distribution (maximum one)."
#  default     = {
#    cloudfront_default_certificate  = true
#  }
#}

variable "viewer_certificate_cloudfront_default_certificate" {
  description = "cloudfront_default_certificate - true if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution. Specify this, acm_certificate_arn, or iam_certificate_id."
  default     = true
}

variable "viewer_certificate_acm_certificate_arn" {
  description = "The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. Specify this, cloudfront_default_certificate, or iam_certificate_id. The ACM certificate must be in US-EAST-1."
  default     = ""
}

variable "viewer_certificate_iam_certificate_id" {
  description = "The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain. Specify this, acm_certificate_arn, or cloudfront_default_certificate."
  default     = null
}

variable "viewer_certificate_minimum_protocol_version" {
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. Can only be set if cloudfront_default_certificate = false. One of SSLv3, TLSv1, TLSv1_2016, TLSv1.1_2016 or TLSv1.2_2018. Default: TLSv1. NOTE: If you are using a custom certificate (specified with acm_certificate_arn or iam_certificate_id), and have specified sni-only in ssl_support_method, TLSv1 or later must be specified. If you have specified vip in ssl_support_method, only SSLv3 or TLSv1 can be specified. If you have specified cloudfront_default_certificate, TLSv1 must be specified."
  default     = "TLSv1"
}

variable "viewer_certificate_ssl_support_method" {
  description = "Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only. Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges."
  default     = null
}

variable "default_cache_behavior_allowed_methods" {
  description = "(Required) - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
  default     = ["GET", "HEAD", "DELETE", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "default_cache_behavior_cached_methods" {
  description = "(Required) - Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  default     = ["GET", "HEAD"]
}

variable "custom_origin_config_origin_protocol_policy" {
  description = "(Required) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer."
  default     = "http-only"
}

variable "custom_origin_config_http_port" {
  description = "(Required) - The HTTP port the custom origin listens on."
  default     = 80
}

variable "custom_origin_config_https_port" {
  description = "(Required) - The HTTPS port the custom origin listens on."
  default     = 443
}

variable "custom_origin_config_origin_ssl_protocols" {
  description = "(Required) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. A list of one or more of SSLv3, TLSv1, TLSv1.1, and TLSv1.2."
  default     = ["TLSv1"]
}

variable "custom_origin_config_origin_keepalive_timeout" {
  description = "(Optional) The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = 60
}

variable "custom_origin_config_origin_read_timeout" {
  description = "(Optional) The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = 60
}

variable "origin_path" {
  description = "(Optional) - An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin."
  default     = null
}

variable "s3_origin_config_origin_access_identity" {
  description = "(Optional) - The CloudFront origin access identity to associate with the origin."
  default     = ""
}

variable "origin_id" {
  description = "(Required) - A unique identifier for the origin."
  default     = ""
}

variable "domain_name" {
  description = "(Required) - The DNS domain name of either the S3 bucket, or web site of your custom origin."
  default     = ""
}

#variable "forwarded_values_cookies" {
#  description = "(Required) - The forwarded values cookies that specifies how CloudFront handles cookies (maximum one)."
#  default     = {
#    forward = "none"
#  }
#}

variable "default_cache_behavior_cookies_forward" {
  description = "(Required) - Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names"
  default     = "none"
}

variable "default_cache_behavior_cookies_whitelisted_names" {
  description = "(Optional) - If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin."
  default     = null
}

variable "default_cache_behavior_forwarded_values_query_string" {
  description = "(Required) - Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
  default     = false
}

variable "default_cache_behavior_min_ttl" {
  description = "(Optional) - The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds."
  default     = 0
}

variable "default_cache_behavior_default_ttl" {
  description = "(Optional) - The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day."
  default     = 86400
}

variable "default_cache_behavior_max_ttl" {
  description = "(Optional) - The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days."
  default     = 31536000
}

variable "default_cache_behavior_target_origin_id" {
  description = "(Required) - The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior."
  default     = ""
}

variable "default_cache_behavior_viewer_protocol_policy" {
 description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
 default     = ""
}

variable "default_cache_behavior_compress" {
  description = "(Optional) - Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)."
  default     = false
}

variable "default_cache_behavior_field_level_encryption_id" {
  description = "(Optional) - Field level encryption configuration ID"
  default     = null
}

#variable "default_cache_behavior_lambda_function_association" {
#  description = "(Optional) - A config block that triggers a lambda function with specific actions. Defined below, maximum 4."
#  default     = null
#}

# variable "lambda_function_association_event_type" {
#   description = "(Required) - The specific event to trigger this function. Valid values: viewer-request, origin-request, viewer-response, origin-response"
#   default     = "viewer-request"
# }

# variable "lambda_function_association_lambda_arn" {
#   description = "(Required) - ARN of the Lambda function."
#   default     = ""
# }

# variable "lambda_function_association_include_body" {
#   description = "(Optional) - When set to true it exposes the request body to the lambda function. Defaults to false. Valid values: true, false"
#   default     = false
# }

variable "default_cache_behavior_smooth_streaming" {
  description = "(Optional) - Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior."
  default     = null
}

variable "default_cache_behavior_trusted_signers" {
  description = "(Optional) - The AWS accounts, if any, that you want to allow to create signed URLs for private content."
  default     = null
}

variable "default_cache_behavior_forwarded_values_headers" {
  description = "(Optional) - Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers."
  default     = null
}

variable "default_cache_behavior_forwarded_values_query_string_cache_keys" {
  description = "(Optional) - When specified, along with a value of true for query_string, all query strings are forwarded, however only the query string keys listed in this argument are cached. When omitted with a value of true for query_string, all query string keys are cached."
  default     = null
}

#---------------------------------------------------
# AWS cloudfront public key
#---------------------------------------------------
variable "enable_cloudfront_public_key" {
  description = "Enable cloudfront public key usage"
  default     = false
}

variable "cloudfront_public_key_encoded_key" {
  description = "(Required) The encoded public key that you want to add to CloudFront to use with features like field-level encryption."
  default     = ""
}

variable "cloudfront_public_key_comment" {
  description = "(Optional) An optional comment about the public key."
  default     = null
}

variable "cloudfront_public_key_name" {
  description = "(Optional) The name for the public key. By default generated by Terraform."
  default     = null
}

variable "cloudfront_public_key_name_prefix" {
  description = "(Optional) The name for the public key. Conflicts with cloudfront_public_key_name."
  default     = null
}

#---------------------------------------------------
# AWS cloudfront origin access identity
#---------------------------------------------------
variable "enable_cloudfront_origin_access_identity" {
  description = "Enable cloudfront origin access identity usage"
  default     = false
}

variable "cloudfront_origin_access_identity" {
  description = "(Optional) - An optional comment for the origin access identity."
  default     = null
}
