#---------------------------------------------------
# AWS cognito identity provider
#---------------------------------------------------
resource "aws_cognito_identity_provider" "cognito_identity_provider" {
  count = var.enable_cognito_identity_provider ? 1 : 0

  user_pool_id  = var.cognito_identity_provider_user_pool_id != "" ? var.cognito_identity_provider_user_pool_id : (var.enable_cognito_user_pool ? aws_cognito_user_pool.cognito_user_pool[count.index].id : null)
  provider_name = var.cognito_identity_provider_provider_name
  provider_type = var.cognito_identity_provider_provider_type

  attribute_mapping = var.cognito_identity_provider_attribute_mapping
  idp_identifiers   = var.cognito_identity_provider_idp_identifiers
  provider_details  = var.cognito_identity_provider_provider_details

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cognito_user_pool.cognito_user_pool
  ]
}