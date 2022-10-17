#---------------------------------------------------
# AWS Sagemaker workforce
#---------------------------------------------------
resource "aws_sagemaker_workforce" "sagemaker_workforce" {
  count = var.enable_sagemaker_workforce ? 1 : 0

  workforce_name = var.sagemaker_workforce_name != "" ? var.sagemaker_workforce_name : "${lower(var.name)}-workforce-${lower(var.environment)}"

  dynamic "cognito_config" {
    iterator = cognito_config
    for_each = var.sagemaker_workforce_cognito_config

    content {
      client_id = lookup(cognito_config.value, "client_id", null)
      user_pool = lookup(cognito_config.value, "user_pool", null)
    }
  }

  dynamic "oidc_config" {
    iterator = oidc_config
    for_each = var.sagemaker_workforce_oidc_config

    content {
      authorization_endpoint = lookup(oidc_config.value, "authorization_endpoint", null)
      client_id              = lookup(oidc_config.value, "client_id", null)
      client_secret          = lookup(oidc_config.value, "client_secret", null)
      issuer                 = lookup(oidc_config.value, "issuer", null)
      jwks_uri               = lookup(oidc_config.value, "jwks_uri", null)
      logout_endpoint        = lookup(oidc_config.value, "logout_endpoint", null)
      token_endpoint         = lookup(oidc_config.value, "token_endpoint", null)
      user_info_endpoint     = lookup(oidc_config.value, "user_info_endpoint", null)
    }
  }

  dynamic "source_ip_config" {
    iterator = source_ip_config
    for_each = var.sagemaker_workforce_source_ip_config

    content {
      cidrs = lookup(source_ip_config.value, "cidrs", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}