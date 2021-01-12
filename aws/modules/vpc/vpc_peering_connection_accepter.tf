#---------------------------------------------------
# AWS VPC peering connection accepter
#---------------------------------------------------
resource "aws_vpc_peering_connection_accepter" "vpc_peering_connection_accepter" {
  count = var.enable_vpc_peering ? 1 : 0

  vpc_peering_connection_id = var.vpc_peering_connection_id != "" ? var.vpc_peering_connection_id : element(concat(aws_vpc_peering_connection.vpc_peering_connection.*.id, [""]), 0)
  auto_accept               = var.vpc_peering_connection_accepter_auto_accept

  tags = merge(
    {
      Name = var.vpc_peering_connection_accepter_name != "" ? lower(var.vpc_peering_connection_accepter_name) : "${lower(var.name)}-vpc-peer-accepter-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc_peering_connection.vpc_peering_connection
  ]
}
