#---------------------------------------------------
# AWS cloudfront origin request policy
#---------------------------------------------------
resource "aws_cloudfront_origin_request_policy" "cloudfront_origin_request_policy" {
  count = var.enable_cloudfront_origin_request_policy ? 1 : 0

  name = var.cloudfront_origin_request_policy_name != "" ? var.cloudfront_origin_request_policy_name : "${lower(var.name)}-cloudfront-origin-request-policy-${lower(var.environment)}"

  comment = var.cloudfront_origin_request_policy_comment

  dynamic "cookies_config" {
    iterator = cookies_config
    for_each = length(keys(lookup(var.cloudfront_origin_request_policy_cookies_config, "cookies_config", {}))) > 0 ? [lookup(var.cloudfront_origin_request_policy_cookies_config, "cookies_config", {})] : []

    content {
      cookie_behavior = lookup(cookies_config.value, "cookie_behavior", null)

      dynamic "cookies" {
        iterator = cookies
        for_each = lookup(cookies_config.value, "cookies", null)

        content {
          items = lookup(cookies.value, "items", null)
        }
      }
    }
  }

  dynamic "headers_config" {
    iterator = headers_config
    for_each = length(keys(lookup(var.cloudfront_origin_request_policy_headers_config, "headers_config", {}))) > 0 ? [lookup(var.cloudfront_origin_request_policy_headers_config, "headers_config", {})] : []

    content {
      header_behavior = lookup(headers_config.value, "header_behavior", null)

      dynamic "headers" {
        iterator = headers
        for_each = lookup(headers_config.value, "headers", null)

        content {
          items = lookup(headers.value, "items", null)
        }
      }
    }
  }

  dynamic "query_strings_config" {
    iterator = query_strings_config
    for_each = length(keys(lookup(var.cloudfront_origin_request_policy_query_strings_config, "query_strings_config", {}))) > 0 ? [lookup(var.cloudfront_origin_request_policy_query_strings_config, "query_strings_config", {})] : []

    content {
      query_string_behavior = lookup(query_strings_config.value, "query_string_behavior", null)

      dynamic "query_strings" {
        iterator = query_strings
        for_each = lookup(query_strings_config.value, "query_strings", null)

        content {
          items = lookup(query_strings.value, "items", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
