#---------------------------------------------------
# NLB listener rule
#---------------------------------------------------
resource "aws_lb_listener_rule" "nlb_listener_rule" {
  count = var.enable_nlb_listener_rule ? 1 : 0

  listener_arn = var.nlb_listener_rule_listener_arn != "" && !var.enable_nlb_listener ? var.nlb_listener_rule_listener_arn : aws_lb_listener.nlb_listener[0].arn

  priority = var.nlb_listener_rule_priority

  action {
    target_group_arn = var.nlb_listener_rule_action_target_group_arn
    type             = var.nlb_listener_rule_action_type

    dynamic "fixed_response" {
      iterator = fixed_response
      for_each = var.nlb_listener_rule_action_fixed_response

      content {
        content_type = lookup(fixed_response.value, "content_type", null)

        message_body = lookup(fixed_response.value, "message_body", null)
        status_code  = lookup(fixed_response.value, "status_code", null)
      }
    }

    dynamic "forward" {
      iterator = forward
      for_each = var.nlb_listener_rule_action_forward

      content {
        dynamic "target_group" {
          iterator = target_group
          for_each = length(keys(lookup(forward.value, "target_group", {}))) > 0 ? [lookup(forward.value, "target_group", {})] : []

          content {
            arn = lookup(target_group.value, "arn", null)

            weight = lookup(target_group.value, "weight", null)
          }
        }

        dynamic "stickiness" {
          iterator = stickiness
          for_each = length(keys(lookup(forward.value, "stickiness", {}))) > 0 ? [lookup(forward.value, "stickiness", {})] : []

          content {
            enabled  = lookup(stickiness.value, "enabled", null)
            duration = lookup(stickiness.value, "duration", null)
          }
        }
      }
    }

    dynamic "redirect" {
      iterator = redirect
      for_each = var.nlb_listener_rule_action_redirect

      content {
        status_code = lookup(redirect.value, "status_code", null)

        host     = lookup(redirect.value, "host", null)
        path     = lookup(redirect.value, "path", null)
        port     = lookup(redirect.value, "port", null)
        protocol = lookup(redirect.value, "protocol", null)
        query    = lookup(redirect.value, "query", null)
      }
    }

    dynamic "authenticate_cognito" {
      iterator = authenticate_cognito
      for_each = var.nlb_listener_rule_action_authenticate_cognito

      content {
        user_pool_client_id = lookup(authenticate_cognito.value, "user_pool_client_id", null)
        user_pool_domain    = lookup(authenticate_cognito.value, "user_pool_domain", null)
        user_pool_arn       = lookup(authenticate_cognito.value, "user_pool_arn", null)

        authentication_request_extra_params = lookup(authenticate_cognito.value, "authentication_request_extra_params", null)
        on_unauthenticated_request          = lookup(authenticate_cognito.value, "on_unauthenticated_request", null)
        scope                               = lookup(authenticate_cognito.value, "scope", null)
        session_cookie_name                 = lookup(authenticate_cognito.value, "session_cookie_name", null)
        session_timeout                     = lookup(authenticate_cognito.value, "session_timeout", null)
      }
    }

    dynamic "authenticate_oidc" {
      iterator = authenticate_oidc
      for_each = var.nlb_listener_rule_action_authenticate_oidc

      content {
        authorization_endpoint = lookup(authenticate_oidc.value, "authorization_endpoint", null)
        client_id              = lookup(authenticate_oidc.value, "client_id", null)
        client_secret          = lookup(authenticate_oidc.value, "client_secret", null)
        issuer                 = lookup(authenticate_oidc.value, "issuer", null)
        token_endpoint         = lookup(authenticate_oidc.value, "token_endpoint", null)
        user_info_endpoint     = lookup(authenticate_oidc.value, "user_info_endpoint", null)

        authentication_request_extra_params = lookup(authenticate_oidc.value, "authentication_request_extra_params", null)
        on_unauthenticated_request          = lookup(authenticate_oidc.value, "on_unauthenticated_request", null)
        scope                               = lookup(authenticate_oidc.value, "scope", null)
        session_cookie_name                 = lookup(authenticate_oidc.value, "session_cookie_name", null)
        session_timeout                     = lookup(authenticate_oidc.value, "session_timeout", null)
      }
    }
  }

  condition {
    dynamic "host_header" {
      iterator = host_header
      for_each = var.nlb_listener_rule_condition_host_header

      content {
        values = lookup(host_header.value, "values", null)
      }
    }

    dynamic "http_request_method" {
      iterator = http_request_method
      for_each = var.nlb_listener_rule_condition_http_request_method

      content {
        values = lookup(http_request_method.value, "values", null)
      }
    }

    dynamic "path_pattern" {
      iterator = path_pattern
      for_each = var.nlb_listener_rule_condition_path_pattern

      content {
        values = lookup(path_pattern.value, "values", null)
      }
    }

    dynamic "source_ip" {
      iterator = source_ip
      for_each = var.nlb_listener_rule_condition_source_ip

      content {
        values = lookup(source_ip.value, "values", null)
      }
    }

    dynamic "http_header" {
      iterator = http_header
      for_each = var.nlb_listener_rule_condition_http_header

      content {
        http_header_name = lookup(http_header.value, "http_header_name", null)
        values           = lookup(http_header.value, "values", null)
      }
    }

    dynamic "query_string" {
      iterator = query_string
      for_each = var.nlb_listener_rule_condition_query_string

      content {
        key   = lookup(query_string.value, "key", null)
        value = lookup(query_string.value, "value", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb_listener.nlb_listener
  ]
}
