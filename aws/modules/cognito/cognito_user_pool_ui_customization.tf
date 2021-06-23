#---------------------------------------------------
# AWS cognito user pool ui customization
#---------------------------------------------------
resource "aws_cognito_user_pool_ui_customization" "cognito_user_pool_ui_customization" {
  count = var.enable_cognito_user_pool_ui_customization ? 1 : 0

  user_pool_id = var.cognito_user_pool_ui_customization_user_pool_id != "" ? var.cognito_user_pool_ui_customization_user_pool_id : (var.enable_cognito_user_pool_domain ? aws_cognito_user_pool_domain.cognito_user_pool_domain[count.index].user_pool_id : null)

  client_id  = var.cognito_user_pool_ui_customization_client_id != "" ? var.cognito_user_pool_ui_customization_client_id : (var.enable_cognito_user_pool_client ? aws_cognito_user_pool_client.cognito_user_pool_client[count.index].id : null)
  css        = var.cognito_user_pool_ui_customization_css
  image_file = var.cognito_user_pool_ui_customization_image_file

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cognito_user_pool_client.cognito_user_pool_client,
    aws_cognito_user_pool_domain.cognito_user_pool_domain
  ]
}