#-----------------------------------------------------------
# Azure lb nat rule
#-----------------------------------------------------------
resource "azurerm_lb_nat_rule" "lb_nat_rule" {
  count = var.enable_lb_nat_rule ? 1 : 0

  name                           = var.lb_nat_rule_name != "" ? var.lb_nat_rule_name : "${lower(var.name)}-lb-nat-rule-${lower(var.environment)}"
  resource_group_name            = var.lb_nat_rule_resource_group_name
  loadbalancer_id                = var.lb_nat_rule_loadbalancer_id != "" ? var.lb_nat_rule_loadbalancer_id : (var.enable_lb ? azurerm_lb.lb[count.index].id : null)
  frontend_ip_configuration_name = var.lb_nat_rule_frontend_ip_configuration_name
  protocol                       = var.lb_nat_rule_protocol
  frontend_port                  = var.lb_nat_rule_frontend_port
  backend_port                   = var.lb_nat_rule_backend_port

  idle_timeout_in_minutes = var.lb_nat_rule_idle_timeout_in_minutes
  enable_floating_ip      = var.lb_nat_rule_enable_floating_ip
  enable_tcp_reset        = var.lb_nat_rule_enable_tcp_reset

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lb_nat_rule_timeouts)) > 0 ? [var.lb_nat_rule_timeouts] : []

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