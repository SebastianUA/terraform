#---------------------------------------------------------------
# AWS VPN gateway route propagation
#---------------------------------------------------------------
resource "aws_vpn_gateway_route_propagation" "vpn_gateway_route_propagation" {
  count = var.enable_vpn_gateway_route_propagation ? 1 : 0

  vpn_gateway_id = var.vpn_gateway_route_propagation_vpn_gateway_id != "" ? var.vpn_gateway_route_propagation_vpn_gateway_id : (var.enable_vpn_gateway ? element(aws_vpn_gateway.vpn_gateway.*.id, count.index) : null)
  route_table_id = var.vpn_gateway_route_propagation_route_table_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.vpn_gateway_route_propagation_timeouts)) > 0 ? [var.vpn_gateway_route_propagation_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpn_gateway.vpn_gateway
  ]
}
