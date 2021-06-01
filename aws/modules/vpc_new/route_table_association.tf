#---------------------------------------------------
# AWS Route Table Associations
#---------------------------------------------------

# private
resource "aws_route_table_association" "private_route_table_associations" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_tables.*.id, count.index)

  depends_on = [
    aws_route_table.private_route_tables,
    aws_subnet.private_subnets
  ]
}

# public
resource "aws_route_table_association" "public_route_table_associations" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_route_tables.*.id, count.index)

  depends_on = [
    aws_route_table.public_route_tables,
    aws_subnet.public_subnets
  ]
}
