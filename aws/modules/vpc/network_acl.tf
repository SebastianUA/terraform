#---------------------------------------------------
# AWS VPC network acl
#---------------------------------------------------
resource "aws_network_acl" "network_acl" {
    count               = var.enable_network_acl ? 1 : 0

    vpc_id              = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
    subnet_ids          = var.network_acl_subnet_ids

    dynamic "ingress" {
        iterator = ingress
        for_each = var.network_acl_ingress
        content {
            from_port       = lookup(ingress.value, "from_port", 0)
            to_port         = lookup(ingress.value, "to_port", 0)
            rule_no         = lookup(ingress.value, "rule_no", 100)
            action          = lookup(ingress.value, "action", "allow")
            protocol        = lookup(ingress.value, "protocol", -1)
            cidr_block      = lookup(ingress.value, "cidr_block", "0.0.0.0/0")
            ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
            icmp_type       = lookup(ingress.value, "icmp_type", 0)
            icmp_code       = lookup(ingress.value, "icmp_code", 0)
        }
    }

    dynamic "egress" {
        iterator = egress
        for_each = var.network_acl_egress
        content {
            from_port       = lookup(egress.value, "from_port", 0)
            to_port         = lookup(egress.value, "to_port", 0)
            rule_no         = lookup(egress.value, "rule_no", 100)
            action          = lookup(egress.value, "action", "allow")
            protocol        = lookup(egress.value, "protocol", -1)
            cidr_block      = lookup(egress.value, "cidr_block", "0.0.0.0/0")
            ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
            icmp_type       = lookup(egress.value, "icmp_type", 0)
            icmp_code       = lookup(egress.value, "icmp_code", 0)
        }
    }

    tags                    = merge(
        {
            "Name"  = var.network_acl_name != "" ? lower(var.network_acl_name) : "${lower(var.name)}-network-acl-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_vpc.vpc
    ]
}
