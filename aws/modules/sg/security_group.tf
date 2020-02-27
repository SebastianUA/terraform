#---------------------------------------------------
# Create security group
#---------------------------------------------------
resource "aws_security_group" "security_group" {
    count                   = var.enable_security_group ? 1 : 0

    name                    = var.security_group_name != "" && var.security_group_name_prefix == "" ? lower(var.security_group_name) : null
    name_prefix             = var.security_group_name_prefix != "" && var.security_group_name == "" ? lower(var.security_group_name_prefix) : null

    description             = var.security_group_description
    vpc_id                  = var.security_group_vpc_id
    revoke_rules_on_delete  = var.security_group_revoke_rules_on_delete

    dynamic "ingress" {
        for_each    = var.security_group_ingress
        content {
            cidr_blocks         = lookup(security_group_ingress.value, "cidr_blocks", null)
            ipv6_cidr_blocks    = lookup(security_group_ingress.value, "ipv6_cidr_blocks", null)
            prefix_list_ids     = lookup(security_group_ingress.value, "prefix_list_ids", null)
            from_port           = lookup(security_group_ingress.value, "from_port", null)
            to_port             = lookup(security_group_ingress.value, "to_port", null)
            protocol            = lookup(security_group_ingress.value, "protocol", null)
            description         = lookup(security_group_ingress.value, "description", null)
            security_groups     = lookup(security_group_ingress.value, "security_groups", null)
            self                = lookup(security_group_ingress.value, "self", null)
        }
    }

    dynamic "egress" {
        for_each    = var.security_group_egress
        content {
            cidr_blocks         = lookup(security_group_egress.value, "cidr_blocks", null)
            ipv6_cidr_blocks    = lookup(security_group_egress.value, "ipv6_cidr_blocks", null)
            prefix_list_ids     = lookup(security_group_egress.value, "prefix_list_ids", null)
            from_port           = lookup(security_group_egress.value, "from_port", null)
            to_port             = lookup(security_group_egress.value, "to_port", null)
            protocol            = lookup(security_group_egress.value, "protocol", null)
            description         = lookup(security_group_egress.value, "description", null)
            security_groups     = lookup(security_group_egress.value, "security_groups", null)
            self                = lookup(security_group_egress.value, "self", null)
        }
    }

    tags                    = merge(
        {
            "Name"          = var.security_group_name != "" && var.security_group_name_prefix == "" ? lower(var.security_group_name) : lower(var.security_group_name_prefix)
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on               = []
}
