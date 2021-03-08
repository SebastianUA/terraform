#---------------------------------------------------------------
# AWS VPC
#---------------------------------------------------------------
resource "aws_vpc" "vpc" {
  count = var.enable_vpc ? 1 : 0

  cidr_block = cidrsubnet(var.vpc_cidr_block, 0, 0)

  instance_tenancy                 = var.vpc_instance_tenancy
  enable_dns_support               = var.vpc_enable_dns_support
  enable_dns_hostnames             = var.vpc_enable_dns_hostnames
  enable_classiclink               = var.vpc_enable_classiclink
  enable_classiclink_dns_support   = var.vpc_enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.vpc_assign_generated_ipv6_cidr_block

  tags = merge(
    {
      Name = var.vpc_name != "" ? lower(var.vpc_name) : "${lower(var.name)}-vpc-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
