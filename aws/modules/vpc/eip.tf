#---------------------------------------------------
# Create EIP
#---------------------------------------------------
resource "aws_eip" "nat_eip" {
    count                       = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : (length(var.azs) >0 ? length(var.azs) : length(lookup(var.availability_zones, var.region))) ) : 0

    vpc                         = var.nat_eip_vpc

    instance                    = var.nat_eip_instance
    network_interface           = var.nat_eip_network_interface
    associate_with_private_ip   = var.nat_eip_associate_with_private_ip
    public_ipv4_pool            = var.nat_eip_public_ipv4_pool

    tags                    = merge(
        {
            "Name"          = var.nat_eip_name != "" ? "${lower(var.nat_eip_name)}" : "${lower(var.name)}-nat-eip-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
    
    depends_on  = []
}