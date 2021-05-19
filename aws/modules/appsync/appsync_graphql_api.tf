#---------------------------------------------------
# AWS Appsync graphql api
#---------------------------------------------------
resource "aws_appsync_graphql_api" "appsync_graphql_api" {
  count = var.enable_appsync_graphql_api ? 1 : 0

  name                = var.appsync_graphql_api_name != "" ? lower(var.appsync_graphql_api_name) : "${lower(var.name)}-appsync-graphql-api-${lower(var.environment)}"
  authentication_type = upper(var.appsync_graphql_api_authentication_type)

  schema       = var.appsync_graphql_api_schema
  xray_enabled = var.appsync_graphql_api_xray_enabled

  dynamic "log_config" {
    iterator = logconfig
    for_each = var.appsync_graphql_api_log_config

    content {
      cloudwatch_logs_role_arn = lookup(logconfig.value, "cloudwatch_logs_role_arn", null)
      field_log_level          = lookup(logconfig.value, "field_log_level", null)
    }
  }

  dynamic "openid_connect_config" {
    iterator = openidconfig
    for_each = var.appsync_graphql_api_openid_connect_config

    content {
      issuer = lookup(openidconfig.value, "issuer", null)

      auth_ttl  = lookup(openidconfig.value, "auth_ttl", null)
      client_id = lookup(openidconfig.value, "client_id", null)
      iat_ttl   = lookup(openidconfig.value, "iat_ttl", null)
    }

  }

  dynamic "user_pool_config" {
    iterator = userpoolconfig
    for_each = var.appsync_graphql_api_user_pool_config

    content {
      default_action = lookup(userpoolconfig.value, "default_action", null)
      user_pool_id   = lookup(userpoolconfig.value, "user_pool_id", null)

      app_id_client_regex = lookup(userpoolconfig.value, "app_id_client_regex", null)
      aws_region          = lookup(userpoolconfig.value, "aws_region", null)
    }
  }

  dynamic "additional_authentication_provider" {
    iterator = addauthprovider
    for_each = var.appsync_graphql_api_additional_authentication_provider

    content {
      authentication_type = lookup(addauthprovider.value, "authentication_type", null)

      dynamic "openid_connect_config" {
        iterator = openid_connect_config
        for_each = length(keys(lookup(addauthprovider.value, "openid_connect_config", {}))) > 0 ? [lookup(addauthprovider.value, "openid_connect_config", {})] : []

        content {
          issuer = lookup(openid_connect_config.value, "issuer", null)

          auth_ttl  = lookup(openid_connect_config.value, "auth_ttl", null)
          client_id = lookup(openid_connect_config.value, "client_id", null)
          iat_ttl   = lookup(openid_connect_config.value, "iat_ttl", null)
        }
      }

      dynamic "user_pool_config" {
        iterator = user_pool_config
        for_each = length(keys(lookup(addauthprovider.value, "user_pool_config", {}))) > 0 ? [lookup(addauthprovider.value, "user_pool_config", {})] : []

        content {
          user_pool_id = lookup(user_pool_config.value, "user_pool_id", null)

          app_id_client_regex = lookup(user_pool_config.value, "app_id_client_regex", null)
          aws_region          = lookup(user_pool_config.value, "aws_region", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.appsync_graphql_api_name != "" ? lower(var.appsync_graphql_api_name) : "${lower(var.name)}-appsync-graphql-api-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
