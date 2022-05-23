#-----------------------------------------------------------
# Azure resource group policy remediation
#-----------------------------------------------------------
resource "azurerm_resource_group_policy_remediation" "resource_group_policy_remediation" {
  count = var.enable_resource_group_policy_remediation ? 1 : 0

  name                 = var.resource_group_policy_remediation_name != "" ? var.resource_group_policy_remediation_name : "${lower(var.name)}-resource-group-policy-remediation-${lower(var.environment)}"
  resource_group_id    = var.resource_group_policy_remediation_resource_group_id
  policy_assignment_id = var.resource_group_policy_remediation_policy_assignment_id != "" ? var.resource_group_policy_remediation_policy_assignment_id : (var.enable_policy_assignment ? azurerm_policy_assignment.policy_assignment[count.index].id : null)

  policy_definition_id    = var.resource_group_policy_remediation_policy_definition_id
  location_filters        = var.resource_group_policy_remediation_location_filters
  resource_discovery_mode = var.resource_group_policy_remediation_resource_discovery_mode

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.resource_group_policy_remediation_timeouts)) > 0 ? [var.resource_group_policy_remediation_timeouts] : []

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
    azurerm_policy_assignment.policy_assignment
  ]
}