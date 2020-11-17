#---------------------------------------------------------------
# Add AWS subnets (private)
#---------------------------------------------------------------
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)

  cidr_block              = var.private_subnet_cidrs[count.index]
  vpc_id                  = var.vpc_id != "" && ! var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
  map_public_ip_on_launch = false
  availability_zone       = length(var.azs) > 0 ? var.azs[count.index] : element(lookup(var.availability_zones, var.region), count.index)

  availability_zone_id            = var.availability_zone_id
  ipv6_cidr_block                 = var.private_subnet_ipv6_cidrs != null ? var.private_subnet_ipv6_cidrs[count.index] : null
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  timeouts {
    create = var.subnet_timeouts_create
    delete = var.subnet_timeouts_delete
  }

  tags = merge(
    {
      "Name" = var.private_subnets_name != "" ? "${lower(var.private_subnets_name)}-${count.index + 1}" : "${lower(var.name)}-${lower(var.environment)}-private_subnet-${count.index + 1}"
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

#---------------------------------------------------------------
# Add AWS subnets (public)
#---------------------------------------------------------------
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)

  cidr_block              = var.public_subnet_cidrs[count.index]
  vpc_id                  = var.vpc_id != "" && ! var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = length(var.azs) > 0 ? var.azs[count.index] : element(lookup(var.availability_zones, var.region), count.index)

  availability_zone_id            = var.availability_zone_id
  ipv6_cidr_block                 = var.public_subnet_ipv6_cidrs != null ? var.public_subnet_ipv6_cidrs[count.index] : null
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  timeouts {
    create = var.subnet_timeouts_create
    delete = var.subnet_timeouts_delete
  }

  tags = merge(
    {
      "Name" = var.public_subnets_name != "" ? "${lower(var.public_subnets_name)}-${count.index + 1}" : "${lower(var.name)}-${lower(var.environment)}-public_subnet-${count.index + 1}"
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
