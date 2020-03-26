#---------------------------------------------------------------
# Add AWS internet gateway
#---------------------------------------------------------------
resource "aws_internet_gateway" "internet_gw" {
    count               = var.enable_internet_gateway && length(var.public_subnet_cidrs) >0 ? 1 : 0

    vpc_id              = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)

    tags                = merge(
        {
            "Name"  = var.internet_gw_name != "" ? lower(var.internet_gw_name) : "${lower(var.name)}-internet-gw-${lower(var.environment)}"
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
