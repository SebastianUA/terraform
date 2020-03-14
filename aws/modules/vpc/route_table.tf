#---------------------------------------------------
# AWS Route table
#---------------------------------------------------

# Create private route table and the route to the internet
resource "aws_route_table" "private_route_tables" {
    count               = length(var.private_subnet_cidrs) >0 ? 1 : 0

    vpc_id              = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
    propagating_vgws    = var.private_propagating_vgws

    tags                = merge(
        {
            "Name"          = var.private_route_tables_name != "" ? "${lower(var.private_route_tables_name)}-${count.index+1}" : "${lower(var.name)}-${lower(var.environment)}-private-route-tables-${count.index+1}"
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

# Create public route table
resource "aws_route_table" "public_route_tables" {
    count               = length(var.public_subnet_cidrs) >0 ? 1 : 0

    vpc_id              = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
    propagating_vgws    = var.public_propagating_vgws

    tags                = merge(
        {
            "Name"          = var.public_route_tables_name != "" ? "${lower(var.public_route_tables_name)}-${count.index+1}" : "${lower(var.name)}-${lower(var.environment)}-public-route-tables-${count.index+1}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on        = [
        aws_vpc.vpc
    ]
}
