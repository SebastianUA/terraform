#---------------------------------------------------
# AWS cognito resource server
#---------------------------------------------------
resource "aws_cognito_resource_server" "cognito_resource_server" {
  count = var.enable_cognito_resource_server ? 1 : 0

  name         = var.cognito_resource_server_name != "" ? var.cognito_resource_server_name : "${lower(var.name)}-cognito-resource-server-${lower(var.environment)}"
  user_pool_id = var.cognito_resource_server_user_pool_id != "" ? var.cognito_resource_server_user_pool_id : (var.enable_cognito_user_pool ? aws_cognito_user_pool.cognito_user_pool[count.index].id : null)
  identifier   = var.cognito_resource_server_identifier

  dynamic "scope" {
    iterator = scope
    for_each = var.cognito_resource_server_scope

    content {
      scope_name        = lookup(scope.value, "scope_name", null)
      scope_description = lookup(scope.value, "scope_description", null)
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