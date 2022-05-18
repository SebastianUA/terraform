#---------------------------------------------------
# AWS VPC endpoint
#---------------------------------------------------
resource "aws_vpc_endpoint" "vpc_endpoint" {
  count = var.enable_vpc_endpoint ? length(var.vpc_endpoint_stack) : 0

  vpc_id       = lookup(var.vpc_endpoint_stack[count.index], "vpc_id", (var.enable_vpc ? aws_vpc.vpc.0.id : null))
  service_name = lookup(var.vpc_endpoint_stack[count.index], "service_name", null)

  vpc_endpoint_type = lookup(var.vpc_endpoint_stack[count.index], "vpc_endpoint_type", null)
  auto_accept       = lookup(var.vpc_endpoint_stack[count.index], "auto_accept", null)
  policy            = lookup(var.vpc_endpoint_stack[count.index], "policy", null)
  route_table_ids   = lookup(var.vpc_endpoint_stack[count.index], "route_table_ids", null)

  # If vpc_endpoint_type == "Interface"
  subnet_ids          = lookup(var.vpc_endpoint_stack[count.index], "subnet_ids", coalescelist(var.vpc_endpoint_subnet_ids, aws_subnet.private_subnets.*.id))
  security_group_ids  = lookup(var.vpc_endpoint_stack[count.index], "security_group_ids", null)
  private_dns_enabled = lookup(var.vpc_endpoint_stack[count.index], "private_dns_enabled", null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.vpc_endpoint_timeouts)) > 0 ? [var.vpc_endpoint_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = lookup(var.vpc_endpoint_stack[count.index], "name", "${lower(var.name)}-vpc-endpoint-${count.index}-${lower(var.environment)}")
    },
    var.tags
  )



  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_subnet.private_subnets
  ]
}
