#---------------------------------------------------
# AWS VPN connection
#---------------------------------------------------
resource "aws_vpn_connection" "vpn_connection" {
  count = var.enable_vpn_gateway ? 1 : 0

  customer_gateway_id = var.vpn_connection_customer_gateway_id != "" && ! var.enable_vpn_gateway ? var.vpn_connection_customer_gateway_id : element(concat(aws_customer_gateway.customer_gateway.*.id, [""]), 0)
  type                = var.vpn_connection_type

  transit_gateway_id = var.vpn_connection_transit_gateway_id
  vpn_gateway_id     = var.vpn_connection_vpn_gateway_id != null && ! var.enable_vpn_gateway ? var.vpn_connection_vpn_gateway_id : element(concat(aws_vpn_gateway.vpn_gw.*.id, [""]), 0)
  static_routes_only = var.vpn_connection_static_routes_only

  tunnel1_inside_cidr   = var.vpn_connection_tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.vpn_connection_tunnel2_inside_cidr
  tunnel1_preshared_key = var.vpn_connection_tunnel1_preshared_key
  tunnel2_preshared_key = var.vpn_connection_tunnel2_preshared_key

  tags = merge(
    {
      Name = var.vpn_connection_name != "" ? lower(var.vpn_connection_name) : "${lower(var.name)}-vpn-connection-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_customer_gateway.customer_gateway,
    aws_vpn_gateway.vpn_gw
  ]
}
