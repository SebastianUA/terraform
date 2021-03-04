#---------------------------------------------------
# AWS security group rules
#---------------------------------------------------
resource "aws_security_group_rule" "ingress_ports" {
  count = var.enable_sg_rule_ingress_ports && !var.enable_sg_rule_ingress_ports_all ? length(var.ingress_ports_stack) : 0

  type              = "ingress"
  protocol          = lookup(var.ingress_ports_stack[count.index], "protocol", null)
  from_port         = lookup(var.ingress_ports_stack[count.index], "from_port", null)
  to_port           = lookup(var.ingress_ports_stack[count.index], "to_port", null)
  security_group_id = lookup(var.ingress_ports_stack[count.index], "to_port", (var.enable_security_group ? element(concat(aws_security_group.security_group.*.id, [""]), 0) : null))

  cidr_blocks              = lookup(var.ingress_ports_stack[count.index], "cidr_blocks", null)
  prefix_list_ids          = lookup(var.ingress_ports_stack[count.index], "prefix_list_ids", null)
  ipv6_cidr_blocks         = lookup(var.ingress_ports_stack[count.index], "ipv6_cidr_blocks", null)
  source_security_group_id = lookup(var.ingress_ports_stack[count.index], "source_security_group_id", null)
  self                     = lookup(var.ingress_ports_stack[count.index], "self", null)
  description              = lookup(var.ingress_ports_stack[count.index], "description", null)

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_security_group.security_group
  ]
}

resource "aws_security_group_rule" "egress_ports" {
  count = var.enable_sg_rule_egress_ports && !var.enable_sg_rule_egress_ports_all ? length(var.egress_ports_stack) : 0

  type              = "egress"
  protocol          = lookup(var.egress_ports_stack[count.index], "protocol", null)
  from_port         = lookup(var.egress_ports_stack[count.index], "from_port", null)
  to_port           = lookup(var.egress_ports_stack[count.index], "to_port", null)
  security_group_id = lookup(var.egress_ports_stack[count.index], "to_port", (var.enable_security_group ? element(concat(aws_security_group.security_group.*.id, [""]), 0) : null))

  cidr_blocks              = lookup(var.egress_ports_stack[count.index], "cidr_blocks", null)
  prefix_list_ids          = lookup(var.egress_ports_stack[count.index], "prefix_list_ids", null)
  ipv6_cidr_blocks         = lookup(var.egress_ports_stack[count.index], "ipv6_cidr_blocks", null)
  source_security_group_id = lookup(var.egress_ports_stack[count.index], "source_security_group_id", null)
  self                     = lookup(var.egress_ports_stack[count.index], "self", null)
  description              = lookup(var.egress_ports_stack[count.index], "description", null)

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_security_group.security_group
  ]
}

resource "aws_security_group_rule" "ingress_ports_all" {
  count = var.enable_sg_rule_ingress_ports_all && !var.enable_sg_rule_ingress_ports ? length(var.ingress_ports_all_stack) : 0

  type              = "ingress"
  security_group_id = lookup(var.ingress_ports_all_stack[count.index], "to_port", (var.enable_security_group ? element(concat(aws_security_group.security_group.*.id, [""]), 0) : null))
  from_port         = lookup(var.ingress_ports_all_stack[count.index], "from_port", 0)
  to_port           = lookup(var.ingress_ports_all_stack[count.index], "to_port", 0)
  protocol          = lookup(var.ingress_ports_all_stack[count.index], "protocol", -1)

  cidr_blocks              = lookup(var.ingress_ports_all_stack[count.index], "cidr_blocks", null)
  prefix_list_ids          = lookup(var.ingress_ports_all_stack[count.index], "prefix_list_ids", null)
  ipv6_cidr_blocks         = lookup(var.ingress_ports_all_stack[count.index], "ipv6_cidr_blocks", null)
  source_security_group_id = lookup(var.ingress_ports_all_stack[count.index], "source_security_group_id", null)
  self                     = lookup(var.ingress_ports_all_stack[count.index], "self", null)
  description              = lookup(var.ingress_ports_all_stack[count.index], "description", null)

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_security_group.security_group
  ]
}

resource "aws_security_group_rule" "egress_ports_all" {
  count = var.enable_sg_rule_egress_ports_all && !var.enable_sg_rule_egress_ports ? length(var.egress_ports_all_stack) : 0

  type              = "egress"
  security_group_id = lookup(var.egress_ports_all_stack[count.index], "to_port", (var.enable_security_group ? element(concat(aws_security_group.security_group.*.id, [""]), 0) : null))
  from_port         = lookup(var.egress_ports_all_stack[count.index], "from_port", 0)
  to_port           = lookup(var.egress_ports_all_stack[count.index], "to_port", 0)
  protocol          = lookup(var.egress_ports_all_stack[count.index], "protocol", -1)

  cidr_blocks              = lookup(var.egress_ports_all_stack[count.index], "cidr_blocks", null)
  prefix_list_ids          = lookup(var.egress_ports_all_stack[count.index], "prefix_list_ids", null)
  ipv6_cidr_blocks         = lookup(var.egress_ports_all_stack[count.index], "ipv6_cidr_blocks", null)
  source_security_group_id = lookup(var.egress_ports_all_stack[count.index], "source_security_group_id", null)
  self                     = lookup(var.egress_ports_all_stack[count.index], "self", null)
  description              = lookup(var.egress_ports_all_stack[count.index], "description", null)

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_security_group.security_group
  ]
}
