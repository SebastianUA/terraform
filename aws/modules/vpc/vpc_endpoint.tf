#---------------------------------------------------
# AWS VPC endpoint
#---------------------------------------------------
resource "aws_vpc_endpoint" "vpc_endpoint" {
  count = var.enable_vpc_endpoint ? 1 : 0

  vpc_id       = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
  service_name = var.vpc_endpoint_service_name

  auto_accept         = var.vpc_endpoint_auto_accept
  policy              = var.vpc_endpoint_policy
  private_dns_enabled = var.vpc_endpoint_private_dns_enabled
  route_table_ids     = var.vpc_endpoint_route_table_ids
  subnet_ids          = var.vpc_endpoint_subnet_ids
  security_group_ids  = var.vpc_endpoint_security_group_ids
  vpc_endpoint_type   = var.vpc_endpoint_vpc_endpoint_type

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

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}
