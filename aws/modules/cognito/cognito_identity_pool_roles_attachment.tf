#---------------------------------------------------
# AWS cognito identity pool roles attachment
#---------------------------------------------------
resource "aws_cognito_identity_pool_roles_attachment" "cognito_identity_pool_roles_attachment" {
  count = var.enable_cognito_identity_pool_roles_attachment ? 1 : 0

  identity_pool_id = var.cognito_identity_pool_roles_attachment_identity_pool_id != "" ? var.cognito_identity_pool_roles_attachment_identity_pool_id : (var.enable_cognito_identity_pool ? aws_cognito_identity_pool.cognito_identity_pool[count.index].id : null)
  roles            = var.cognito_identity_pool_roles_attachment_roles

  dynamic "role_mapping" {
    iterator = role_mapping
    for_each = var.cognito_identity_pool_roles_attachment_role_mapping

    content {
      identity_provider = lookup(role_mapping.value, "identity_provider", null)
      type              = lookup(role_mapping.value, "identity_provider", null)

      ambiguous_role_resolution = lookup(role_mapping.value, "identity_provider", null)

      dynamic "mapping_rule" {
        iterator = mapping_rule
        for_each = length(keys(lookup(role_mapping.value, "mapping_rule", {}))) > 0 ? [lookup(role_mapping.value, "mapping_rule", {})] : []

        content {
          claim      = lookup(mapping_rule.value, "claim", null)
          match_type = lookup(mapping_rule.value, "match_type", null)
          role_arn   = lookup(mapping_rule.value, "role_arn", null)
          value      = lookup(mapping_rule.value, "value", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cognito_identity_pool.cognito_identity_pool
  ]
}