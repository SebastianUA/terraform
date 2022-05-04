#-----------------------------------------------------------
# Azure role definition
#-----------------------------------------------------------
resource "azurerm_role_definition" "role_definition" {
  count = var.enable_role_definition ? 1 : 0

  name  = var.role_definition_name != "" ? var.role_definition_name : "${lower(var.name)}-role-definition-${lower(var.environment)}"
  scope = var.role_definition_scope

  description        = var.role_definition_description
  role_definition_id = var.role_definition_role_definition_id
  assignable_scopes  = var.role_definition_assignable_scopes

  dynamic "permissions" {
    iterator = permissions
    for_each = var.role_definition_permissions

    content {
      actions          = lookup(permissions.value, "actions", null)
      data_actions     = lookup(permissions.value, "data_actions", null)
      not_actions      = lookup(permissions.value, "not_actions", null)
      not_data_actions = lookup(permissions.value, "not_data_actions", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.role_definition_timeouts)) > 0 ? [var.role_definition_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}