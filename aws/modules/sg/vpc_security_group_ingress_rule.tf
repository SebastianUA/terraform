###################################################
# Ingress Rules for Security Group
###################################################

resource "aws_vpc_security_group_ingress_rule" "vpc_security_group_ingress_rule" {
  for_each = {
    for rule in local.normalized_ingress_rules :
    rule.id => rule
  }

  security_group_id = local.security_group_id
  description       = each.value.description

  ip_protocol = each.value.protocol
  from_port = (contains(["all", "-1"], each.value.protocol)
    ? null
    : each.value.from_port
  )
  to_port = (contains(["all", "-1"], each.value.protocol)
    ? null
    : each.value.to_port
  )

  cidr_ipv4                    = each.value.ipv4_cidr
  cidr_ipv6                    = each.value.ipv6_cidr
  prefix_list_id               = each.value.prefix_list
  referenced_security_group_id = each.value.security_group

  tags = merge(
    {
      "Name" = each.key
    },
    var.tags,
  )
}