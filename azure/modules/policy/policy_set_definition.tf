#-----------------------------------------------------------
# Azure policy set definition
#-----------------------------------------------------------
resource "azurerm_policy_set_definition" "policy_set_definition" {
  count = var.enable_policy_set_definition ? 1 : 0

  name         = var.policy_set_definition_name != "" ? var.policy_set_definition_name : "${lower(var.name)}-resource-set-definition-${lower(var.environment)}"
  policy_type  = var.policy_set_definition_policy_type
  display_name = var.policy_set_definition_display_name

  description         = var.policy_set_definition_description
  management_group_id = var.policy_set_definition_management_group_id
  metadata            = var.policy_set_definition_metadata
  parameters          = var.policy_set_definition_parameters

  dynamic "policy_definition_reference" {
    iterator = policy_definition_reference
    for_each = var.policy_set_definition_policy_policy_definition_reference

    content {
      policy_definition_id = lookup(policy_definition_reference.value, "policy_definition_id", null)

      parameter_values   = lookup(policy_definition_reference.value, "parameter_values", null)
      reference_id       = lookup(policy_definition_reference.value, "reference_id", null)
      policy_group_names = lookup(policy_definition_reference.value, "policy_group_names", null)
    }
  }

  dynamic "policy_definition_group" {
    iterator = policy_definition_group
    for_each = var.policy_set_definition_policy_definition_group

    content {
      name = lookup(policy_definition_group.value, "name", null)

      display_name                    = lookup(policy_definition_group.value, "display_name", null)
      category                        = lookup(policy_definition_group.value, "category", null)
      description                     = lookup(policy_definition_group.value, "description", null)
      additional_metadata_resource_id = lookup(policy_definition_group.value, "additional_metadata_resource_id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.policy_set_definition_timeouts)) > 0 ? [var.policy_set_definition_timeouts] : []

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
    azurerm_resource_group_policy_assignment.resource_group_policy_assignment
  ]
}