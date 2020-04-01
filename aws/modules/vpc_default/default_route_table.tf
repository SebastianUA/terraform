#---------------------------------------------------
# AWS default route table
#---------------------------------------------------
# resource "aws_default_route_table" "default_route_table" {
#     count                   = var.enable_default_vpc ? 1 : 0

#     default_route_table_id  = element(concat(aws_default_vpc.default_vpc.*.main_route_table_id, [""]), 0)
#     propagating_vgws        = var.propagating_vgws

#     # route {
#     #     cidr_block                  = element(concat(aws_default_vpc.default_vpc.*.cidr_block, [""]), 0)
#     #     ipv6_cidr_block             = null
#     #     egress_only_gateway_id      = null
#     #     gateway_id                  = null
#     #     instance_id                 = null
#     #     nat_gateway_id              = null
#     #     network_interface_id        = null
#     #     transit_gateway_id          = null
#     #     vpc_peering_connection_id   = null
#     # }

#     tags                    = merge(
#         {
#             "Name"  = "" #var.default_route_table_name != "" ? lower(var.default_route_table_name) : "default table"
#         },
#         var.tags
#     )

#     lifecycle {
#         create_before_destroy   = true
#         ignore_changes          = []
#     }

#     depends_on              = [
#         aws_default_vpc.default_vpc
#     ]
# }
