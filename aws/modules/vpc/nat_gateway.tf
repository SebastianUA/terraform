#---------------------------------------------------
# AWS NAT GW
#---------------------------------------------------
resource "aws_nat_gateway" "nat_gateway" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : (length(var.azs) > 0 ? length(var.azs) : length(lookup(var.availability_zones, var.region)))) : 0

  subnet_id = element(aws_subnet.public_subnets.*.id, (var.single_nat_gateway ? 0 : count.index))

  allocation_id     = element(aws_eip.nat_eip.*.id, (var.single_nat_gateway ? 0 : count.index))
  connectivity_type = var.nat_gateway_connectivity_type

  tags = merge(
    {
      Name = var.nat_gateway_name != "" ? lower(var.nat_gateway_name) : "${lower(var.name)}-nat-gw-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_eip.nat_eip,
    aws_subnet.public_subnets
  ]
}
