#---------------------------------------------------------------
# AWS VPN gateway
#---------------------------------------------------------------
resource "aws_vpn_gateway" "vpn_gateway" {
  count = var.enable_vpn_gateway ? 1 : 0

  vpc_id = var.vpn_gateway_vpc_id != "" ? var.vpn_gateway_vpc_id : (var.enable_vpc ? element(aws_vpc.vpc.*.id, count.index) : null)

  availability_zone = var.vpn_gateway_availability_zone
  amazon_side_asn   = var.vpn_gateway_amazon_side_asn

  tags = merge(
    {
      Name = var.vpn_gateway_name != "" ? lower(var.vpn_gateway_name) : "${lower(var.name)}-vpn-gw-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}
