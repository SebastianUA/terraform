#---------------------------------------------------
# AWS EC2 transit gateway
#---------------------------------------------------
resource "aws_ec2_transit_gateway" "transit_gateway" {
  count = var.enable_transit_gateway ? 1 : 0

  amazon_side_asn                 = var.transit_gateway_amazon_side_asn
  auto_accept_shared_attachments  = var.transit_gateway_auto_accept_shared_attachments
  default_route_table_association = var.transit_gateway_default_route_table_association
  default_route_table_propagation = var.transit_gateway_default_route_table_propagation
  description                     = var.transit_gateway_description
  dns_support                     = var.transit_gateway_dns_support
  vpn_ecmp_support                = var.transit_gateway_vpn_ecmp_support

  tags = merge(
    {
      Name = var.transit_gateway_name != "" ? lower(var.transit_gateway_name) : "${lower(var.name)}-tgw-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}