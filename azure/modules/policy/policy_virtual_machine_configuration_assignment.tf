#-----------------------------------------------------------
# Azure policy virtual machine configuration assignment
#-----------------------------------------------------------
resource "azurerm_policy_virtual_machine_configuration_assignment" "policy_virtual_machine_configuration_assignment" {
  count = var.enable_policy_virtual_machine_configuration_assignment ? 1 : 0

  name               = var.policy_virtual_machine_configuration_assignment_name != "" ? var.policy_virtual_machine_configuration_assignment_name : "${lower(var.name)}-policy-virt-machine-conf-assignment-${lower(var.environment)}"
  location           = var.policy_virtual_machine_configuration_assignment_location
  virtual_machine_id = var.policy_virtual_machine_configuration_assignment_virtual_machine_id

  dynamic "configuration" {
    iterator = configuration
    for_each = [var.policy_virtual_machine_configuration_assignment_configuration]

    content {
      assignment_type = lookup(configuration.value, "assignment_type", null)
      content_hash    = lookup(configuration.value, "content_hash", null)
      content_uri     = lookup(configuration.value, "content_uri", null)
      version         = lookup(configuration.value, "version", null)

      dynamic "parameter" {
        iterator = parameter
        for_each = lookup(configuration.value, "parameter", [])

        content {
          name  = lookup(parameter.value, "name", null)
          value = lookup(parameter.value, "value", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.policy_virtual_machine_configuration_assignment_timeouts)) > 0 ? [var.policy_virtual_machine_configuration_assignment_timeouts] : []

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