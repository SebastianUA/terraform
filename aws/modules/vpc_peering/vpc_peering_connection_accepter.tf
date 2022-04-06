#---------------------------------------------------
# AWS VPC peering connection accepter
#---------------------------------------------------
resource "aws_vpc_peering_connection_accepter" "vpc_peering_connection_accepter" {
  count = var.enable_vpc_peering_connection_accepter ? 1 : 0

  vpc_peering_connection_id = var.vpc_peering_connection_accepter_vpc_peering_connection_id != "" ? var.vpc_peering_connection_accepter_vpc_peering_connection_id : (var.enable_vpc_peering_connection ? element(aws_vpc_peering_connection.vpc_peering_connection.*.id, count.index) : null)
  auto_accept               = var.vpc_peering_connection_accepter_auto_accept

  tags = merge(
    {
      Name = var.vpc_peering_connection_accepter_name != "" ? lower(var.vpc_peering_connection_accepter_name) : "${lower(var.name)}-vpc-peer-accepter-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    # There is no AWS EC2 API for reading auto_accept
    ignore_changes = [
      auto_accept,
      accept_status,
      id,
      accepter,
      requester
    ]
  }

  depends_on = [
    aws_vpc_peering_connection.vpc_peering_connection
  ]
}
