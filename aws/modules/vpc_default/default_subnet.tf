#---------------------------------------------------
# AWS default subnet
#---------------------------------------------------
resource "aws_default_subnet" "default_subnet" {
  count = var.enable_default_vpc ? (length(var.default_subnet_azs) > 0 ? length(var.default_subnet_azs) : length(lookup(var.availability_zones, var.region))) : 0

  availability_zone       = length(var.default_subnet_azs) > 0 ? var.default_subnet_azs[count.index] : element(lookup(var.availability_zones, var.region), count.index)
  map_public_ip_on_launch = var.default_subnet_map_public_ip_on_launch

  tags = merge(
    {
      Name = var.default_subnet_name != "" ? lower(var.default_subnet_name) : "Default subnet for ${length(var.default_subnet_azs) > 0 ? var.default_subnet_azs[count.index] : element(lookup(var.availability_zones, var.region), count.index)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
