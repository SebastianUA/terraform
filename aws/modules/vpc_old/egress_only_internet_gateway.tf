#---------------------------------------------------
# AWS egress only internet gateway
#---------------------------------------------------
resource "aws_egress_only_internet_gateway" "egress_only_internet_gateway" {
  count = var.enable_egress_only_internet_gateway ? 1 : 0

  vpc_id = var.egress_only_internet_gateway_vpc_id != "" ? var.egress_only_internet_gateway_vpc_id : (var.enable_vpc ? element(aws_vpc.vpc.*.id, 0) : null)

  tags = merge(
    {
      Name = var.egress_only_internet_gateway_name != "" ? lower(var.egress_only_internet_gateway_name) : "${lower(var.name)}-egress-only-igw-${lower(var.environment)}"
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
