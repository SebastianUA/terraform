#---------------------------------------------------
# AWS Route
#---------------------------------------------------

# Create route table for private NAT gateway
resource "aws_route" "private_nat_gateway" {
  count = var.enable_nat_gateway && length(var.private_subnet_cidrs) > 0 ? (var.single_nat_gateway ? 1 : (length(var.azs) > 0 ? length(var.azs) : length(lookup(var.availability_zones, var.region)))) : 0

  route_table_id         = element(aws_route_table.private_route_tables.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gateway.*.id, count.index)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.private_route_tables,
    aws_nat_gateway.nat_gateway
  ]
}

# Create route table for private NAT gateway for k8s
resource "aws_route" "k8s_private_nat_gateway" {
  count = var.enable_nat_gateway && length(var.k8s_private_subnet_cidrs) > 0 ? (var.single_nat_gateway ? 1 : (length(var.azs) > 0 ? length(var.azs) : length(lookup(var.availability_zones, var.region)))) : 0

  route_table_id         = element(concat(aws_route_table.k8s_private_route_tables.*.id, [""]), count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gateway.*.id, count.index)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.k8s_private_route_tables,
    aws_nat_gateway.nat_gateway
  ]
}

# Create route table for public internet gateway
resource "aws_route" "public_internet_gateway" {
  count = var.enable_internet_gateway && length(var.public_subnet_cidrs) > 0 ? 1 : 0

  route_table_id         = element(aws_route_table.public_route_tables.*.id, 0)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(aws_internet_gateway.internet_gateway.*.id, 0)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.public_route_tables,
    aws_internet_gateway.internet_gateway
  ]
}

# Create route table for public internet gateway for k8s
resource "aws_route" "k8s_public_internet_gateway" {
  count = var.enable_internet_gateway && length(var.k8s_public_subnet_cidrs) > 0 ? 1 : 0

  route_table_id         = element(concat(aws_route_table.k8s_public_route_tables.*.id, [""]), 0)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(aws_internet_gateway.internet_gateway.*.id, 0)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.k8s_public_route_tables,
    aws_internet_gateway.internet_gateway
  ]
}

# Create route table for VPC peering for public subnets
resource "aws_route" "vpc_peering" {
  count = var.peering_destination_cidr_block != null && length(var.public_subnet_cidrs) > 0 ? 1 : 0

  route_table_id         = element(aws_route_table.public_route_tables.*.id, count.index)
  destination_cidr_block = var.peering_destination_cidr_block
  gateway_id             = var.peering_gateway_id != null ? var.peering_gateway_id : element(aws_vpc_peering_connection.vpc_peering_connection.*.id, 0)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.public_route_tables,
    aws_vpc_peering_connection.vpc_peering_connection
  ]
}

# Create custom route
resource "aws_route" "custom_route" {
  count = var.enable_custom_route ? 1 : 0

  route_table_id              = var.custom_route_route_table_id
  destination_cidr_block      = var.custom_route_destination_cidr_block
  destination_ipv6_cidr_block = var.custom_route_destination_ipv6_cidr_block

  vpc_peering_connection_id = var.custom_route_vpc_peering_connection_id
  egress_only_gateway_id    = var.custom_route_egress_only_gateway_id
  gateway_id                = var.custom_route_gateway_id
  nat_gateway_id            = var.custom_route_nat_gateway_id
  local_gateway_id          = var.custom_route_local_gateway_id
  network_interface_id      = var.custom_route_network_interface_id
  transit_gateway_id        = var.custom_route_transit_gateway_id
  vpc_endpoint_id           = var.custom_route_vpc_endpoint_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

# Create custom route for public (internet gateway)
resource "aws_route" "public_custom_route" {
  count = var.public_custom_peering_destination_cidr_block != null && var.public_custom_gateway_id != null ? length(var.public_custom_peering_destination_cidr_block) : 0

  route_table_id         = element(aws_route_table.public_route_tables.*.id, 0)
  destination_cidr_block = var.public_custom_peering_destination_cidr_block[count.index]
  gateway_id             = var.public_custom_gateway_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.public_route_tables
  ]
}

# Create custom route for private (NAT gateway)
resource "aws_route" "private_custom_route" {
  count = var.private_custom_peering_destination_cidr_block != null && var.private_custom_gateway_id != null ? length(var.private_custom_peering_destination_cidr_block) : 0

  route_table_id         = element(aws_route_table.private_route_tables.*.id, 0)
  destination_cidr_block = var.private_custom_peering_destination_cidr_block[count.index]
  gateway_id             = var.private_custom_gateway_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route_table.private_route_tables
  ]
}
