#---------------------------------------------------
# AWS security group
#---------------------------------------------------
resource "aws_security_group" "security_group" {
  count = var.enable_security_group ? 1 : 0

  name        = var.security_group_name != "" && var.security_group_name_prefix == "" ? lower(var.security_group_name) : null
  name_prefix = var.security_group_name_prefix != "" && var.security_group_name == "" ? lower(var.security_group_name_prefix) : null

  description            = var.security_group_description
  vpc_id                 = var.security_group_vpc_id
  revoke_rules_on_delete = var.security_group_revoke_rules_on_delete

  dynamic "ingress" {
    iterator = ingress
    for_each = var.security_group_ingress

    content {
      protocol  = lookup(ingress.value, "protocol", null)
      from_port = lookup(ingress.value, "from_port", null)
      to_port   = lookup(ingress.value, "to_port", null)

      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(ingress.value, "prefix_list_ids", null)
      description      = lookup(ingress.value, "description", null)
      security_groups  = lookup(ingress.value, "security_groups", null)
      self             = lookup(ingress.value, "self", null)
    }
  }

  dynamic "egress" {
    iterator = egress
    for_each = var.security_group_egress

    content {
      protocol  = lookup(egress.value, "protocol", null)
      from_port = lookup(egress.value, "from_port", null)
      to_port   = lookup(egress.value, "to_port", null)

      cidr_blocks      = lookup(egress.value, "cidr_blocks", null)
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(egress.value, "prefix_list_ids", null)
      description      = lookup(egress.value, "description", null)
      security_groups  = lookup(egress.value, "security_groups", null)
      self             = lookup(egress.value, "self", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.security_group_timeouts)) > 0 ? [var.security_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.security_group_name != "" && var.security_group_name_prefix == "" ? lower(var.security_group_name) : lower(var.security_group_name_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
