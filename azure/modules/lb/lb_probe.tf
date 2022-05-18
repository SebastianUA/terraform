#-----------------------------------------------------------
# Azure lb probe
#-----------------------------------------------------------
resource "azurerm_lb_probe" "lb_probe" {
  count = var.enable_lb_probe ? 1 : 0

  name            = var.lb_probe_name != "" ? var.lb_probe_name : "${lower(var.name)}-lb-probe-${lower(var.environment)}"
  loadbalancer_id = var.lb_probe_loadbalancer_id != "" ? var.lb_probe_loadbalancer_id : (var.enable_lb ? azurerm_lb.lb[count.index].id : null)
  port            = var.lb_probe_port

  protocol            = var.lb_probe_protocol
  request_path        = var.lb_probe_request_path
  interval_in_seconds = var.lb_probe_interval_in_seconds
  number_of_probes    = var.lb_probe_number_of_probes

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lb_probe_timeouts)) > 0 ? [var.lb_probe_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.lb_probe_name != "" ? var.lb_probe_name : "${lower(var.name)}-lb-probe-${lower(var.environment)}"
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