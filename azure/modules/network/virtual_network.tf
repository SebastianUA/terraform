#-----------------------------------------------------------
# Azure virtual network
#-----------------------------------------------------------
resource "azurerm_virtual_network" "virtual_network" {
  count = var.enable_virtual_network ? 1 : 0

  name                = var.virtual_network_name != "" ? var.virtual_network_name : "${lower(var.name)}-virtual-network-${lower(var.environment)}"
  resource_group_name = var.virtual_network_resource_group_name
  location            = var.virtual_network_location
  address_space       = var.virtual_network_address_space

  bgp_community           = var.virtual_network_bgp_community
  dns_servers             = var.virtual_network_dns_servers
  edge_zone               = var.virtual_network_edge_zone
  flow_timeout_in_minutes = var.virtual_network_flow_timeout_in_minutes

  dynamic "subnet" {
    iterator = subnet
    for_each = var.virtual_network_subnet

    content {
      name           = lookup(subnet.value, "name", "${lower(var.name)}-virtual-network-subnet-${lower(var.environment)}-${index(var.virtual_network_subnet, subnet.value) + 1}")
      address_prefix = lookup(subnet.value, "address_prefix", null)

      security_group = lookup(subnet.value, "security_group", (var.enable_network_security_group ? azurerm_network_security_group.network_security_group[0].name : null))
    }
  }

  dynamic "ddos_protection_plan" {
    iterator = ddos_protection_plan
    for_each = length(keys(var.virtual_network_ddos_protection_plan)) > 0 ? [var.virtual_network_ddos_protection_plan] : []

    content {
      id     = lookup(subnet.value, "id", null)
      enable = lookup(subnet.value, "enable", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.virtual_network_timeouts)) > 0 ? [var.virtual_network_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.virtual_network_name != "" ? var.virtual_network_name : "${lower(var.name)}-virtual-network-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_network_security_group.network_security_group
  ]
}