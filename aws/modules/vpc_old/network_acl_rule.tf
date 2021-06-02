#---------------------------------------------------
# AWS VPC network acl rule
#---------------------------------------------------
resource "aws_network_acl_rule" "network_acl_rule" {
  count = var.enable_network_acl_rule ? length(var.network_acl_rule_stack) : 0

  network_acl_id = lookup(var.network_acl_rule_stack[count.index], "network_acl_id", (var.enable_network_acl ? element(aws_network_acl.network_acl.*.id, 0) : null))
  rule_number    = lookup(var.network_acl_rule_stack[count.index], "rule_number", null)
  protocol       = lookup(var.network_acl_rule_stack[count.index], "protocol", null)
  rule_action    = lookup(var.network_acl_rule_stack[count.index], "rule_action", null)

  egress          = lookup(var.network_acl_rule_stack[count.index], "egress", null)
  cidr_block      = lookup(var.network_acl_rule_stack[count.index], "cidr_block", (var.enable_vpc ? element(aws_vpc.vpc.*.cidr_block, 0) : null))
  ipv6_cidr_block = lookup(var.network_acl_rule_stack[count.index], "ipv6_cidr_block", null)
  from_port       = lookup(var.network_acl_rule_stack[count.index], "from_port", null)
  to_port         = lookup(var.network_acl_rule_stack[count.index], "to_port", null)
  icmp_type       = lookup(var.network_acl_rule_stack[count.index], "icmp_type", null)
  icmp_code       = lookup(var.network_acl_rule_stack[count.index], "icmp_code", null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc,
    aws_network_acl.network_acl
  ]
}
