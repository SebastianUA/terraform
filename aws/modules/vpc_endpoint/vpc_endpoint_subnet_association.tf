#---------------------------------------------------
# AWS VPC endpoint subnet association
#---------------------------------------------------
resource "aws_vpc_endpoint_subnet_association" "vpc_endpoint_subnet_association" {
  for_each = var.enable_vpc_endpoint_subnet_association ? local.vpc_endpoint_stack_gtw : []

  vpc_endpoint_id = var.vpc_endpoint_subnet_association_vpc_endpoint_id != null ? var.vpc_endpoint_subnet_association_vpc_endpoint_id : (var.enable_vpc_endpoint ? element(aws_vpc_endpoint.vpc_endpoint.*.id, each.key) : null)
  subnet_id       = var.vpc_endpoint_subnet_association_subnet_id


  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.vpc_endpoint_subnet_association_timeouts)) > 0 ? [var.vpc_endpoint_subnet_association_timeouts] : []

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
    aws_vpc_endpoint.vpc_endpoint
  ]
}
