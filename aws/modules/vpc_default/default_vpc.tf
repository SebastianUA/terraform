#---------------------------------------------------
# AWS default vpc
#---------------------------------------------------
resource "aws_default_vpc" "default_vpc" {
  count = var.enable_default_vpc ? 1 : 0

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink

  tags = merge(
    {
      Name = var.default_vpc_name != "" ? var.default_vpc_name : "Default VPC"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
