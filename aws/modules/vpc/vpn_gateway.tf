#---------------------------------------------------------------
# Create AWS VPN gateway
#---------------------------------------------------------------
resource "aws_vpn_gateway" "vpn_gw" {
    count               = var.enable_vpn_gateway ? 1 : 0

    vpc_id              = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)

    availability_zone   = var.vpn_gw_availability_zone
    amazon_side_asn     = var.vpn_gw_amazon_side_asn

    tags                = merge(
        {
            "Name"  = var.vpn_gw_name != "" ? lower(var.vpn_gw_name) : "${lower(var.name)}-vpn-gw-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_vpc.vpc
    ]
}
