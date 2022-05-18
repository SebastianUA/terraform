#-----------------------------------------------------------
# Azure lb outbound rule
#-----------------------------------------------------------
resource "azurerm_lb_outbound_rule" "lb_outbound_rule" {
  count = var.enable_lb_outbound_rule ? 1 : 0

  name                    = var.lb_outbound_rule_name != "" ? var.lb_outbound_rule_name : "${lower(var.name)}-lb-outbound-rule-${lower(var.environment)}"
  loadbalancer_id         = var.lb_outbound_rule_loadbalancer_id != "" ? var.lb_outbound_rule_loadbalancer_id : (var.enable_lb ? azurerm_lb.lb[count.index].id : null)
  backend_address_pool_id = var.lb_outbound_rule_backend_address_pool_id != "" ? var.lb_outbound_rule_backend_address_pool_id : (var.enable_lb_backend_address_pool ? azurerm_lb_backend_address_pool.lb_backend_address_pool[count.index].id : null)
  protocol                = var.lb_outbound_rule_protocol

  dynamic "frontend_ip_configuration" {
    iterator = frontend_ip_configuration
    for_each = var.lb_outbound_rule_frontend_ip_configuration

    content {
      name = lookup(frontend_ip_configuration.value, "name", null)
    }
  }

  enable_tcp_reset         = var.lb_outbound_rule_enable_tcp_reset
  allocated_outbound_ports = var.lb_outbound_rule_allocated_outbound_ports
  idle_timeout_in_minutes  = var.lb_outbound_rule_idle_timeout_in_minutes

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lb_outbound_rule_timeouts)) > 0 ? [var.lb_outbound_rule_timeouts] : []

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
    azurerm_lb.lb,
    azurerm_lb_backend_address_pool.lb_backend_address_pool
  ]
}