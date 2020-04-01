#---------------------------------------------------
# AWS VPC network acl rule
#---------------------------------------------------
resource "aws_network_acl_rule" "network_acl_rule" {
    count               = var.enable_network_acl_rule ? 1 : 0

    network_acl_id		= var.network_acl_rule_network_acl_id ? var.network_acl_rule_network_acl_id : element(concat(aws_network_acl.network_acl.*.id, [""]), 0)
    rule_number 		= var.network_acl_rule_rule_number
    protocol 			= var.network_acl_rule_protocol
    rule_action 		= var.network_acl_rule_rule_action

    egress 				= var.network_acl_rule_egress
    cidr_block 			= var.network_acl_rule_cidr_block ? var.network_acl_rule_cidr_block : element(concat(aws_vpc.vpc.*.cidr_block, [""]), 0)
    ipv6_cidr_block 	= var.network_acl_rule_ipv6_cidr_block
    from_port 			= var.network_acl_rule_from_port
    to_port 			= var.network_acl_rule_to_port
    icmp_type 			= var.network_acl_rule_icmp_type
    icmp_code 			= var.network_acl_rule_icmp_code

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_vpc.vpc,
        aws_network_acl.network_acl
    ]
}
