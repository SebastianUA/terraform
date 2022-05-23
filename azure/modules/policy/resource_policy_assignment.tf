#-----------------------------------------------------------
# Azure resource policy assignment
#-----------------------------------------------------------
resource "azurerm_resource_policy_assignment" "resource_policy_assignment" {
  count = var.enable_resource_policy_assignment ? 1 : 0

  name                 = var.resource_policy_assignment_name != "" ? var.resource_policy_assignment_name : "${lower(var.name)}-resource-policy-assignment-${lower(var.environment)}"
  resource_id          = var.resource_policy_assignment_resource_id
  policy_definition_id = var.resource_policy_assignment_policy_definition_id != "" ? var.resource_policy_assignment_policy_definition_id : (var.enable_policy_definition ? azurerm_policy_definition.policy_definition[count.index].id : null)

  description  = var.resource_policy_assignment_description
  display_name = var.resource_policy_assignment_display_name
  enforce      = var.resource_policy_assignment_enforce
  location     = var.resource_policy_assignment_location
  metadata     = var.resource_policy_assignment_metadata
  not_scopes   = var.resource_policy_assignment_not_scopes
  parameters   = var.resource_policy_assignment_parameters

  dynamic "identity" {
    iterator = identity
    for_each = [var.resource_policy_assignment_identity]

    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "non_compliance_message" {
    iterator = non_compliance_message
    for_each = var.resource_policy_assignment_non_compliance_message

    content {
      content = lookup(non_compliance_message.value, "content", null)

      policy_definition_reference_id = lookup(non_compliance_message.value, "policy_definition_reference_id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.resource_policy_assignment_timeouts)) > 0 ? [var.resource_policy_assignment_timeouts] : []

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
    azurerm_policy_definition.policy_definition
  ]
}