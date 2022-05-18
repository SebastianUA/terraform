#-----------------------------------------------------------
# Azure lb backend address pool address
#-----------------------------------------------------------
resource "azurerm_lb_backend_address_pool_address" "lb_backend_address_pool_address" {
  count = var.enable_lb_backend_address_pool_address ? 1 : 0

  name                    = var.lb_backend_address_pool_address_name != "" ? var.lb_backend_address_pool_address_name : "${lower(var.name)}-lb-backend-address-pool-address-${lower(var.environment)}"
  backend_address_pool_id = var.lb_backend_address_pool_address_backend_address_pool_id != "" ? var.lb_backend_address_pool_address_backend_address_pool_id : (var.enable_lb_backend_address_pool ? azurerm_lb_backend_address_pool.lb_backend_address_pool[count.index].id : null)
  virtual_network_id      = var.lb_backend_address_pool_address_virtual_network_id
  ip_address              = var.lb_backend_address_pool_address_ip_address

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lb_backend_address_pool_address_timeouts)) > 0 ? [var.lb_backend_address_pool_address_timeouts] : []

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
    azurerm_lb_backend_address_pool.lb_backend_address_pool
  ]
}