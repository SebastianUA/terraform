locals {
  security_group_id = var.enable_security_group ? concat(aws_security_group.security_group.*.id, [""])[0] : var.security_group_id

  normalized_ingress_rules = concat([], [
    for rule in var.ingress_rules :
    concat(
      [
        for idx, cidr in rule.ipv4_cidrs :
        {
          id          = "${rule.id}/ipv4/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = cidr
          ipv6_cidr      = null
          prefix_list    = null
          security_group = null
        }
      ],
      [
        for idx, cidr in rule.ipv6_cidrs :
        {
          id          = "${rule.id}/ipv6/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = cidr
          prefix_list    = null
          security_group = null
        }
      ],
      [
        for idx, prefix_list in rule.prefix_lists :
        {
          id          = "${rule.id}/prefix-list/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = prefix_list
          security_group = null
        }
      ],
      [
        for idx, security_group in rule.security_groups :
        {
          id          = "${rule.id}/security-group/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = null
          security_group = security_group
        }
      ],
      [
        for self in [rule.self] :
        {
          id          = "${rule.id}/self"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = null
          security_group = local.security_group_id
        }
        if self
      ]
    )
  ]...)
  normalized_egress_rules = concat([], [
    for rule in var.egress_rules :
    concat(
      [
        for idx, cidr in rule.ipv4_cidrs :
        {
          id          = "${rule.id}/ipv4/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = cidr
          ipv6_cidr      = null
          prefix_list    = null
          security_group = null
        }
      ],
      [
        for idx, cidr in rule.ipv6_cidrs :
        {
          id          = "${rule.id}/ipv6/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = cidr
          prefix_list    = null
          security_group = null
        }
      ],
      [
        for idx, prefix_list in rule.prefix_lists :
        {
          id          = "${rule.id}/prefix-list/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = prefix_list
          security_group = null
        }
      ],
      [
        for idx, security_group in rule.security_groups :
        {
          id          = "${rule.id}/security-group/${idx}"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = null
          security_group = security_group
        }
      ],
      [
        for self in [rule.self] :
        {
          id          = "${rule.id}/self"
          description = rule.description

          protocol  = rule.protocol
          from_port = rule.from_port
          to_port   = rule.to_port

          ipv4_cidr      = null
          ipv6_cidr      = null
          prefix_list    = null
          security_group = local.security_group_id
        }
        if self
      ]
    )
  ]...)
}

