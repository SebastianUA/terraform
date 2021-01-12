#---------------------------------------------------------------
# AWS customer gateway
#---------------------------------------------------------------
resource "aws_customer_gateway" "customer_gateway" {
  count = var.enable_vpn_gateway ? 1 : 0

  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip_address
  type       = var.customer_gateway_type

  tags = merge(
    {
      Name = var.customer_gateway_name != "" ? lower(var.customer_gateway_name) : "${lower(var.name)}-customer-gw-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
