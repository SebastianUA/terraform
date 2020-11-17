#---------------------------------------------------------------
# Create AWS VPN gateway attachment
#---------------------------------------------------------------
resource "aws_vpn_gateway_attachment" "vpn_gateway_attachment" {
  count = var.enable_vpn_gateway ? 1 : 0

  vpc_id         = var.vpc_id != "" && ! var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
  vpn_gateway_id = var.vpn_gw_attachment_vpn_gateway_id != "" && ! var.enable_vpc ? var.vpn_gw_attachment_vpn_gateway_id : element(concat(aws_vpn_gateway.vpn_gw.*.id, [""]), 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc,
    aws_vpn_gateway.vpn_gw
  ]
}
