#---------------------------------------------------
# AWS VPC endpoint route table association
#---------------------------------------------------
resource "aws_vpc_endpoint_route_table_association" "vpc_endpoint_route_table_association" {
  count = var.enable_vpc_endpoint_route_table_association && var.vpc_endpoint_vpc_endpoint_type == "Gateway" ? 1 : 0

  route_table_id  = var.vpc_endpoint_route_table_association_route_table_id != "" ? var.vpc_endpoint_route_table_association_route_table_id : element(aws_route_table.private_route_tables.*.id, 0)
  vpc_endpoint_id = var.vpc_endpoint_route_table_association_vpc_endpoint_id != "" ? var.vpc_endpoint_route_table_association_vpc_endpoint_id : (var.enable_vpc_endpoint ? element(aws_vpc_endpoint.vpc_endpoint.*.id, 0) : null)

  // Not working fine...
  // count = var.enable_vpc_endpoint_route_table_association ? 1 : 0

  // route_table_id  = var.vpc_endpoint_route_table_association_route_table_id != "" ? var.vpc_endpoint_route_table_association_route_table_id : element(aws_route_table.private_route_tables.*.id, 0)
  // vpc_endpoint_id = var.vpc_endpoint_route_table_association_vpc_endpoint_id != "" ? var.vpc_endpoint_route_table_association_vpc_endpoint_id : (var.enable_vpc_endpoint ? element(aws_vpc_endpoint.vpc_endpoint.*.id, 0) : null)
  //

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.private_route_tables,
    aws_vpc_endpoint.vpc_endpoint
  ]
}
