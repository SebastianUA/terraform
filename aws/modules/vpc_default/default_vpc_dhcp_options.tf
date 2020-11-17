#---------------------------------------------------
# AWS default vpc dhcp options
#---------------------------------------------------
resource "aws_default_vpc_dhcp_options" "default_vpc_dhcp_options" {
  count = var.enable_default_vpc ? 1 : 0

  netbios_name_servers = var.netbios_name_servers
  netbios_node_type    = var.netbios_node_type

  tags = merge(
    {
      "Name" = var.default_vpc_dhcp_options_name != "" ? lower(var.default_vpc_dhcp_options_name) : "Default DHCP Option Set"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
