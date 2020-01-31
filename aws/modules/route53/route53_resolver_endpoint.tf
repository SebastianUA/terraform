#---------------------------------------------------
# Create route53 resolver endpoint
#---------------------------------------------------
resource "aws_route53_resolver_endpoint" "route53_resolver_endpoint" {
    count                   = var.enable_route53_resolver_endpoint ? 1 : 0
  
    name                    = var.route53_resolver_endpoint_name != "" ? lower(var.route53_resolver_endpoint_name) : "${lower(var.name)}-route53_resolve-endpoint-${lower(var.environment)}"
    direction               = var.route53_resolver_endpoint_direction
    security_group_ids      = var.route53_resolver_endpoint_security_group_ids

    dynamic "ip_address" {
        for_each = var.route53_resolver_endpoint_ip_address
        content {
            subnet_id       = lookup(ip_address.value, "subnet_id",  null)
            ip              = lookup(ip_address.value, "ip",  null)
        }
    }

    tags = merge(
        {
            "Name"          = var.route53_resolver_endpoint_name != "" ? lower(var.route53_resolver_endpoint_name) : "${lower(var.name)}-route53_resolve-endpoint-${lower(var.environment)}"
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

    timeouts {
        create  = var.timeouts_create
        update  = var.timeouts_update
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
    
    depends_on              = []
}