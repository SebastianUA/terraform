#-----------------------------------------------------------
# Azure lb nat pool
#-----------------------------------------------------------
resource "azurerm_lb_nat_pool" "lb_nat_pool" {
  count = var.enable_lb_nat_pool ? 1 : 0

  name                           = var.lb_nat_pool_name != "" ? var.lb_nat_pool_name : "${lower(var.name)}-lb-nat-pool-${lower(var.environment)}"
  resource_group_name            = var.lb_nat_pool_resource_group_name
  loadbalancer_id                = var.lb_nat_pool_loadbalancer_id != "" ? var.lb_nat_pool_loadbalancer_id : (var.enable_lb ? azurerm_lb.lb[count.index].id : null)
  frontend_ip_configuration_name = var.lb_nat_pool_frontend_ip_configuration_name
  protocol                       = var.lb_nat_pool_protocol
  frontend_port_start            = var.lb_nat_pool_frontend_port_start
  frontend_port_end              = var.lb_nat_pool_frontend_port_end
  backend_port                   = var.lb_nat_pool_backend_port

  idle_timeout_in_minutes = var.lb_nat_pool_idle_timeout_in_minutes
  floating_ip_enabled     = var.lb_nat_pool_floating_ip_enabled
  tcp_reset_enabled       = var.lb_nat_pool_tcp_reset_enabled

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lb_nat_pool_timeouts)) > 0 ? [var.lb_nat_pool_timeouts] : []

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
    azurerm_lb.lb
  ]
}