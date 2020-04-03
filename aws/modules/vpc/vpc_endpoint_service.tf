#---------------------------------------------------
# AWS VPC endpoint service
#---------------------------------------------------
resource "aws_vpc_endpoint_service" "vpc_endpoint_service" {
    count                           = var.enable_vpc_endpoint && length(var.vpc_endpoint_service_network_load_balancer_arns) >0 ? 1 : 0

    acceptance_required             = var.vpc_endpoint_service_acceptance_required
    network_load_balancer_arns      = var.vpc_endpoint_service_network_load_balancer_arns

    allowed_principals              = var.vpc_endpoint_service_allowed_principals

    tags                            = merge(
        {
            "Name"  = var.vpc_endpoint_service_name != "" ? lower(var.vpc_endpoint_service_name) : "${lower(var.name)}-vpc-endpoint-svc-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                      = []
}
