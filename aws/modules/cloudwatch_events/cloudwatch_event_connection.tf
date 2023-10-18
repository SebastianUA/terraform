#---------------------------------------------------
# Cloudwatch event connection
#---------------------------------------------------
resource "aws_cloudwatch_event_connection" "cloudwatch_event_connection" {
  count = var.enable_cloudwatch_event_connection ? 1 : 0

  name               = var.cloudwatch_event_connection_name != "" ? var.cloudwatch_event_connection_name : "${lower(var.name)}-cw-event-connection-${lower(var.environment)}"
  authorization_type = var.cloudwatch_event_connection_authorization_type

  description = var.cloudwatch_event_connection_description

  dynamic "auth_parameters" {
    iterator = auth_parameters
    for_each = length(keys(var.cloudwatch_event_connection_auth_parameters)) > 0 ? [var.cloudwatch_event_connection_auth_parameters] : []

    content {
      dynamic "basic" {
        iterator = basic
        for_each = length(keys(lookup(auth_parameters.value, "basic", {}))) > 0 ? [lookup(auth_parameters.value, "basic", {})] : []

        content {
          username = lookup(basic.value, "username", null)
          password = lookup(basic.value, "password", null)
        }
      }

      dynamic "api_key" {
        iterator = api_key
        for_each = length(keys(lookup(auth_parameters.value, "api_key", {}))) > 0 ? [lookup(auth_parameters.value, "api_key", {})] : []

        content {
          key   = lookup(api_key.value, "key", null)
          value = lookup(api_key.value, "value", null)
        }
      }

      dynamic "oauth" {
        iterator = oauth
        for_each = length(keys(lookup(auth_parameters.value, "oauth", {}))) > 0 ? [lookup(auth_parameters.value, "oauth", {})] : []

        content {
          authorization_endpoint = lookup(oauth.value, "authorization_endpoint", null)
          http_method            = lookup(oauth.value, "http_method", null)

          dynamic "client_parameters" {
            iterator = client_parameters
            for_each = length(keys(lookup(oauth.value, "client_parameters", {}))) > 0 ? [lookup(oauth.value, "client_parameters", {})] : []

            content {
              client_id     = lookup(client_parameters.value, "client_id", null)
              client_secret = lookup(client_parameters.value, "client_secret", null)
            }
          }

          dynamic "oauth_http_parameters" {
            iterator = oauth_http_parameters
            for_each = length(keys(lookup(oauth.value, "oauth_http_parameters", {}))) > 0 ? [lookup(oauth.value, "oauth_http_parameters", {})] : []

            content {
              dynamic "body" {
                iterator = body
                for_each = length(keys(lookup(oauth_http_parameters.value, "body", {}))) > 0 ? lookup(oauth_http_parameters.value, "body", {}) : []

                content {
                  key             = lookup(body.value, "key", null)
                  value           = lookup(body.value, "value", null)
                  is_value_secret = lookup(body.value, "is_value_secret", null)
                }
              }

              dynamic "header" {
                iterator = header
                for_each = length(keys(lookup(oauth_http_parameters.value, "header", {}))) > 0 ? lookup(oauth_http_parameters.value, "header", {}) : []

                content {
                  key             = lookup(header.value, "key", null)
                  value           = lookup(header.value, "value", null)
                  is_value_secret = lookup(header.value, "is_value_secret", null)
                }
              }

              dynamic "query_string" {
                iterator = query_string
                for_each = length(keys(lookup(oauth_http_parameters.value, "query_string", {}))) > 0 ? lookup(oauth_http_parameters.value, "query_string", {}) : []

                content {
                  key             = lookup(query_string.value, "key", null)
                  value           = lookup(query_string.value, "value", null)
                  is_value_secret = lookup(query_string.value, "is_value_secret", null)
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "invocation_http_parameters" {
    iterator = invocation_http_parameters
    for_each = length(keys(var.cloudwatch_event_connection_invocation_http_parameters)) > 0 ? [var.cloudwatch_event_connection_invocation_http_parameters] : []

    content {
      dynamic "body" {
        iterator = body
        for_each = length(keys(lookup(invocation_http_parameters.value, "body", {}))) > 0 ? lookup(invocation_http_parameters.value, "body", {}) : []

        content {
          key             = lookup(body.value, "key", null)
          value           = lookup(body.value, "value", null)
          is_value_secret = lookup(body.value, "is_value_secret", null)
        }
      }

      dynamic "header" {
        iterator = header
        for_each = length(keys(lookup(invocation_http_parameters.value, "header", {}))) > 0 ? lookup(invocation_http_parameters.value, "header", {}) : []

        content {
          key             = lookup(header.value, "key", null)
          value           = lookup(header.value, "value", null)
          is_value_secret = lookup(header.value, "is_value_secret", null)
        }
      }

      dynamic "query_string" {
        iterator = query_string
        for_each = length(keys(lookup(invocation_http_parameters.value, "query_string", {}))) > 0 ? lookup(invocation_http_parameters.value, "query_string", {}) : []

        content {
          key             = lookup(query_string.value, "key", null)
          value           = lookup(query_string.value, "value", null)
          is_value_secret = lookup(query_string.value, "is_value_secret", null)
        }
      }
    }
  }
}
