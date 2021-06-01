#---------------------------------------------------------------
# AWS VPN gateway attachment
#---------------------------------------------------------------
resource "aws_vpn_gateway_attachment" "vpn_gateway_attachment" {
  count = var.enable_vpn_gateway_attachment ? 1 : 0

  vpc_id         = var.vpn_gateway_attachment_vpc_id
  vpn_gateway_id = var.vpn_gateway_attachment_vpn_gateway_id != "" ? var.vpn_gateway_attachment_vpn_gateway_id : (var.enable_vpn_gateway ? element(aws_vpn_gateway.vpn_gateway.*.id, 0) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpn_gateway.vpn_gateway
  ]
}
