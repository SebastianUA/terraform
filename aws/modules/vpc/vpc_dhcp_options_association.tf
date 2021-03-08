#---------------------------------------------------------------
# AWS DHCP Options Set Association
#---------------------------------------------------------------
resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
  count = var.enable_dhcp ? 1 : 0

  vpc_id          = var.vpc_dhcp_options_association_vpc_id != "" ? var.vpc_dhcp_options_association_vpc_id : (var.enable_vpc ? element(aws_vpc.vpc.*.id, count.index) : null)
  dhcp_options_id = var.vpc_dhcp_options_association_dhcp_options_id != "" ? var.vpc_dhcp_options_association_dhcp_options_id : element(aws_vpc_dhcp_options.vpc_dhcp_options.*.id, count.index)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc,
    aws_vpc_dhcp_options.vpc_dhcp_options
  ]
}
