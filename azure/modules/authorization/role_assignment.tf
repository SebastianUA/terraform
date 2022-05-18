#-----------------------------------------------------------
# Azure role assignment
#-----------------------------------------------------------
resource "azurerm_role_assignment" "role_assignment" {
  count = var.enable_role_assignment ? 1 : 0

  name         = var.role_assignment_name != "" ? var.role_assignment_name : "${lower(var.name)}-role-assignment-${lower(var.environment)}"
  scope        = var.role_assignment_scope
  principal_id = var.role_assignment_principal_id

  description                            = var.role_assignment_description
  role_definition_id                     = var.role_assignment_role_definition_id != "" ? var.role_assignment_role_definition_id : (var.enable_role_definition ? azurerm_role_definition.role_definition[count.index].role_definition_resource_id : null)
  role_definition_name                   = var.role_assignment_role_definition_name
  condition                              = var.role_assignment_condition
  condition_version                      = var.role_assignment_condition_version
  delegated_managed_identity_resource_id = var.role_assignment_delegated_managed_identity_resource_id
  skip_service_principal_aad_check       = var.role_assignment_skip_service_principal_aad_check

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.role_assignment_timeouts)) > 0 ? [var.role_assignment_timeouts] : []

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

  depends_on = [
    azurerm_role_definition.role_definition
  ]
}