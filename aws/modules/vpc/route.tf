#---------------------------------------------------
# AWS Route
#---------------------------------------------------

# Create route table for private NAT gateway
resource "aws_route" "private_nat_gateway" {
    count                   = var.enable_nat_gateway ? length(var.availability_zones) : 0
    
    route_table_id          = element(aws_route_table.private_route_tables.*.id, count.index)
    destination_cidr_block  = "0.0.0.0/0"
    nat_gateway_id          = element(aws_nat_gateway.nat_gw.*.id, count.index)
    
    timeouts {
        create  = var.timeouts_create
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_route_table.private_route_tables,
        aws_nat_gateway.nat_gw
    ]
}

# Create route table for public internet gateway
resource "aws_route" "public_internet_gateway" {
    count                  = length(var.public_subnet_cidrs) >0 ? 1 : 0
    
    route_table_id         = element(concat(aws_route_table.public_route_tables.*.id, [""]), 0)
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = element(concat(aws_internet_gateway.internet_gw.*.id, [""]), 0)
    
    timeouts {
        create  = var.timeouts_create
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on             = [
        aws_route_table.public_route_tables,
        aws_internet_gateway.internet_gw
    ]
}