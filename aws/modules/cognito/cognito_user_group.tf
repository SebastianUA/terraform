#---------------------------------------------------
# AWS cognito user group
#---------------------------------------------------
resource "aws_cognito_user_group" "cognito_user_group" {
  count = var.enable_cognito_user_group ? 1 : 0

  name         = var.cognito_user_group_name != "" ? var.cognito_user_group_name : "${lower(var.name)}-cognito-user-group-${lower(var.environment)}"
  user_pool_id = var.cognito_user_group_pool_id != "" ? var.cognito_user_group_pool_id : (var.enable_cognito_user_pool ? aws_cognito_user_pool.cognito_user_pool[count.index].id : null)

  description = var.cognito_user_group_description
  precedence  = var.cognito_user_group_precedence
  role_arn    = var.cognito_user_group_role_arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cognito_user_pool.cognito_user_pool
  ]
}