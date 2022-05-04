#-----------------------------------------------------------
# Azure private dns zone virtual network link
#-----------------------------------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  count = var.enable_private_dns_zone_virtual_network_link ? 1 : 0

  name                  = var.private_dns_zone_virtual_network_link_name != "" ? var.private_dns_zone_virtual_network_link_name : "${lower(var.name)}-private-dns-zone-virtual-network-link-${lower(var.environment)}"
  resource_group_name   = var.private_dns_zone_virtual_network_link_resource_group_name
  private_dns_zone_name = var.private_dns_zone_virtual_network_link_private_dns_zone_name != "" ? var.private_dns_zone_virtual_network_link_private_dns_zone_name : (var.enable_private_dns_zone ? azurerm_private_dns_zone.private_dns_zone[count.index].name : null)
  virtual_network_id    = var.private_dns_zone_virtual_network_link_virtual_network_id

  registration_enabled = var.private_dns_zone_virtual_network_link_registration_enabled

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.private_dns_zone_virtual_network_link_timeouts)) > 0 ? [var.private_dns_zone_virtual_network_link_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.private_dns_zone_virtual_network_link_name != "" ? var.private_dns_zone_virtual_network_link_name : "${lower(var.name)}-private-dns-zone-virtual-network-link-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_private_dns_zone.private_dns_zone
  ]
}