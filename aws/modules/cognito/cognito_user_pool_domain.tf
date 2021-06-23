#---------------------------------------------------
# AWS cognito user pool domain
#---------------------------------------------------
resource "aws_cognito_user_pool_domain" "cognito_user_pool_domain" {
  count = var.enable_cognito_user_pool_domain ? 1 : 0

  domain       = var.cognito_user_pool_domain_domain
  user_pool_id = var.cognito_user_pool_domain_user_pool_id != "" ? var.cognito_user_pool_domain_user_pool_id : (var.enable_cognito_user_pool ? aws_cognito_user_pool.cognito_user_pool[count.index].id : null)

  certificate_arn = var.cognito_user_pool_domain_certificate_arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cognito_user_pool.cognito_user_pool
  ]
}
