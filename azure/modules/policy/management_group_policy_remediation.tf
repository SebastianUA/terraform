#-----------------------------------------------------------
# Azure management group policy remediation
#-----------------------------------------------------------
resource "azurerm_management_group_policy_remediation" "management_group_policy_remediation" {
  count = var.enable_management_group_policy_remediation ? 1 : 0

  name                 = var.management_group_policy_remediation_name != "" ? var.management_group_policy_remediation_name : "${lower(var.name)}-management-group-policy-remediation-${lower(var.environment)}"
  management_group_id  = var.management_group_policy_remediation_management_group_id
  policy_assignment_id = var.management_group_policy_remediation_policy_assignment_id != "" ? var.management_group_policy_remediation_policy_assignment_id : (var.enable_ ? azurerm_management_group_policy_assignment.management_group_policy_assignment[count.index].id : null)

  policy_definition_id    = var.management_group_policy_remediation_policy_definition_id
  location_filters        = var.management_group_policy_remediation_location_filters
  resource_discovery_mode = var.management_group_policy_remediation_resource_discovery_mode

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.management_group_policy_remediation_timeouts)) > 0 ? [var.management_group_policy_remediation_timeouts] : []

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
    azurerm_management_group_policy_assignment.management_group_policy_assignment
  ]
}