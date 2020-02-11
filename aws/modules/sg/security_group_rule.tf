#---------------------------------------------------
# Add security group rules 
#---------------------------------------------------
resource "aws_security_group_rule" "ingress_ports" {
    count                       = var.enable_sg_rule_ingress_ports && !var.enable_sg_rule_ingress_ports_all ? length(var.allowed_ports) : 0
    
    type                        = "ingress"
    security_group_id           = var.security_group_id != "" && !var.enable_security_group ? var.security_group_id : element(concat(aws_security_group.security_group.*.id, [""]), 0)
    from_port                   = var.ingress_ports_from_port != null ? var.ingress_ports_from_port : var.allowed_ports[count.index]
    to_port                     = var.ingress_ports_to_port != null ? var.ingress_ports_to_port : var.allowed_ports[count.index]
    protocol                    = var.ingress_ports_protocol
    cidr_blocks                 = var.cidr_blocks != null ? var.cidr_blocks[var.allowed_ports[count.index]] : null

    ipv6_cidr_blocks            = var.ingress_ports_ipv6_cidr_blocks != null ? var.ingress_ports_ipv6_cidr_blocks : null
    source_security_group_id    = var.ingress_ports_source_security_group_id != null ? var.ingress_ports_source_security_group_id : null
    self                        = var.ingress_ports_self != null ? var.ingress_ports_self : null
    description                 = var.ingress_ports_description != null ? var.ingress_ports_description : null
    
    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_security_group.security_group
    ]
}

resource "aws_security_group_rule" "ingress_ports_all" {
    count                       = var.enable_sg_rule_ingress_ports_all && !var.enable_sg_rule_ingress_ports ? 1 : 0
    
    type                        = "ingress"
    security_group_id           = var.security_group_id != "" && !var.enable_security_group ? var.security_group_id : element(concat(aws_security_group.security_group.*.id, [""]), 0)
    from_port                   = 1
    to_port                     = 65535
    protocol                    = "all"
    self                        = true

    #cidr_blocks                 = var.cidr_blocks != null ? var.cidr_blocks[var.allowed_ports[count.index]] : null
    #ipv6_cidr_blocks            = var.ingress_ports_ipv6_cidr_blocks != null ? var.ingress_ports_ipv6_cidr_blocks : null
    source_security_group_id    = var.ingress_ports_source_security_group_id != null ? var.ingress_ports_source_security_group_id : null
    description                 = var.ingress_ports_description != null ? var.ingress_ports_description : null
    
    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_security_group.security_group
    ]
}

resource "aws_security_group_rule" "egress_ports" {
    count                       = var.enable_sg_rule_egress_ports && !var.enable_sg_rule_egress_ports_all ? length(var.allowed_ports) : 0

    type                        = "egress"
    security_group_id           = var.security_group_id != "" && !var.enable_security_group ? var.security_group_id : element(concat(aws_security_group.security_group.*.id, [""]), 0)
    from_port                   = var.egress_ports_from_port != null ? var.egress_ports_from_port : var.allowed_ports[count.index]
    to_port                     = var.egress_ports_to_port != null ? var.egress_ports_to_port : var.allowed_ports[count.index]
    protocol                    = var.egress_ports_protocol
    cidr_blocks                 = var.cidr_blocks != null ? var.cidr_blocks[var.allowed_ports[count.index]] : null

    ipv6_cidr_blocks            = var.egress_ports_ipv6_cidr_blocks != null ? var.egress_ports_ipv6_cidr_blocks : null
    source_security_group_id    = var.egress_ports_source_security_group_id != null ? var.egress_ports_source_security_group_id : null
    self                        = var.egress_ports_self != null ? var.egress_ports_self : null
    description                 = var.egress_ports_description != null ? var.egress_ports_description : null

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_security_group.security_group
    ]
}

resource "aws_security_group_rule" "egress_ports_all" {
    count                       = var.enable_sg_rule_egress_ports_all && !var.enable_sg_rule_egress_ports ? 1 : 0

    type                        = "egress"
    security_group_id           = var.security_group_id != "" && !var.enable_security_group ? var.security_group_id : element(concat(aws_security_group.security_group.*.id, [""]), 0)
    from_port                   = 0
    to_port                     = 0
    protocol                    = -1
    cidr_blocks                 = ["0.0.0.0/0"]

    ipv6_cidr_blocks            = var.egress_ports_ipv6_cidr_blocks != null ? var.egress_ports_ipv6_cidr_blocks : null
    source_security_group_id    = var.egress_ports_source_security_group_id != null ? var.egress_ports_source_security_group_id : null
    self                        = var.egress_ports_self != null ? var.egress_ports_self : null
    description                 = var.egress_ports_description != null ? var.egress_ports_description : null

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_security_group.security_group
    ]
}

resource "aws_security_group_rule" "custom_ports" {
    count                       = var.enable_sg_rule_custom_ports ? 1 : 0

    type                        = var.custom_ports_type
    security_group_id           = var.security_group_id != "" && !var.enable_security_group ? var.security_group_id : element(concat(aws_security_group.security_group.*.id, [""]), 0)
    from_port                   = var.custom_ports_from_port
    to_port                     = var.custom_ports_to_port
    protocol                    = var.custom_ports_protocol
    cidr_blocks                 = var.custom_ports_cidr_blocks

    ipv6_cidr_blocks            = var.custom_ports_ipv6_cidr_blocks != null ? var.custom_ports_ipv6_cidr_blocks : null
    source_security_group_id    = var.custom_ports_source_security_group_id != null ? var.custom_ports_source_security_group_id : null
    self                        = var.custom_ports_self != null ? var.custom_ports_self : null
    description                 = var.custom_ports_description != null ? var.custom_ports_description : null
    
    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_security_group.security_group
    ]
}