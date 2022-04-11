#---------------------------------------------------
# AWS VPC peering connection options
#---------------------------------------------------
resource "aws_vpc_peering_connection_options" "vpc_peering_connection_options" {
  count = var.enable_vpc_peering_connection_options ? 1 : 0

  vpc_peering_connection_id = var.vpc_peering_connection_options_vpc_peering_connection_id != "" ? var.vpc_peering_connection_options_vpc_peering_connection_id : (var.enable_vpc_peering_connection ? element(aws_vpc_peering_connection.vpc_peering_connection.*.id, count.index) : null)

  dynamic "accepter" {
    iterator = accepter
    for_each = length(keys(var.vpc_peering_connection_options_accepter)) > 0 ? [var.vpc_peering_connection_options_accepter] : []

    content {
      allow_remote_vpc_dns_resolution  = lookup(accepter.value, "allow_remote_vpc_dns_resolution", null)
      allow_classic_link_to_remote_vpc = lookup(accepter.value, "allow_classic_link_to_remote_vpc", null)
      allow_vpc_to_remote_classic_link = lookup(accepter.value, "allow_vpc_to_remote_classic_link", null)
    }
  }

  dynamic "requester" {
    iterator = requester
    for_each = length(keys(var.vpc_peering_connection_options_requester)) > 0 ? [var.vpc_peering_connection_options_requester] : []

    content {
      allow_remote_vpc_dns_resolution  = lookup(requester.value, "allow_remote_vpc_dns_resolution", null)
      allow_classic_link_to_remote_vpc = lookup(requester.value, "allow_classic_link_to_remote_vpc", null)
      allow_vpc_to_remote_classic_link = lookup(requester.value, "allow_vpc_to_remote_classic_link", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      id,
      accepter,
      requester
    ]
  }

  depends_on = [
    aws_vpc_peering_connection.vpc_peering_connection
  ]
}
