#---------------------------------------------------
# AWS VPC endpoint route table association
#---------------------------------------------------
resource "aws_vpc_endpoint_route_table_association" "vpc_endpoint_route_table_association" {
  for_each = var.enable_vpc_endpoint_route_table_association ? local.vpc_endpoint_stack_gtw : []

  route_table_id  = var.vpc_endpoint_route_table_association_route_table_id
  vpc_endpoint_id = var.vpc_endpoint_route_table_association_vpc_endpoint_id != null ? var.vpc_endpoint_route_table_association_vpc_endpoint_id : (var.enable_vpc_endpoint ? element(aws_vpc_endpoint.vpc_endpoint.*.id, each.key) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc_endpoint.vpc_endpoint
  ]
}
