#-----------------------------------------------------------
# Azure network interface
#-----------------------------------------------------------
resource "azurerm_network_interface" "network_interface" {
  count = var.enable_network_interface ? 1 : 0

  name                = var.network_interface_name != "" ? var.network_interface_name : "${lower(var.name)}-network-interface-${lower(var.environment)}"
  location            = var.network_interface_location
  resource_group_name = var.network_interface_resource_group_name

  dns_servers                   = var.network_interface_dns_servers
  edge_zone                     = var.network_interface_edge_zone
  enable_ip_forwarding          = var.network_interface_enable_ip_forwarding
  enable_accelerated_networking = var.network_interface_enable_accelerated_networking
  internal_dns_name_label       = var.network_interface_internal_dns_name_label

  dynamic "ip_configuration" {
    iterator = ip_configuration
    for_each = var.network_interface_ip_configuration

    content {
      name                          = lookup(ip_configuration.value, "name", null)
      private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation", null)

      gateway_load_balancer_frontend_ip_configuration_id = lookup(ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      subnet_id                                          = lookup(ip_configuration.value, "subnet_id", null)
      private_ip_address_version                         = lookup(ip_configuration.value, "private_ip_address_version", null)
      public_ip_address_id                               = lookup(ip_configuration.value, "public_ip_address_id", null)
      primary                                            = lookup(ip_configuration.value, "primary", null)
      private_ip_address                                 = lookup(ip_configuration.value, "private_ip_address", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_interface_timeouts)) > 0 ? [var.network_interface_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.network_interface_name != "" ? var.network_interface_name : "${lower(var.name)}-network-interface-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}