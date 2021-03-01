#---------------------------------------------------
# AWS globalaccelerator listener
#---------------------------------------------------
resource "aws_globalaccelerator_listener" "globalaccelerator_listener" {
  count = var.enable_globalaccelerator_listener ? 1 : 0

  accelerator_arn = var.globalaccelerator_listener_accelerator_arn != "" && !var.enable_globalaccelerator_accelerator ? var.globalaccelerator_listener_accelerator_arn : element(concat(aws_globalaccelerator_accelerator.globalaccelerator_accelerator.*.id, [""]), 0)

  client_affinity = upper(var.globalaccelerator_listener_client_affinity)
  protocol        = upper(var.globalaccelerator_listener_protocol)

  dynamic "port_range" {
    iterator = port_range
    for_each = var.globalaccelerator_listener_port_range
    content {
      from_port = lookup(port_range.value, "from_port", null)
      to_port   = lookup(port_range.value, "to_port", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_globalaccelerator_accelerator.globalaccelerator_accelerator
  ]
}
