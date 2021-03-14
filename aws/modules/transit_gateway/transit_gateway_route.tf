#---------------------------------------------------
# AWS EC2 transit gateway route
#---------------------------------------------------
resource "aws_ec2_transit_gateway_route" "transit_gateway_route" {
  count = var.enable_transit_gateway_route ? length(var.transit_gateway_route_destination_cidr_blocks) : 0

  destination_cidr_block         = var.transit_gateway_route_destination_cidr_blocks[count.index]
  transit_gateway_route_table_id = var.transit_gateway_route_transit_gateway_route_table_id != "" ? var.transit_gateway_route_transit_gateway_route_table_id : (var.enable_transit_gateway && var.transit_gateway_default_route_table_association == "enable" ? aws_ec2_transit_gateway.transit_gateway[0].association_default_route_table_id : aws_ec2_transit_gateway_route_table.transit_gateway_route_table[0].id)

  transit_gateway_attachment_id = var.transit_gateway_route_transit_gateway_attachment_id != "" ? var.transit_gateway_route_transit_gateway_attachment_id : (! var.transit_gateway_route_blackhole && var.enable_transit_gateway_vpc_attachment ? aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment[0].id : null)
  blackhole                     = var.transit_gateway_route_blackhole

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ec2_transit_gateway.transit_gateway,
    aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment,
    aws_ec2_transit_gateway_route_table.transit_gateway_route_table
  ]
}