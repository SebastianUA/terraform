#---------------------------------------------------
# AWS VPC peering connection
#---------------------------------------------------
resource "aws_vpc_peering_connection" "vpc_peering_connection" {
  count = var.enable_vpc_peering_connection ? 1 : 0

  vpc_id      = var.vpc_peering_connection_vpc_id != "" ? var.vpc_peering_connection_vpc_id : (var.enable_vpc ? element(aws_vpc.vpc.*.id, count.index) : null)
  peer_vpc_id = var.vpc_peering_connection_peer_vpc_id

  peer_owner_id = var.vpc_peering_connection_peer_owner_id
  auto_accept   = var.vpc_peering_connection_auto_accept
  peer_region   = var.vpc_peering_connection_peer_region

  dynamic "accepter" {
    iterator = accepter
    for_each = var.vpc_peering_connection_accepter

    content {
      allow_remote_vpc_dns_resolution  = lookup(accepter.value, "allow_remote_vpc_dns_resolution", null)
      allow_classic_link_to_remote_vpc = lookup(accepter.value, "allow_classic_link_to_remote_vpc", null)
      allow_vpc_to_remote_classic_link = lookup(accepter.value, "allow_vpc_to_remote_classic_link", null)
    }
  }

  dynamic "requester" {
    iterator = requester
    for_each = var.vpc_peering_connection_requester

    content {
      allow_remote_vpc_dns_resolution  = lookup(requester.value, "allow_remote_vpc_dns_resolution", null)
      allow_classic_link_to_remote_vpc = lookup(requester.value, "allow_classic_link_to_remote_vpc", null)
      allow_vpc_to_remote_classic_link = lookup(requester.value, "allow_vpc_to_remote_classic_link", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.vpc_peering_connection_timeouts)) > 0 ? [var.vpc_peering_connection_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.vpc_peering_connection_name != "" ? lower(var.vpc_peering_connection_name) : "${lower(var.name)}-vpc-peer-con-${lower(var.environment)}"
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
