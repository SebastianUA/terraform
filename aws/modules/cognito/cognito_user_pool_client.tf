#---------------------------------------------------
# AWS cognito user pool client
#---------------------------------------------------
resource "aws_cognito_user_pool_client" "cognito_user_pool_client" {
  count = var.enable_cognito_user_pool_client ? 1 : 0

  name         = var.cognito_user_pool_client_name != "" ? var.cognito_user_pool_client_name : "${lower(var.name)}-cognito-user-pool-client-${lower(var.environment)}"
  user_pool_id = var.cognito_user_pool_client_user_pool_id != "" ? var.cognito_user_pool_client_user_pool_id : (var.enable_cognito_user_pool ? aws_cognito_user_pool.cognito_user_pool[count.index].id : null)

  access_token_validity                = var.cognito_user_pool_client_access_token_validity
  allowed_oauth_flows_user_pool_client = var.cognito_user_pool_client_allowed_oauth_flows_user_pool_client
  allowed_oauth_flows                  = var.cognito_user_pool_client_allowed_oauth_flows
  allowed_oauth_scopes                 = var.cognito_user_pool_client_allowed_oauth_scopes
  callback_urls                        = var.cognito_user_pool_client_callback_urls
  default_redirect_uri                 = var.cognito_user_pool_client_default_redirect_uri
  explicit_auth_flows                  = var.cognito_user_pool_client_explicit_auth_flows
  generate_secret                      = var.cognito_user_pool_client_generate_secret
  id_token_validity                    = var.cognito_user_pool_client_id_token_validity
  logout_urls                          = var.cognito_user_pool_client_logout_urls
  prevent_user_existence_errors        = var.cognito_user_pool_client_prevent_user_existence_errors
  read_attributes                      = var.cognito_user_pool_client_read_attributes
  refresh_token_validity               = var.cognito_user_pool_client_refresh_token_validity
  supported_identity_providers         = var.cognito_user_pool_client_supported_identity_providers
  write_attributes                     = var.cognito_user_pool_client_write_attributes

  dynamic "analytics_configuration" {
    iterator = analytics_configuration
    for_each = var.cognito_user_pool_client_analytics_configuration

    content {
      application_arn  = lookup(analytics_configuration.value, "application_arn", null)
      application_id   = lookup(analytics_configuration.value, "application_id", null)
      external_id      = lookup(analytics_configuration.value, "external_id", null)
      role_arn         = lookup(analytics_configuration.value, "role_arn", null)
      user_data_shared = lookup(analytics_configuration.value, "user_data_shared", null)
    }
  }

  dynamic "token_validity_units" {
    iterator = token_validity_units
    for_each = var.cognito_user_pool_client_token_validity_units

    content {
      access_token  = lookup(token_validity_units.value, "access_token", null)
      id_token      = lookup(token_validity_units.value, "id_token", null)
      refresh_token = lookup(token_validity_units.value, "refresh_token", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cognito_user_pool.cognito_user_pool
  ]
}