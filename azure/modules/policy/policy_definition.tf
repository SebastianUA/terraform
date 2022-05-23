#-----------------------------------------------------------
# Azure policy definition
#-----------------------------------------------------------
resource "azurerm_policy_definition" "policy_definition" {
  count = var.enable_policy_definition ? 1 : 0

  name         = var.policy_definition_name != "" ? var.policy_definition_name : "${lower(var.name)}-policy-definition-${lower(var.environment)}"
  policy_type  = var.policy_definition_policy_type
  mode         = var.policy_definition_mode
  display_name = var.policy_definition_display_name

  description         = var.policy_definition_description
  management_group_id = var.policy_definition_management_group_id
  policy_rule         = var.policy_definition_policy_rule
  metadata            = var.policy_definition_metadata
  parameters          = var.policy_definition_parameters

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.policy_definition_timeouts)) > 0 ? [var.policy_definition_timeouts] : []

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