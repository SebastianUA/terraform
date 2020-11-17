#---------------------------------------------------
# AWS VPC endpoint subnet association
#---------------------------------------------------
resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  count = var.enable_vpc_endpoint && var.vpc_endpoint_vpc_endpoint_type != "Gateway" ? length(var.private_subnet_cidrs) : 0

  vpc_endpoint_id = var.vpc_endpoint_id != "" && ! var.enable_vpc_endpoint ? var.vpc_endpoint_id : element(concat(aws_vpc_endpoint.vpc_endpoint.*.id, [""]), 0)
  subnet_id       = var.vpc_endpoint_subnet_association_subnet_id != "" ? var.vpc_endpoint_subnet_association_subnet_id : element(aws_subnet.private_subnets.*.id, count.index)

  timeouts {
    create = var.vpc_endpoint_subnet_association_timeouts_create
    delete = var.vpc_endpoint_subnet_association_timeouts_delete
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc_endpoint.vpc_endpoint,
    aws_subnet.private_subnets
  ]
}
