#---------------------------------------------------
# AWS VPC endpoint subnet association
#---------------------------------------------------
resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  count = var.enable_vpc_endpoint_subnet_association ? length(var.private_subnet_cidrs) : 0
  # count = var.enable_vpc_endpoint && var.vpc_endpoint_vpc_endpoint_type != "Gateway" ? length(var.private_subnet_cidrs) : 0

  vpc_endpoint_id = var.vpc_endpoint_subnet_association_vpc_endpoint_id != "" ? var.vpc_endpoint_subnet_association_vpc_endpoint_id : (var.enable_vpc_endpoint ? element(aws_vpc_endpoint.vpc_endpoint.*.id, 0) : null)
  subnet_id       = var.vpc_endpoint_subnet_association_subnet_id != "" ? var.vpc_endpoint_subnet_association_subnet_id : element(aws_subnet.private_subnets.*.id, count.index)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = var.vpc_endpoint_subnet_association_timeouts

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
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
