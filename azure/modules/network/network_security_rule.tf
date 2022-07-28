#-----------------------------------------------------------
# Azure network security rule
#-----------------------------------------------------------
resource "azurerm_network_security_rule" "network_security_rule" {
  count = var.enable_network_security_rule ? 1 : 0

  name                        = var.network_security_rule_name != "" ? var.network_security_rule_name : "${lower(var.name)}-network-sg-rule-${lower(var.environment)}"
  resource_group_name         = var.network_security_rule_resource_group_name
  network_security_group_name = var.network_security_rule_network_security_group_name != "" ? var.network_security_rule_network_security_group_name : (var.enable_network_security_group ? azurerm_network_security_group.network_security_group[0].name : null)
  protocol                    = var.network_security_rule_protocol
  access                      = var.network_security_rule_access
  priority                    = var.network_security_rule_priority
  direction                   = var.network_security_rule_direction

  description                                = var.network_security_rule_description
  source_port_range                          = var.network_security_rule_source_port_range
  source_port_ranges                         = var.network_security_rule_source_port_ranges
  destination_port_range                     = var.network_security_rule_destination_port_range
  destination_port_ranges                    = var.network_security_rule_destination_port_ranges
  source_address_prefix                      = var.network_security_rule_source_address_prefix
  source_address_prefixes                    = var.network_security_rule_source_address_prefixes
  source_application_security_group_ids      = var.network_security_rule_source_application_security_group_ids
  destination_address_prefix                 = var.network_security_rule_destination_address_prefix
  destination_address_prefixes               = var.network_security_rule_destination_address_prefixes
  destination_application_security_group_ids = var.network_security_rule_destination_application_security_group_ids

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_security_rule_timeouts)) > 0 ? [var.network_security_rule_timeouts] : []

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
    azurerm_network_security_group.network_security_group
  ]
}

resource "azurerm_network_security_rule" "network_security_rule_stacks" {
  count = var.enable_network_security_rule_stacks ? length(var.network_security_rule_stacks) : 0

  name                        = lookup(var.network_security_rule_stacks[count.index], "name", "${lower(var.name)}-network-sg-rule-${count.index + 1}-${lower(var.environment)}")
  resource_group_name         = lookup(var.network_security_rule_stacks[count.index], "resource_group_name", null)
  network_security_group_name = lookup(var.network_security_rule_stacks[count.index], "network_security_group_name", (var.enable_network_security_group ? azurerm_network_security_group.network_security_group[0].name : null))
  protocol                    = lookup(var.network_security_rule_stacks[count.index], "protocol", null)
  access                      = lookup(var.network_security_rule_stacks[count.index], "access", null)
  priority                    = lookup(var.network_security_rule_stacks[count.index], "priority", null)
  direction                   = lookup(var.network_security_rule_stacks[count.index], "direction", null)

  description                                = lookup(var.network_security_rule_stacks[count.index], "description", null)
  source_port_range                          = lookup(var.network_security_rule_stacks[count.index], "source_port_range", null)
  source_port_ranges                         = lookup(var.network_security_rule_stacks[count.index], "source_port_ranges", null)
  destination_port_range                     = lookup(var.network_security_rule_stacks[count.index], "destination_port_range", null)
  destination_port_ranges                    = lookup(var.network_security_rule_stacks[count.index], "destination_port_ranges", null)
  source_address_prefix                      = lookup(var.network_security_rule_stacks[count.index], "source_address_prefix", null)
  source_address_prefixes                    = lookup(var.network_security_rule_stacks[count.index], "source_address_prefixes", null)
  source_application_security_group_ids      = lookup(var.network_security_rule_stacks[count.index], "source_application_security_group_ids", null)
  destination_address_prefix                 = lookup(var.network_security_rule_stacks[count.index], "destination_address_prefix", null)
  destination_address_prefixes               = lookup(var.network_security_rule_stacks[count.index], "destination_address_prefixes", null)
  destination_application_security_group_ids = lookup(var.network_security_rule_stacks[count.index], "destination_application_security_group_ids", null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_security_rule_stacks_timeouts)) > 0 ? [var.network_security_rule_stacks_timeouts] : []

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
    azurerm_network_security_group.network_security_group
  ]
}