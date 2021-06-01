#---------------------------------------------------
# AWS VPC endpoint service
#---------------------------------------------------
resource "aws_vpc_endpoint_service" "vpc_endpoint_service" {
  count = var.enable_vpc_endpoint_service ? length(var.vpc_endpoint_service_stack) : 0

  acceptance_required = lookup(var.vpc_endpoint_service_stack[count.index], "acceptance_required", false)

  gateway_load_balancer_arns = lookup(var.vpc_endpoint_service_stack[count.index], "gateway_load_balancer_arns", null)
  network_load_balancer_arns = lookup(var.vpc_endpoint_service_stack[count.index], "network_load_balancer_arns", null)
  allowed_principals         = lookup(var.vpc_endpoint_service_stack[count.index], "allowed_principals", null)
  private_dns_name           = lookup(var.vpc_endpoint_service_stack[count.index], "private_dns_name", null)

  tags = merge(
    {
      Name = lookup(var.vpc_endpoint_service_stack[count.index], "name", "${lower(var.name)}-vpc-endpoint-svc-${count.index}-${lower(var.environment)}")
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
