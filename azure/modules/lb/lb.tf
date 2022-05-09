#-----------------------------------------------------------
# Azure lb
#-----------------------------------------------------------
resource "azurerm_lb" "lb" {
  count = var.enable_lb ? 1 : 0

  name                = var.lb_name != "" ? var.lb_name : "${lower(var.name)}-lb-${lower(var.environment)}"
  resource_group_name = var.lb_resource_group_name
  location            = var.lb_location

  edge_zone = var.lb_edge_zone
  sku       = var.lb_sku
  sku_tier  = var.lb_sku_tier

  dynamic "frontend_ip_configuration" {
    iterator = frontend_ip_configuration
    for_each = var.lb_frontend_ip_configuration

    content {
      name = lookup(frontend_ip_configuration.value, "name", null)

      zones                                              = lookup(frontend_ip_configuration.value, "zones", null)
      subnet_id                                          = lookup(frontend_ip_configuration.value, "subnet_id", null)
      gateway_load_balancer_frontend_ip_configuration_id = lookup(frontend_ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      private_ip_address                                 = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      private_ip_address_allocation                      = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", null)
      private_ip_address_version                         = lookup(frontend_ip_configuration.value, "private_ip_address_version", null)
      public_ip_address_id                               = lookup(frontend_ip_configuration.value, "public_ip_address_id", null)
      public_ip_prefix_id                                = lookup(frontend_ip_configuration.value, "public_ip_address_id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lb_timeouts)) > 0 ? [var.lb_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.lb_name != "" ? var.lb_name : "${lower(var.name)}-lb-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}