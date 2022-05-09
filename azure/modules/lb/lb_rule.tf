#-----------------------------------------------------------
# Azure lb rule
#-----------------------------------------------------------
resource "azurerm_lb_rule" "lb_rule" {
  count = var.enabne_lb_rule ? 1 : 0

  name                           = var.lb_rule_name != "" ? var.lb_rule_name : "${lower(var.name)}-lb-rule-${lower(var.environment)}"
  loadbalancer_id                = var.lb_rule_loadbalancer_id != "" ? var.lb_rule_loadbalancer_id : (var.enable_lb ? azurerm_lb.lb[count.index].id : null)
  frontend_ip_configuration_name = var.lb_rule_frontend_ip_configuration_name
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.lb_rule_frontend_port
  backend_port                   = var.lb_rule_backend_port

  backend_address_pool_ids = var.lb_rule_backend_address_pool_ids
  probe_id                 = var.lb_rule_probe_id
  enable_floating_ip       = var.lb_rule_enable_floating_ip
  idle_timeout_in_minutes  = var.lb_rule_idle_timeout_in_minutes
  load_distribution        = var.lb_rule_load_distribution
  disable_outbound_snat    = var.lb_rule_disable_outbound_snat
  enable_tcp_reset         = var.lb_rule_enable_tcp_reset

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lb_rule_timeouts)) > 0 ? [var.lb_rule_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.lb_rule_name != "" ? var.lb_rule_name : "${lower(var.name)}-lb-rule-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_lb.lb
  ]
}