#---------------------------------------------------
# AWS default subnet
#---------------------------------------------------
resource "aws_default_subnet" "default_subnet" {
    count                   = var.enable_default_vpc ? (length(var.azs) >0 ? length(var.azs) : length(lookup(var.availability_zones, var.region))) : 0

    availability_zone       = length(var.azs) >0 ? var.azs[count.index] : element(lookup(var.availability_zones, var.region), count.index)
    map_public_ip_on_launch = var.map_public_ip_on_launch

    tags                    = merge(
        {
            "Name"  = var.default_vpc_name != "" ? lower(var.default_vpc_name) : "Default subnet for ${length(var.azs) >0 ? var.azs[count.index] : element(lookup(var.availability_zones, var.region), count.index)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = []
}
