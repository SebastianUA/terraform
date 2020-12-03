#---------------------------------------------------
# AWS EC2 transit gateway route table propagation
#---------------------------------------------------
resource "aws_ec2_transit_gateway_route_table_propagation" "transit_gateway_route_table_propagation" {
  count = var.enable_transit_gateway_route_table_propagation ? 1 : 0

  transit_gateway_attachment_id  = var.transit_gateway_route_table_propagation_transit_gateway_attachment_id != "" ? var.transit_gateway_route_table_propagation_transit_gateway_attachment_id : (var.enable_transit_gateway_vpc_attachment ? aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment[0].id : null)
  transit_gateway_route_table_id = var.transit_gateway_route_table_propagation_transit_gateway_route_table_id != "" ? var.transit_gateway_route_table_propagation_transit_gateway_route_table_id : (var.enable_transit_gateway_route_table ? element(aws_ec2_transit_gateway_route_table.transit_gateway_route_table.*.id, count.index) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment,
    aws_ec2_transit_gateway_route_table.transit_gateway_route_table
  ]
}