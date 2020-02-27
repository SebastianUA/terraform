#---------------------------------------------------------------
# DHCP Options Set Association
#---------------------------------------------------------------
resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
    count                   = var.enable_dhcp ? 1 : 0

    vpc_id                  = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
    dhcp_options_id         = var.dhcp_options_id != "" ? var.dhcp_options_id : element(concat(aws_vpc_dhcp_options.vpc_dhcp_options.*.id, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_vpc.vpc,
        aws_vpc_dhcp_options.vpc_dhcp_options
    ]
}
