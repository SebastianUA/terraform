#---------------------------------------------------
# AWS VPC peering connection options
#---------------------------------------------------
resource "aws_vpc_peering_connection_options" "vpc_peering_connection_options" {
    count                       = var.enable_vpc_peering_connection_options ? 1 : 0

    vpc_peering_connection_id   = var.vpc_peering_connection_id != "" ? var.vpc_peering_connection_id : element(concat(aws_vpc_peering_connection.vpc_peering_connection.*.id, [""]), 0)

    accepter {
        allow_remote_vpc_dns_resolution     = var.accepter_options_allow_remote_vpc_dns_resolution
        allow_classic_link_to_remote_vpc    = var.accepter_options_allow_classic_link_to_remote_vpc
        allow_vpc_to_remote_classic_link    = var.accepter_options_allow_vpc_to_remote_classic_link
    }

    requester {
        allow_remote_vpc_dns_resolution     = var.requester_options_allow_remote_vpc_dns_resolution
        allow_classic_link_to_remote_vpc    = var.requester_options_allow_classic_link_to_remote_vpc
        allow_vpc_to_remote_classic_link    = var.requester_options_allow_vpc_to_remote_classic_link
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_vpc_peering_connection.vpc_peering_connection
    ]
}
