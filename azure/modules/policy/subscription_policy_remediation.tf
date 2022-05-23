#-----------------------------------------------------------
# Azure subscription policy remediation
#-----------------------------------------------------------
resource "azurerm_subscription_policy_remediation" "subscription_policy_remediation" {
  count = var.enable_subscription_policy_remediation ? 1 : 0

  name                 = var.subscription_policy_remediation_name != "" ? var.subscription_policy_remediation_name : "${lower(var.name)}-subscription-policy-remediation-${lower(var.environment)}"
  subscription_id      = var.subscription_policy_remediation_subscription_id
  policy_assignment_id = var.subscription_policy_remediation_policy_assignment_id != "" ? var.subscription_policy_remediation_policy_assignment_id : (var.enable_subscription_policy_assignment ? azurerm_subscription_policy_assignment.subscription_policy_assignment[count.index].id : null)

  policy_definition_id    = var.subscription_policy_remediation_policy_definition_id
  location_filters        = var.subscription_policy_remediation_location_filters
  resource_discovery_mode = var.subscription_policy_remediation_resource_discovery_mode

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subscription_policy_remediation_timeouts)) > 0 ? [var.subscription_policy_remediation_timeouts] : []

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
    azurerm_subscription_policy_assignment.subscription_policy_assignment
  ]
}