#---------------------------------------------------
# AWS cloudfront cache policy
#---------------------------------------------------
resource "aws_cloudfront_cache_policy" "cloudfront_cache_policy" {
  count = var.enable_cloudfront_cache_policy ? length(var.cloudfront_cache_policy_stack) : 0

  name    = lookup(var.cloudfront_cache_policy_stack[count.index], "name", "${lower(var.name)}-cloudfront-cache-policy-${count.index + 1}-${lower(var.environment)}")
  min_ttl = lookup(var.cloudfront_cache_policy_stack[count.index], "min_ttl", null)

  comment     = lookup(var.cloudfront_cache_policy_stack[count.index], "comment", null)
  default_ttl = lookup(var.cloudfront_cache_policy_stack[count.index], "default_ttl", null)
  max_ttl     = lookup(var.cloudfront_cache_policy_stack[count.index], "max_ttl", null)

  dynamic "parameters_in_cache_key_and_forwarded_to_origin" {
    iterator = parameters_in_cache_key_and_forwarded_to_origin
    for_each = length(keys(lookup(var.cloudfront_cache_policy_stack[count.index], "parameters_in_cache_key_and_forwarded_to_origin", {}))) > 0 ? [lookup(var.cloudfront_cache_policy_stack[count.index], "parameters_in_cache_key_and_forwarded_to_origin", {})] : []

    content {

      dynamic "cookies_config" {
        iterator = cookies_config
        for_each = length(keys(lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "cookies_config", {}))) > 0 ? [lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "cookies_config", {})] : []

        content {
          cookie_behavior = lookup(cookies_config.value, "cookie_behavior", null)

          dynamic "cookies" {
            iterator = cookies
            for_each = length(keys(lookup(cookies_config.value, "cookies", {}))) > 0 ? [lookup(cookies_config.value, "cookies", {})] : []

            content {
              items = lookup(cookies.value, "items", null)
            }
          }
        }
      }

      dynamic "headers_config" {
        iterator = headers_config
        for_each = length(keys(lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "headers_config", {}))) > 0 ? [lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "headers_config", {})] : []

        content {
          header_behavior = lookup(headers_config.value, "header_behavior", null)

          dynamic "headers" {
            iterator = headers
            for_each = length(keys(lookup(headers_config.value, "headers", {}))) > 0 ? [lookup(headers_config.value, "headers", {})] : []

            content {
              items = lookup(headers.value, "items", null)
            }
          }
        }
      }

      dynamic "query_strings_config" {
        iterator = query_strings_config
        for_each = length(keys(lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "query_strings_config", {}))) > 0 ? [lookup(parameters_in_cache_key_and_forwarded_to_origin.value, "query_strings_config", {})] : []

        content {
          query_string_behavior = lookup(query_strings_config.value, "query_string_behavior", null)

          dynamic "query_strings" {
            iterator = query_strings
            for_each = length(keys(lookup(query_strings_config.value, "query_strings", {}))) > 0 ? [lookup(query_strings_config.value, "query_strings", {})] : []

            content {
              items = lookup(query_strings.value, "items", null)
            }
          }
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
