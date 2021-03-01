#---------------------------------------------------
# AWS VPC main route table association
#---------------------------------------------------
resource "aws_main_route_table_association" "main_route_table_association" {
  count = var.enable_main_route_table_association ? 1 : 0

  vpc_id         = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
  route_table_id = var.main_route_table_association_route_table_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}
