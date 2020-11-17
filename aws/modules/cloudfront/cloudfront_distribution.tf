#---------------------------------------------------
# AWS cloudfront distribution
#---------------------------------------------------
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  count = var.enable_cloudfront_distribution ? 1 : 0

  enabled = var.cloudfront_distribution_enabled

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.viewer_certificate_acm_certificate_arn == "" ? (var.viewer_certificate_cloudfront_default_certificate != null ? var.viewer_certificate_cloudfront_default_certificate : true) : false
    acm_certificate_arn            = var.viewer_certificate_acm_certificate_arn
    iam_certificate_id             = var.viewer_certificate_iam_certificate_id
    minimum_protocol_version       = var.viewer_certificate_minimum_protocol_version
    ssl_support_method             = var.viewer_certificate_acm_certificate_arn == "" ? var.viewer_certificate_ssl_support_method : "https"
  }

  default_cache_behavior {
    allowed_methods = var.default_cache_behavior_allowed_methods
    cached_methods  = var.default_cache_behavior_cached_methods

    forwarded_values {
      query_string = var.default_cache_behavior_forwarded_values_query_string

      cookies {
        forward           = var.default_cache_behavior_cookies_forward
        whitelisted_names = var.default_cache_behavior_cookies_whitelisted_names
      }

      headers                 = var.default_cache_behavior_forwarded_values_headers
      query_string_cache_keys = var.default_cache_behavior_forwarded_values_query_string_cache_keys
    }

    min_ttl                = var.default_cache_behavior_min_ttl
    default_ttl            = var.default_cache_behavior_default_ttl
    max_ttl                = var.default_cache_behavior_max_ttl
    target_origin_id       = var.default_cache_behavior_target_origin_id != "" ? lower(var.default_cache_behavior_target_origin_id) : "default-cache"
    viewer_protocol_policy = var.viewer_certificate_acm_certificate_arn == "" ? (var.default_cache_behavior_viewer_protocol_policy != "" ? var.default_cache_behavior_viewer_protocol_policy : "allow-all") : "redirect-to-https"
    compress               = var.default_cache_behavior_compress

    field_level_encryption_id = var.default_cache_behavior_field_level_encryption_id
    smooth_streaming          = var.default_cache_behavior_smooth_streaming
    trusted_signers           = var.default_cache_behavior_trusted_signers

    # lambda_function_association {
    #   # var.default_cache_behavior_lambda_function_association
    #   lambda_function_association {
    #     event_type   = var.lambda_function_association_event_type
    #     lambda_arn   = var.lambda_function_association_lambda_arn
    #     include_body = var.lambda_function_association_include_body
    #   }
    # }
  }

  origin {
    origin_id = var.origin_id != "" ? lower(var.origin_id) : "default-cache"

    domain_name = var.domain_name
    origin_path = var.origin_path

    custom_header {
      name  = "X-Forwarded-Scheme"
      value = var.viewer_certificate_acm_certificate_arn == "" ? "http" : "https"
    }

    custom_origin_config {
      origin_protocol_policy   = var.custom_origin_config_origin_protocol_policy
      http_port                = var.custom_origin_config_http_port
      https_port               = var.custom_origin_config_https_port
      origin_ssl_protocols     = var.custom_origin_config_origin_ssl_protocols
      origin_keepalive_timeout = var.custom_origin_config_origin_keepalive_timeout
      origin_read_timeout      = var.custom_origin_config_origin_read_timeout
    }

    s3_origin_config {
      origin_access_identity = var.s3_origin_config_origin_access_identity
    }
  }

  default_root_object = var.cloudfront_distribution_default_root_object
  aliases             = var.cloudfront_distribution_aliases
  comment             = var.cloudfront_distribution_comment
  is_ipv6_enabled     = var.cloudfront_distribution_is_ipv6_enabled
  http_version        = var.cloudfront_distribution_http_version

  custom_error_response {
    error_code = var.custom_error_response_error_code

    error_caching_min_ttl = var.custom_error_response_error_caching_min_ttl
    response_code         = var.custom_error_response_response_code
    response_page_path    = var.custom_error_response_response_page_path
  }

  logging_config {
    bucket = var.logging_config_bucket

    include_cookies = var.logging_config_include_cookies
    prefix          = var.logging_config_prefix
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = var.ordered_cache_behavior_path_pattern
    allowed_methods  = var.ordered_cache_behavior_allowed_methods
    cached_methods   = var.ordered_cache_behavior_cached_methods
    target_origin_id = var.ordered_cache_behavior_target_origin_id

    forwarded_values {
      query_string = var.ordered_cache_behavior_forwarded_values_query_string

      cookies {
        forward = var.ordered_cache_behavior_cookies_forward
      }
    }

    min_ttl                = var.ordered_cache_behavior_min_ttl
    default_ttl            = var.ordered_cache_behavior_default_ttl
    max_ttl                = var.ordered_cache_behavior_max_ttl
    compress               = var.ordered_cache_behavior_compress
    viewer_protocol_policy = var.ordered_cache_behavior_viewer_protocol_policy
  }

  origin_group {
    origin_id = var.origin_group_origin_id != "" ? lower(var.origin_group_origin_id) : "groupS3"

    failover_criteria {
      status_codes = var.origin_group_failover_criteria_status_codes
    }

    member {
      origin_id = var.origin_group_member_origin_id_1 != "" ? lower(var.origin_group_member_origin_id_1) : "primaryS3"
    }

    member {
      origin_id = var.origin_group_member_origin_id_2 != "" ? lower(var.origin_group_member_origin_id_2) : "failoverS3"
    }
  }

  price_class         = var.cloudfront_distribution_price_class
  web_acl_id          = var.cloudfront_distribution_web_acl_id
  retain_on_delete    = var.cloudfront_distribution_retain_on_delete
  wait_for_deployment = var.cloudfront_distribution_wait_for_deployment

  tags = merge(
    {
      "Name" = var.cloudfront_distribution_name != "" ? lower(var.cloudfront_distribution_name) : "${lower(var.name)}-cloudfront-distribution-${lower(var.environment)}"
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
