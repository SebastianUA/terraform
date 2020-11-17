#---------------------------------------------------
# AWS egress only internet gateway
#---------------------------------------------------
resource "aws_egress_only_internet_gateway" "egress_only_internet_gateway" {
  count = var.enable_egress_only_internet_gateway ? 1 : 0

  vpc_id = var.vpc_id != "" && ! var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}
