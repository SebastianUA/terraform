#-----------------------------------------------------------
# Azure cdn endpoint
#-----------------------------------------------------------
resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  count = var.enable_cdn_endpoint ? 1 : 0

  name                = var.cdn_endpoint_name != "" ? var.cdn_endpoint_name : "${lower(var.name)}-cdn-endpoint-${lower(var.environment)}"
  profile_name        = var.cdn_endpoint_profile_name != "" ? var.cdn_endpoint_profile_name : (var.enable_cdn_profile ? azurerm_cdn_profile.cdn_profile[count.index].name : null)
  location            = var.cdn_endpoint_location
  resource_group_name = var.cdn_endpoint_resource_group_name

  dynamic "origin" {
    iterator = origin
    for_each = length(keys(var.cdn_endpoint_origin)) > 0 ? [var.cdn_endpoint_origin] : []

    content {
      name      = lookup(origin.value, "name", null)
      host_name = lookup(origin.value, "host_name", null)

      http_port  = lookup(origin.value, "http_port", null)
      https_port = lookup(origin.value, "https_port", null)
    }
  }

  is_http_allowed               = var.cdn_endpoint_is_http_allowed
  is_https_allowed              = var.cdn_endpoint_is_https_allowed
  content_types_to_compress     = var.cdn_endpoint_content_types_to_compress
  is_compression_enabled        = var.cdn_endpoint_is_compression_enabled
  querystring_caching_behaviour = var.cdn_endpoint_querystring_caching_behaviour
  optimization_type             = var.cdn_endpoint_optimization_type
  origin_host_header            = var.cdn_endpoint_origin_host_header
  origin_path                   = var.cdn_endpoint_origin_path
  probe_path                    = var.cdn_endpoint_probe_path

  dynamic "geo_filter" {
    iterator = geo_filter
    for_each = var.cdn_endpoint_geo_filter

    content {
      relative_path = lookup(geo_filter.value, "relative_path", null)
      action        = lookup(geo_filter.value, "action", null)
      country_codes = lookup(geo_filter.value, "country_codes", null)
    }
  }

  dynamic "global_delivery_rule" {
    iterator = global_delivery_rule
    for_each = var.cdn_endpoint_global_delivery_rule

    content {
      dynamic "cache_expiration_action" {
        iterator = cache_expiration_action
        for_each = lookup(global_delivery_rule.value, "cache_expiration_action", [])

        content {
          behavior = lookup(cache_expiration_action.value, "behavior", null)

          duration = lookup(cache_expiration_action.value, "duration", null)
        }
      }

      dynamic "cache_key_query_string_action" {
        iterator = cache_key_query_string_action
        for_each = lookup(global_delivery_rule.value, "cache_key_query_string_action", [])

        content {
          behavior = lookup(cache_key_query_string_action.value, "behavior", null)

          parameters = lookup(cache_key_query_string_action.value, "parameters", null)
        }
      }

      dynamic "modify_request_header_action" {
        iterator = modify_request_header_action
        for_each = lookup(global_delivery_rule.value, "modify_request_header_action", [])

        content {
          name   = lookup(modify_request_header_action.value, "name", null)
          action = lookup(modify_request_header_action.value, "action", null)

          value = lookup(modify_request_header_action.value, "value", null)
        }
      }

      dynamic "modify_response_header_action" {
        iterator = modify_response_header_action
        for_each = lookup(global_delivery_rule.value, "modify_response_header_action", [])

        content {
          name   = lookup(modify_response_header_action.value, "name", null)
          action = lookup(modify_response_header_action.value, "action", null)

          value = lookup(modify_response_header_action.value, "value", null)
        }
      }

      dynamic "url_redirect_action" {
        iterator = url_redirect_action
        for_each = lookup(global_delivery_rule.value, "url_redirect_action", [])

        content {
          redirect_type = lookup(url_redirect_action.value, "redirect_type", null)

          protocol     = lookup(url_redirect_action.value, "protocol", null)
          hostname     = lookup(url_redirect_action.value, "hostname", null)
          path         = lookup(url_redirect_action.value, "path", null)
          fragment     = lookup(url_redirect_action.value, "fragment", null)
          query_string = lookup(url_redirect_action.value, "query_string", null)
        }
      }

      dynamic "url_rewrite_action" {
        iterator = url_rewrite_action
        for_each = lookup(global_delivery_rule.value, "url_rewrite_action", [])

        content {
          source_pattern = lookup(url_rewrite_action.value, "source_pattern", null)
          destination    = lookup(url_rewrite_action.value, "destination", null)

          preserve_unmatched_path = lookup(url_rewrite_action.value, "preserve_unmatched_path", null)
        }
      }
    }
  }

  dynamic "delivery_rule" {
    iterator = delivery_rule
    for_each = var.cdn_endpoint_delivery_rule

    content {
      name  = lookup(delivery_rule.value, "name", null)
      order = lookup(delivery_rule.value, "order", null)

      dynamic "cache_expiration_action" {
        iterator = cache_expiration_action
        for_each = lookup(delivery_rule.value, "cache_expiration_action", [])

        content {
          behavior = lookup(cache_expiration_action.value, "behavior", null)

          duration = lookup(cache_expiration_action.value, "duration", null)
        }
      }

      dynamic "cache_key_query_string_action" {
        iterator = cache_key_query_string_action
        for_each = lookup(delivery_rule.value, "cache_key_query_string_action", [])

        content {
          behavior = lookup(cache_key_query_string_action.value, "behavior", null)

          parameters = lookup(cache_key_query_string_action.value, "parameters", null)
        }
      }

      dynamic "cookies_condition" {
        iterator = cookies_condition
        for_each = lookup(delivery_rule.value, "cookies_condition", [])

        content {
          selector = lookup(cookies_condition.value, "selector", null)
          operator = lookup(cookies_condition.value, "operator", null)

          negate_condition = lookup(cookies_condition.value, "negate_condition", null)
          match_values     = lookup(cookies_condition.value, "match_values", null)
          transforms       = lookup(cookies_condition.value, "transforms", null)
        }
      }

      dynamic "device_condition" {
        iterator = device_condition
        for_each = lookup(delivery_rule.value, "device_condition", [])

        content {
          match_values = lookup(device_condition.value, "match_values", null)

          operator         = lookup(device_condition.value, "operator", null)
          negate_condition = lookup(device_condition.value, "negate_condition", null)
        }

      }

      dynamic "http_version_condition" {
        iterator = http_version_condition
        for_each = lookup(delivery_rule.value, "http_version_condition", [])

        content {
          match_values = lookup(http_version_condition.value, "match_values", null)

          operator         = lookup(http_version_condition.value, "operator", null)
          negate_condition = lookup(http_version_condition.value, "negate_condition", null)
        }
      }

      dynamic "modify_request_header_action" {
        iterator = modify_request_header_action
        for_each = lookup(delivery_rule.value, "modify_request_header_action", [])

        content {
          name   = lookup(modify_request_header_action.value, "name", null)
          action = lookup(modify_request_header_action.value, "action", null)

          value = lookup(modify_request_header_action.value, "value", null)
        }
      }

      dynamic "modify_response_header_action" {
        iterator = modify_response_header_action
        for_each = lookup(delivery_rule.value, "modify_response_header_action", [])

        content {
          name   = lookup(modify_response_header_action.value, "name", null)
          action = lookup(modify_response_header_action.value, "action", null)

          value = lookup(modify_response_header_action.value, "value", null)
        }
      }

      dynamic "post_arg_condition" {
        iterator = post_arg_condition
        for_each = lookup(delivery_rule.value, "post_arg_condition", [])

        content {
          selector = lookup(post_arg_condition.value, "selector", null)
          operator = lookup(post_arg_condition.value, "operator", null)

          negate_condition = lookup(post_arg_condition.value, "negate_condition", null)
          match_values     = lookup(post_arg_condition.value, "match_values", null)
          transforms       = lookup(post_arg_condition.value, "transforms", null)
        }
      }

      dynamic "query_string_condition" {
        iterator = query_string_condition
        for_each = lookup(delivery_rule.value, "query_string_condition", [])

        content {
          operator = lookup(query_string_condition.value, "operator", null)

          negate_condition = lookup(query_string_condition.value, "negate_condition", null)
          match_values     = lookup(query_string_condition.value, "match_values", null)
          transforms       = lookup(query_string_condition.value, "transforms", null)
        }
      }

      dynamic "remote_address_condition" {
        iterator = remote_address_condition
        for_each = lookup(delivery_rule.value, "remote_address_condition", [])

        content {
          operator = lookup(remote_address_condition.value, "operator", null)

          negate_condition = lookup(remote_address_condition.value, "negate_condition", null)
          match_values     = lookup(remote_address_condition.value, "match_values", null)
        }
      }

      dynamic "request_body_condition" {
        iterator = request_body_condition
        for_each = lookup(delivery_rule.value, "request_body_condition", [])

        content {
          operator = lookup(request_body_condition.value, "operator", null)

          negate_condition = lookup(request_body_condition.value, "negate_condition", null)
          match_values     = lookup(request_body_condition.value, "match_values", null)
          transforms       = lookup(request_body_condition.value, "transforms", null)
        }
      }

      dynamic "request_header_condition" {
        iterator = request_header_condition
        for_each = lookup(delivery_rule.value, "request_header_condition", [])

        content {
          selector = lookup(request_header_condition.value, "selector", null)
          operator = lookup(request_header_condition.value, "operator", null)

          negate_condition = lookup(request_header_condition.value, "negate_condition", null)
          match_values     = lookup(request_header_condition.value, "match_values", null)
          transforms       = lookup(request_header_condition.value, "transforms", null)
        }
      }

      dynamic "request_method_condition" {
        iterator = request_method_condition
        for_each = lookup(delivery_rule.value, "request_method_condition", [])

        content {
          match_values = lookup(request_method_condition.value, "match_values", null)

          operator         = lookup(request_method_condition.value, "operator", null)
          negate_condition = lookup(request_method_condition.value, "negate_condition", null)
        }
      }

      dynamic "request_scheme_condition" {
        iterator = request_scheme_condition
        for_each = lookup(delivery_rule.value, "request_scheme_condition", [])

        content {
          operator = lookup(request_scheme_condition.value, "operator", null)

          negate_condition = lookup(request_scheme_condition.value, "negate_condition", null)
          match_values     = lookup(request_scheme_condition.value, "match_values", null)
        }
      }

      dynamic "request_uri_condition" {
        iterator = request_uri_condition
        for_each = lookup(delivery_rule.value, "request_uri_condition", [])

        content {
          operator = lookup(request_uri_condition.value, "operator", null)

          negate_condition = lookup(request_uri_condition.value, "negate_condition", null)
          match_values     = lookup(request_uri_condition.value, "match_values", null)
          transforms       = lookup(request_uri_condition.value, "transforms", null)
        }
      }

      dynamic "url_file_extension_condition" {
        iterator = url_file_extension_condition
        for_each = lookup(delivery_rule.value, "url_file_extension_condition", [])

        content {
          operator = lookup(url_file_extension_condition.value, "operator", null)

          negate_condition = lookup(url_file_extension_condition.value, "negate_condition", null)
          match_values     = lookup(url_file_extension_condition.value, "match_values", null)
          transforms       = lookup(url_file_extension_condition.value, "transforms", null)
        }
      }

      dynamic "url_file_name_condition" {
        iterator = url_file_name_condition
        for_each = lookup(delivery_rule.value, "url_file_name_condition", [])

        content {
          operator = lookup(url_file_name_condition.value, "operator", null)

          negate_condition = lookup(url_file_name_condition.value, "negate_condition", null)
          match_values     = lookup(url_file_name_condition.value, "match_values", null)
          transforms       = lookup(url_file_name_condition.value, "transforms", null)
        }
      }

      dynamic "url_path_condition" {
        iterator = url_path_condition
        for_each = lookup(delivery_rule.value, "url_path_condition", [])

        content {
          operator = lookup(url_path_condition.value, "operator", null)

          negate_condition = lookup(url_path_condition.value, "negate_condition", null)
          match_values     = lookup(url_path_condition.value, "match_values", null)
          transforms       = lookup(url_path_condition.value, "transforms", null)
        }
      }

      dynamic "url_redirect_action" {
        iterator = url_redirect_action
        for_each = lookup(delivery_rule.value, "url_redirect_action", [])

        content {
          redirect_type = lookup(url_redirect_action.value, "redirect_type", null)

          protocol     = lookup(url_redirect_action.value, "protocol", null)
          hostname     = lookup(url_redirect_action.value, "hostname", null)
          path         = lookup(url_redirect_action.value, "path", null)
          fragment     = lookup(url_redirect_action.value, "fragment", null)
          query_string = lookup(url_redirect_action.value, "query_string", null)
        }
      }

      dynamic "url_rewrite_action" {
        iterator = url_rewrite_action
        for_each = lookup(delivery_rule.value, "url_rewrite_action", [])

        content {
          source_pattern = lookup(url_rewrite_action.value, "source_pattern", null)
          destination    = lookup(url_rewrite_action.value, "destination", null)

          preserve_unmatched_path = lookup(url_rewrite_action.value, "preserve_unmatched_path", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.cdn_endpoint_timeouts)) > 0 ? [var.cdn_endpoint_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.cdn_endpoint_name != "" ? var.cdn_endpoint_name : "${lower(var.name)}-cdn-endpoint-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_cdn_profile.cdn_profile
  ]
}