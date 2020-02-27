#---------------------------------------------------------------
# Create VPC
#---------------------------------------------------------------
resource "aws_vpc" "vpc" {
    count                               = var.enable_vpc ? 1 : 0

    cidr_block                          = cidrsubnet(var.vpc_cidr, 0, 0)
    instance_tenancy                    = var.instance_tenancy
    enable_dns_support                  = var.enable_dns_support
    enable_dns_hostnames                = var.enable_dns_hostnames
    enable_classiclink                  = var.enable_classiclink
    enable_classiclink_dns_support      = var.enable_classiclink_dns_support
    assign_generated_ipv6_cidr_block    = var.assign_generated_ipv6_cidr_block

    tags                                = merge(
        {
            "Name"          = var.vpc_name != "" ? lower(var.vpc_name) : "${lower(var.name)}-vpc-${lower(var.environment)}"
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

    depends_on               = []
}
