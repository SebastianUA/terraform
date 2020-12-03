#---------------------------------------------------
# AWS EC2 transit gateway vpc attachment
#---------------------------------------------------
resource "aws_ec2_transit_gateway_vpc_attachment" "transit_gateway_vpc_attachment" {
  count = var.enable_transit_gateway_vpc_attachment ? 1 : 0

  subnet_ids         = var.transit_gateway_vpc_attachment_subnet_ids
  transit_gateway_id = var.transit_gateway_vpc_attachment_transit_gateway_id != "" ? var.transit_gateway_vpc_attachment_transit_gateway_id : (var.enable_transit_gateway ? aws_ec2_transit_gateway.transit_gateway[0].id : null)
  vpc_id             = var.transit_gateway_vpc_attachment_vpc_id

  appliance_mode_support                          = var.transit_gateway_vpc_attachment_appliance_mode_support
  dns_support                                     = var.transit_gateway_vpc_attachment_dns_support
  ipv6_support                                    = var.transit_gateway_vpc_attachment_ipv6_support
  transit_gateway_default_route_table_association = var.transit_gateway_vpc_attachment_transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_vpc_attachment_transit_gateway_default_route_table_propagation

  tags = merge(
    {
      Name = var.transit_gateway_vpc_attachment_name != "" ? lower(var.transit_gateway_vpc_attachment_name) : "${lower(var.name)}-tgw-vpc-attachment-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ec2_transit_gateway.transit_gateway
  ]

}