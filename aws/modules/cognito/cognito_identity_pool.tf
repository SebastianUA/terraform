#---------------------------------------------------
# AWS cognito identity pool
#---------------------------------------------------
resource "aws_cognito_identity_pool" "cognito_identity_pool" {
  count = var.enable_cognito_identity_pool ? 1 : 0

  identity_pool_name               = var.cognito_identity_pool_name != "" ? var.cognito_identity_pool_name : "${lower(var.name)}-cognito-identity-pool-${lower(var.environment)}"
  allow_unauthenticated_identities = var.cognito_identity_pool_allow_unauthenticated_identities

  allow_classic_flow           = var.cognito_identity_pool_allow_classic_flow
  developer_provider_name      = var.cognito_identity_pool_developer_provider_name
  openid_connect_provider_arns = var.cognito_identity_pool_openid_connect_provider_arns
  saml_provider_arns           = var.cognito_identity_pool_saml_provider_arns
  supported_login_providers    = var.cognito_identity_pool_supported_login_providers

  dynamic "cognito_identity_providers" {
    iterator = cognito_identity_providers
    for_each = var.cognito_identity_pool_cognito_identity_providers

    content {
      client_id               = lookup(cognito_identity_providers.value, "client_id", null)
      provider_name           = lookup(cognito_identity_providers.value, "provider_name", null)
      server_side_token_check = lookup(cognito_identity_providers.value, "server_side_token_check", null)
    }
  }

  tags = merge(
    {
      Name = var.cognito_identity_pool_name != "" ? var.cognito_identity_pool_name : "${lower(var.name)}-cognito-identity-pool-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}