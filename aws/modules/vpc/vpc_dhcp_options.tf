#---------------------------------------------------------------
# Create VPC DHCP
#---------------------------------------------------------------
resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
    count                   = var.enable_dhcp ? 1 : 0

    domain_name             = var.dhcp_options_domain_name
    domain_name_servers     = var.dhcp_options_domain_name_servers
    ntp_servers             = var.dhcp_options_ntp_servers
    netbios_name_servers    = var.dhcp_options_netbios_name_servers
    netbios_node_type       = var.dhcp_options_netbios_node_type

    tags                    = merge(
        {
            "Name"  = var.vpc_dhcp_name != "" ? lower(var.vpc_dhcp_name) : "${lower(var.name)}-vpn-dhcp-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = []
}
