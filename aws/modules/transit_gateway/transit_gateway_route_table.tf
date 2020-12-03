#---------------------------------------------------
# AWS EC2 transit gateway route table
#---------------------------------------------------
resource "aws_ec2_transit_gateway_route_table" "transit_gateway_route_table" {
  count = var.enable_transit_gateway_route_table ? 1 : 0

  transit_gateway_id = var.transit_gateway_route_table_transit_gateway_id != "" ? var.transit_gateway_route_table_transit_gateway_id : (var.enable_transit_gateway ? aws_ec2_transit_gateway.transit_gateway[0].id : null)

  tags = merge(
    {
      Name = var.transit_gateway_route_table_name != "" ? lower(var.transit_gateway_route_table_name) : "${lower(var.name)}-tgw-route-table-${lower(var.environment)}"
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