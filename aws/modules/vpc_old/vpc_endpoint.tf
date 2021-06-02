#---------------------------------------------------
# AWS VPC endpoint
#---------------------------------------------------
resource "aws_vpc_endpoint" "vpc_endpoint" {
  count = var.enable_vpc_endpoint ? 1 : 0

  vpc_id       = var.vpc_endpoint_vpc_id != "" ? var.vpc_endpoint_vpc_id : (var.enable_vpc ? aws_vpc.vpc.0.id : null)
  service_name = var.vpc_endpoint_service_name

  vpc_endpoint_type   = var.vpc_endpoint_vpc_endpoint_type
  auto_accept         = var.vpc_endpoint_auto_accept
  policy              = var.vpc_endpoint_policy
  route_table_ids     = var.vpc_endpoint_route_table_ids
  subnet_ids          = var.vpc_endpoint_vpc_endpoint_type == "Interface" ? coalescelist(var.vpc_endpoint_subnet_ids, aws_subnet.private_subnets.*.id) : null
  security_group_ids  = var.vpc_endpoint_security_group_ids == "Interface" ? var.vpc_endpoint_security_group_ids : null
  private_dns_enabled = var.vpc_endpoint_private_dns_enabled == "Interface" ? var.vpc_endpoint_private_dns_enabled : null

  dynamic "timeouts" {
    iterator = timeouts
    for_each = var.vpc_endpoint_timeouts

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.vpc_endpoint_name != "" ? lower(var.vpc_endpoint_name) : "${lower(var.name)}-vpc-endpoint-${lower(var.environment)}"
    },
    var.tags
  )

  // Not working fine...
  // count = var.enable_vpc_endpoint ? length(var.vpc_endpoint_stack) : 0

  // vpc_id       = lookup(var.vpc_endpoint_stack[count.index], "vpc_id", (var.enable_vpc ? aws_vpc.vpc.0.id : null))
  // service_name = lookup(var.vpc_endpoint_stack[count.index], "service_name", null)

  // vpc_endpoint_type   = lookup(var.vpc_endpoint_stack[count.index], "vpc_endpoint_type", null)
  // auto_accept         = lookup(var.vpc_endpoint_stack[count.index], "auto_accept", null)
  // policy              = lookup(var.vpc_endpoint_stack[count.index], "policy", null)
  // route_table_ids     = lookup(var.vpc_endpoint_stack[count.index], "route_table_ids", null)
  // subnet_ids          = lookup(var.vpc_endpoint_stack[count.index], "subnet_ids", (length(var.private_subnet_cidrs) > 0 ? coalescelist(var.vpc_endpoint_subnet_ids, aws_subnet.private_subnets.*.id) : null))
  // security_group_ids  = lookup(var.vpc_endpoint_stack[count.index], "security_group_ids", null)
  // private_dns_enabled = lookup(var.vpc_endpoint_stack[count.index], "private_dns_enabled", null)

  // dynamic "timeouts" {
  //   iterator = timeouts
  //   for_each = var.vpc_endpoint_timeouts

  //   content {
  //     create = lookup(timeouts.value, "create", null)
  //     update = lookup(timeouts.value, "update", null)
  //     delete = lookup(timeouts.value, "delete", null)
  //   }
  // }

  // tags = merge(
  //   {
  //     Name = lookup(var.vpc_endpoint_stack[count.index], "name", "${lower(var.name)}-vpc-endpoint-${count.index}-${lower(var.environment)}")
  //   },
  //   var.tags
  // )
  //

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}
