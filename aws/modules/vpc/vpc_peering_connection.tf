#---------------------------------------------------
# AWS VPC peering connection
#---------------------------------------------------
resource "aws_vpc_peering_connection" "vpc_peering_connection" {
  count = var.enable_vpc_peering ? 1 : 0

  vpc_id      = var.vpc_id != "" && ! var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
  peer_vpc_id = var.vpc_peering_connection_peer_vpc_id

  peer_owner_id = var.vpc_peering_connection_peer_owner_id
  auto_accept   = var.vpc_peering_connection_auto_accept
  peer_region   = var.vpc_peering_connection_peer_region

  accepter {
    allow_remote_vpc_dns_resolution  = var.accepter_allow_remote_vpc_dns_resolution
    allow_classic_link_to_remote_vpc = var.accepter_allow_classic_link_to_remote_vpc
    allow_vpc_to_remote_classic_link = var.accepter_allow_vpc_to_remote_classic_link
  }

  requester {
    allow_remote_vpc_dns_resolution  = var.requester_allow_remote_vpc_dns_resolution
    allow_classic_link_to_remote_vpc = var.requester_allow_classic_link_to_remote_vpc
    allow_vpc_to_remote_classic_link = var.requester_allow_vpc_to_remote_classic_link
  }

  timeouts {
    create = var.vpc_peering_connection_timeouts_create
    update = var.vpc_peering_connection_timeouts_update
    delete = var.vpc_peering_connection_timeouts_delete
  }

  tags = merge(
    {
      "Name" = var.vpc_peering_connection_name != "" ? lower(var.vpc_peering_connection_name) : "${lower(var.name)}-vpc-peer-con-${lower(var.environment)}"
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
