#---------------------------------------------------
# AWS Route table
#---------------------------------------------------

# Create private route table and the route to the internet
resource "aws_route_table" "private_route_tables" {
  count = length(var.private_subnet_cidrs) > 0 ? 1 : 0

  vpc_id = var.private_route_tables_vpc_id != "" ? var.private_route_tables_vpc_id : (var.enable_vpc ? aws_vpc.vpc.0.id : null)

  propagating_vgws = var.private_route_tables_propagating_vgws

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.private_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      instance_id               = lookup(route_ipv4.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }

  dynamic "route" {
    iterator = route_ipv6
    for_each = var.private_route_tables_route_ipv6

    content {
      ipv6_cidr_block        = lookup(route_ipv6.value, "ipv6_cidr_block", "::/0")
      egress_only_gateway_id = lookup(route_ipv6.value, "egress_only_gateway_id", null)

      gateway_id                = lookup(route_ipv6.value, "gateway_id", null)
      instance_id               = lookup(route_ipv6.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv6.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv6.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv6.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv6.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv6.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv6.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      Name = var.private_route_tables_name != "" ? lower(var.private_route_tables_name) : "${lower(var.name)}-private-route-tables-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}

# Create private route table and the route to the internet for K8S
resource "aws_route_table" "k8s_private_route_tables" {
  count = length(var.k8s_private_subnet_cidrs) > 0 ? 1 : 0

  vpc_id = var.k8s_private_route_tables_vpc_id != "" ? var.k8s_private_route_tables_vpc_id : (var.enable_vpc ? aws_vpc.vpc.0.id : null)

  propagating_vgws = var.k8s_private_route_tables_propagating_vgws

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.k8s_private_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      instance_id               = lookup(route_ipv4.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }

  dynamic "route" {
    iterator = route_ipv6
    for_each = var.k8s_private_route_tables_route_ipv6

    content {
      ipv6_cidr_block        = lookup(route_ipv6.value, "ipv6_cidr_block", "::/0")
      egress_only_gateway_id = lookup(route_ipv6.value, "egress_only_gateway_id", null)

      gateway_id                = lookup(route_ipv6.value, "gateway_id", null)
      instance_id               = lookup(route_ipv6.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv6.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv6.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv6.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv6.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv6.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv6.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      Name = var.k8s_private_route_tables_name != "" ? lower(var.k8s_private_route_tables_name) : "${lower(var.name)}-k8s-private-route-tables-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}

# Create public route table
resource "aws_route_table" "public_route_tables" {
  count = length(var.public_subnet_cidrs) > 0 ? 1 : 0

  vpc_id = var.public_route_tables_vpc_id != "" ? var.public_route_tables_vpc_id : (var.enable_vpc ? aws_vpc.vpc.0.id : null)

  propagating_vgws = var.public_route_tables_propagating_vgws

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.public_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      instance_id               = lookup(route_ipv4.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }

  dynamic "route" {
    iterator = route_ipv6
    for_each = var.public_route_tables_route_ipv6

    content {
      ipv6_cidr_block        = lookup(route_ipv6.value, "ipv6_cidr_block", "::/0")
      egress_only_gateway_id = lookup(route_ipv6.value, "egress_only_gateway_id", null)

      gateway_id                = lookup(route_ipv6.value, "gateway_id", null)
      instance_id               = lookup(route_ipv6.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv6.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv6.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv6.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv6.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv6.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv6.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      Name = var.public_route_tables_name != "" ? lower(var.public_route_tables_name) : "${lower(var.name)}-public-route-tables-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}

# Create public route table for k8s
resource "aws_route_table" "k8s_public_route_tables" {
  count = length(var.k8s_public_subnet_cidrs) > 0 ? 1 : 0

  vpc_id = var.k8s_public_route_tables_vpc_id != "" ? var.k8s_public_route_tables_vpc_id : (var.enable_vpc ? aws_vpc.vpc.0.id : null)

  propagating_vgws = var.k8s_public_route_tables_propagating_vgws

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.k8s_public_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      instance_id               = lookup(route_ipv4.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }

  dynamic "route" {
    iterator = route_ipv6
    for_each = var.k8s_public_route_tables_route_ipv6

    content {
      ipv6_cidr_block        = lookup(route_ipv6.value, "ipv6_cidr_block", "::/0")
      egress_only_gateway_id = lookup(route_ipv6.value, "egress_only_gateway_id", null)

      gateway_id                = lookup(route_ipv6.value, "gateway_id", null)
      instance_id               = lookup(route_ipv6.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv6.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv6.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv6.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv6.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv6.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv6.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      Name = var.k8s_public_route_tables_name != "" ? lower(var.k8s_public_route_tables_name) : "${lower(var.name)}-k8s-public-route-tables-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}

# Create custom route table
resource "aws_route_table" "custom_route_tables" {
  count = var.enable_custom_route_tables ? 1 : 0

  vpc_id = var.custom_route_tables_vpc_id != "" ? var.custom_route_tables_vpc_id : (var.enable_vpc ? aws_vpc.vpc.0.id : null)

  propagating_vgws = var.custom_route_tables_propagating_vgws

  dynamic "route" {
    iterator = route_ipv4
    for_each = var.custom_route_tables_route_ipv4

    content {
      cidr_block = lookup(route_ipv4.value, "cidr_block", "0.0.0.0/0")
      gateway_id = lookup(route_ipv4.value, "gateway_id", null)

      egress_only_gateway_id    = lookup(route_ipv4.value, "egress_only_gateway_id", null)
      instance_id               = lookup(route_ipv4.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv4.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv4.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv4.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv4.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv4.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv4.value, "vpc_peering_connection_id", null)
    }
  }

  dynamic "route" {
    iterator = route_ipv6
    for_each = var.custom_route_tables_route_ipv6

    content {
      ipv6_cidr_block        = lookup(route_ipv6.value, "ipv6_cidr_block", "::/0")
      egress_only_gateway_id = lookup(route_ipv6.value, "egress_only_gateway_id", null)

      gateway_id                = lookup(route_ipv6.value, "gateway_id", null)
      instance_id               = lookup(route_ipv6.value, "instance_id", null)
      nat_gateway_id            = lookup(route_ipv6.value, "nat_gateway_id", null)
      local_gateway_id          = lookup(route_ipv6.value, "local_gateway_id", null)
      network_interface_id      = lookup(route_ipv6.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route_ipv6.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route_ipv6.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route_ipv6.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      Name = var.custom_route_tables_name != "" ? lower(var.custom_route_tables_name) : "${lower(var.name)}-custom-route-tables-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}