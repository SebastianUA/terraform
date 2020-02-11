#---------------------------------------------------------------
# Create AWS VPN gateway route propagation
#---------------------------------------------------------------
resource "aws_vpn_gateway_route_propagation" "vpn_gateway_route_propagation" {
    count               = var.enable_vpn_gateway ? 0 : 0

    vpn_gateway_id      = var.vpn_gw_attachment_vpn_gateway_id != "" && !var.enable_vpc ? var.vpn_gw_attachment_vpn_gateway_id : element(concat(aws_vpn_gateway.vpn_gw.*.id, [""]), 0)
    route_table_id      = var.vpn_gateway_route_propagation_route_table_id

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_vpn_gateway.vpn_gw
    ]
}