#---------------------------------------------------
# AWS VPN connection route
#---------------------------------------------------
resource "aws_vpn_connection_route" "vpn_connection_route" {
    count                   = var.enable_vpn_gateway ? 1 : 0

    destination_cidr_block = var.vpn_connection_route_cidr_block
    vpn_connection_id      = var.vpn_connection_route_vpn_connection_id !="" && !var.enable_vpn_gateway ? var.vpn_connection_route_vpn_connection_id : element(concat(aws_vpn_connection.vpn_connection.*.id, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_vpn_connection.vpn_connection
    ]
}
