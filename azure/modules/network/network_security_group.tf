#-----------------------------------------------------------
# Azure network security group
#-----------------------------------------------------------
resource "azurerm_network_security_group" "network_security_group" {
  count = var.enable_network_security_group ? 1 : 0

  name                = var.network_security_group_name != "" ? var.network_security_group_name : "${lower(var.name)}-network-sg-${lower(var.environment)}"
  resource_group_name = var.network_security_group_resource_group_name
  location            = var.network_security_group_location

  dynamic "security_rule" {
    iterator = security_rule
    for_each = var.network_security_group_security_rule

    content {
      name      = lookup(security_rule.value, "name", null)
      protocol  = lookup(security_rule.value, "protocol", null)
      access    = lookup(security_rule.value, "access", null)
      priority  = lookup(security_rule.value, "priority", null)
      direction = lookup(security_rule.value, "direction", null)

      description                                = lookup(security_rule.value, "description", null)
      source_port_range                          = lookup(security_rule.value, "source_port_range", null)
      source_port_ranges                         = lookup(security_rule.value, "source_port_ranges", null)
      destination_port_range                     = lookup(security_rule.value, "destination_port_range", null)
      destination_port_ranges                    = lookup(security_rule.value, "destination_port_ranges", null)
      source_address_prefix                      = lookup(security_rule.value, "source_address_prefix", null)
      source_address_prefixes                    = lookup(security_rule.value, "source_address_prefixes", null)
      source_application_security_group_ids      = lookup(security_rule.value, "source_application_security_group_ids", null)
      destination_address_prefix                 = lookup(security_rule.value, "destination_address_prefix", null)
      destination_address_prefixes               = lookup(security_rule.value, "destination_address_prefixes", null)
      destination_application_security_group_ids = lookup(security_rule.value, "destination_application_security_group_ids", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_security_group_timeouts)) > 0 ? [var.network_security_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.network_security_group_name != "" ? var.network_security_group_name : "${lower(var.name)}-network-sg-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}