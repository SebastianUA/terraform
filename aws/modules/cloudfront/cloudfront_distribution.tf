#---------------------------------------------------
# AWS cloudfront distribution
#---------------------------------------------------
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  count = var.enable_cloudfront_distribution ? length(var.cloudfront_distribution_stack) : 0

  enabled = lookup(var.cloudfront_distribution_stack[count.index], "enabled", null)

  dynamic "default_cache_behavior" {
    iterator = default_cache_behavior
    for_each = length(keys(lookup(var.cloudfront_distribution_stack[count.index], "default_cache_behavior", {}))) > 0 ? [lookup(var.cloudfront_distribution_stack[count.index], "default_cache_behavior", {})] : []

    content {
      allowed_methods = lookup(default_cache_behavior.value, "allowed_methods", ["GET", "HEAD", "OPTIONS"])
      cached_methods  = lookup(default_cache_behavior.value, "cached_methods", ["GET", "HEAD"])
      // path_pattern           = lookup(default_cache_behavior.value, "path_pattern", "/*")
      target_origin_id       = lookup(default_cache_behavior.value, "target_origin_id", "appsync")
      viewer_protocol_policy = lookup(default_cache_behavior.value, "viewer_protocol_policy", "allow-all")

      compress                  = lookup(default_cache_behavior.value, "compress", null)
      field_level_encryption_id = lookup(default_cache_behavior.value, "field_level_encryption_id", null)
      default_ttl               = lookup(default_cache_behavior.value, "default_ttl", null)
      max_ttl                   = lookup(default_cache_behavior.value, "max_ttl", null)
      min_ttl                   = lookup(default_cache_behavior.value, "min_ttl", null)
      cache_policy_id           = lookup(default_cache_behavior.value, "cache_policy_id", (var.enable_cloudfront_cache_policy ? aws_cloudfront_cache_policy.cloudfront_cache_policy[0].id : null))
      origin_request_policy_id  = lookup(default_cache_behavior.value, "origin_request_policy_id", (var.enable_cloudfront_origin_request_policy ? aws_cloudfront_origin_request_policy.cloudfront_origin_request_policy[0].id : null))
      realtime_log_config_arn   = lookup(default_cache_behavior.value, "realtime_log_config_arn", (var.enable_cloudfront_realtime_log_config ? aws_cloudfront_realtime_log_config.cloudfront_realtime_log_config[0].id : null))
      smooth_streaming          = lookup(default_cache_behavior.value, "smooth_streaming", null)
      trusted_signers           = lookup(default_cache_behavior.value, "trusted_signers", null)

      dynamic "forwarded_values" {
        iterator = forwarded_values
        for_each = length(keys(lookup(default_cache_behavior.value, "forwarded_values", {}))) > 0 ? [lookup(default_cache_behavior.value, "forwarded_values", {})] : []

        content {
          query_string = lookup(forwarded_values.value, "query_string", null)

          headers                 = lookup(forwarded_values.value, "headers", null)
          query_string_cache_keys = lookup(forwarded_values.value, "query_string_cache_keys", null)

          dynamic "cookies" {
            iterator = cookies
            for_each = length(keys(lookup(forwarded_values.value, "cookies", {}))) > 0 ? [lookup(forwarded_values.value, "cookies", {})] : []

            content {
              forward           = lookup(cookies.value, "forward", null)
              whitelisted_names = lookup(cookies.value, "whitelisted_names", null)
            }
          }
        }
      }

      dynamic "lambda_function_association" {
        iterator = lambda_function_association
        for_each = length(keys(lookup(default_cache_behavior.value, "lambda_function_association", {}))) > 0 ? [lookup(default_cache_behavior.value, "lambda_function_association", {})] : []

        content {
          event_type   = lookup(lambda_function_association.value, "event_type", null)
          lambda_arn   = lookup(lambda_function_association.value, "lambda_arn", null)
          include_body = lookup(lambda_function_association.value, "include_body", null)
        }
      }

    }
  }

  dynamic "origin" {
    iterator = origin
    for_each = length(keys(lookup(var.cloudfront_distribution_stack[count.index], "origin", {}))) > 0 ? [lookup(var.cloudfront_distribution_stack[count.index], "origin", {})] : []

    content {
      origin_id   = lookup(origin.value, "origin_id", null)
      domain_name = lookup(origin.value, "domain_name", null)

      origin_path = lookup(origin.value, "origin_path", null)

      dynamic "custom_header" {
        iterator = custom_header
        for_each = lookup(origin.value, "custom_header", [])

        content {
          name  = lookup(custom_header.value, "name", null)
          value = lookup(custom_header.value, "value", null)
        }
      }

      dynamic "custom_origin_config" {
        iterator = custom_origin_config
        for_each = length(keys(lookup(origin.value, "custom_origin_config", {}))) > 0 ? [lookup(origin.value, "custom_origin_config", {})] : []

        content {
          origin_protocol_policy   = lookup(custom_origin_config.value, "origin_protocol_policy", null)
          http_port                = lookup(custom_origin_config.value, "http_port", null)
          https_port               = lookup(custom_origin_config.value, "https_port", null)
          origin_ssl_protocols     = lookup(custom_origin_config.value, "origin_ssl_protocols", null)
          origin_keepalive_timeout = lookup(custom_origin_config.value, "origin_keepalive_timeout", null)
          origin_read_timeout      = lookup(custom_origin_config.value, "origin_read_timeout", null)
        }
      }

      dynamic "s3_origin_config" {
        iterator = s3_origin_config
        for_each = length(keys(lookup(origin.value, "s3_origin_config", {}))) > 0 ? [lookup(origin.value, "s3_origin_config", {})] : []

        content {
          origin_access_identity = lookup(s3_origin_config.value, "origin_access_identity", null)
        }
      }
    }
  }

  dynamic "restrictions" {
    iterator = restrictions
    for_each = length(keys(lookup(var.cloudfront_distribution_stack[count.index], "restrictions", {}))) > 0 ? [lookup(var.cloudfront_distribution_stack[count.index], "restrictions", {})] : []

    content {
      dynamic "geo_restriction" {
        iterator = geo_restriction
        for_each = length(keys(lookup(restrictions.value, "geo_restriction", {}))) > 0 ? [lookup(restrictions.value, "geo_restriction", {})] : []

        content {
          restriction_type = lookup(geo_restriction.value, "restriction_type", null)
          locations        = lookup(geo_restriction.value, "locations", null)
        }
      }
    }
  }

  dynamic "viewer_certificate" {
    iterator = viewer_certificate
    for_each = length(keys(lookup(var.cloudfront_distribution_stack[count.index], "viewer_certificate", {}))) > 0 ? [lookup(var.cloudfront_distribution_stack[count.index], "viewer_certificate", {})] : []

    content {
      cloudfront_default_certificate = lookup(viewer_certificate.value, "cloudfront_default_certificate", null)
      acm_certificate_arn            = lookup(viewer_certificate.value, "acm_certificate_arn", null)
      iam_certificate_id             = lookup(viewer_certificate.value, "iam_certificate_id", null)
      minimum_protocol_version       = lookup(viewer_certificate.value, "minimum_protocol_version", null)
      ssl_support_method             = lookup(viewer_certificate.value, "ssl_support_method", null)
    }
  }

  // Optionals
  aliases             = lookup(var.cloudfront_distribution_stack[count.index], "aliases", null)
  comment             = lookup(var.cloudfront_distribution_stack[count.index], "comment", null)
  default_root_object = lookup(var.cloudfront_distribution_stack[count.index], "default_root_object", null)
  is_ipv6_enabled     = lookup(var.cloudfront_distribution_stack[count.index], "is_ipv6_enabled", null)
  http_version        = lookup(var.cloudfront_distribution_stack[count.index], "http_version", null)
  price_class         = lookup(var.cloudfront_distribution_stack[count.index], "price_class", null)
  web_acl_id          = lookup(var.cloudfront_distribution_stack[count.index], "web_acl_id", null)
  retain_on_delete    = lookup(var.cloudfront_distribution_stack[count.index], "retain_on_delete", null)
  wait_for_deployment = lookup(var.cloudfront_distribution_stack[count.index], "wait_for_deployment", null)

  dynamic "custom_error_response" {
    iterator = custom_error_response
    for_each = length(keys(lookup(var.cloudfront_distribution_stack[count.index], "custom_error_response", {}))) > 0 ? [lookup(var.cloudfront_distribution_stack[count.index], "custom_error_response", {})] : []

    content {
      error_code = lookup(custom_error_response.value, "error_code", null)

      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
    }
  }

  dynamic "logging_config" {
    iterator = logging_config
    for_each = lookup(var.cloudfront_distribution_stack[count.index], "logging_config", [])

    content {
      bucket = lookup(logging_config.value, "bucket", null)

      include_cookies = lookup(logging_config.value, "include_cookies", null)
      prefix          = lookup(logging_config.value, "prefix", null)
    }
  }

  // Cache behavior with precedence
  dynamic "ordered_cache_behavior" {
    iterator = ordered_cache_behavior
    for_each = lookup(var.cloudfront_distribution_stack[count.index], "ordered_cache_behavior", [])

    content {
      allowed_methods        = lookup(ordered_cache_behavior.value, "allowed_methods", ["GET", "HEAD", "OPTIONS"])
      cached_methods         = lookup(ordered_cache_behavior.value, "cached_methods", ["GET", "HEAD"])
      path_pattern           = lookup(ordered_cache_behavior.value, "path_pattern", "/*")
      target_origin_id       = lookup(ordered_cache_behavior.value, "target_origin_id", "appsync")
      viewer_protocol_policy = lookup(ordered_cache_behavior.value, "viewer_protocol_policy", "allow-all")

      compress                  = lookup(ordered_cache_behavior.value, "compress", null)
      field_level_encryption_id = lookup(ordered_cache_behavior.value, "field_level_encryption_id", null)
      default_ttl               = lookup(ordered_cache_behavior.value, "default_ttl", null)
      max_ttl                   = lookup(ordered_cache_behavior.value, "max_ttl", null)
      min_ttl                   = lookup(ordered_cache_behavior.value, "min_ttl", null)
      cache_policy_id           = lookup(ordered_cache_behavior.value, "cache_policy_id", (var.enable_cloudfront_cache_policy ? aws_cloudfront_cache_policy.cloudfront_cache_policy[0].id : null))
      origin_request_policy_id  = lookup(ordered_cache_behavior.value, "origin_request_policy_id", (var.enable_cloudfront_origin_request_policy ? aws_cloudfront_origin_request_policy.cloudfront_origin_request_policy[0].id : null))
      realtime_log_config_arn   = lookup(ordered_cache_behavior.value, "realtime_log_config_arn", (var.enable_cloudfront_realtime_log_config ? aws_cloudfront_realtime_log_config.cloudfront_realtime_log_config[0].id : null))
      smooth_streaming          = lookup(ordered_cache_behavior.value, "smooth_streaming", null)
      trusted_signers           = lookup(ordered_cache_behavior.value, "trusted_signers", null)

      dynamic "forwarded_values" {
        iterator = forwarded_values
        for_each = length(keys(lookup(ordered_cache_behavior.value, "forwarded_values", {}))) > 0 ? [lookup(ordered_cache_behavior.value, "forwarded_values", {})] : []

        content {
          query_string = lookup(forwarded_values.value, "query_string", null)

          headers                 = lookup(forwarded_values.value, "headers", null)
          query_string_cache_keys = lookup(forwarded_values.value, "query_string_cache_keys", null)

          dynamic "cookies" {
            iterator = cookies
            for_each = length(keys(lookup(forwarded_values.value, "cookies", {}))) > 0 ? [lookup(forwarded_values.value, "cookies", {})] : []

            content {
              forward           = lookup(cookies.value, "forward", null)
              whitelisted_names = lookup(cookies.value, "whitelisted_names", null)
            }
          }
        }
      }

      dynamic "lambda_function_association" {
        iterator = lambda_function_association
        for_each = length(keys(lookup(ordered_cache_behavior.value, "lambda_function_association", {}))) > 0 ? [lookup(ordered_cache_behavior.value, "lambda_function_association", {})] : []

        content {
          event_type   = lookup(lambda_function_association.value, "event_type", null)
          lambda_arn   = lookup(lambda_function_association.value, "lambda_arn", null)
          include_body = lookup(lambda_function_association.value, "include_body", null)
        }
      }

    }
  }

  dynamic "origin_group" {
    iterator = origin_group
    for_each = length(keys(lookup(var.cloudfront_distribution_stack[count.index], "origin_group", {}))) > 0 ? [lookup(var.cloudfront_distribution_stack[count.index], "origin_group", {})] : []

    content {
      origin_id = lookup(origin_group.value, "origin_id", null)

      dynamic "failover_criteria" {
        iterator = failover_criteria
        for_each = length(keys(lookup(origin_group.value, "failover_criteria", {}))) > 0 ? [lookup(origin_group.value, "failover_criteria", {})] : []

        content {
          status_codes = lookup(failover_criteria.value, "status_codes", null)
        }
      }

      dynamic "member" {
        iterator = member
        for_each = lookup(origin_group.value, "member", [])

        content {
          origin_id = lookup(member.value, "origin_id", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = lookup(var.cloudfront_distribution_stack[count.index], "name", "${lower(var.name)}-cloudfront-distribution-${count.index + 1}-${lower(var.environment)}")
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cloudfront_cache_policy.cloudfront_cache_policy,
    aws_cloudfront_origin_request_policy.cloudfront_origin_request_policy,
    aws_cloudfront_realtime_log_config.cloudfront_realtime_log_config
  ]
}
