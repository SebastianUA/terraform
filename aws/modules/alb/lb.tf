#---------------------------------------------------
# Create AWS ALB 
#---------------------------------------------------
resource "aws_lb" "alb" {                      
    count                               = var.enable_alb && !var.enable_alb_prefix ? 1 :0

    name                                = var.alb_name !="" ? "${lower(var.alb_name)}" : "${lower(var.name)}-alb-${lower(var.environment)}"
    security_groups                     = var.security_groups
    subnets                             = var.subnets
    internal                            = var.lb_internal

    enable_cross_zone_load_balancing    = var.enable_cross_zone_load_balancing
    enable_deletion_protection          = var.enable_deletion_protection  
    load_balancer_type                  = var.load_balancer_type
    idle_timeout                        = var.idle_timeout
    enable_http2                        = var.enable_http2
    ip_address_type                     = var.ip_address_type
    
    access_logs {
        enabled = var.access_logs_enabled
        bucket  = var.access_logs_bucket
        prefix  = var.access_logs_prefix
    }

    # not working with subnets
    #subnet_mapping {
    #    subnet_id       = ""
    #    allocation_id   = ""
    #}

    timeouts {
        create  = var.timeouts_create
        update  = var.timeouts_update 
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    tags = merge(
        var.tags,
        {
            "Name"          = var.alb_name !="" ? "${lower(var.alb_name)}" : "${lower(var.name)}-alb-${lower(var.environment)}"
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
    )

    depends_on = []
}

resource "aws_lb" "alb_prefix" {
    count                               = var.enable_alb && var.enable_alb_prefix ? 1 : 0

    name_prefix                         = var.name_prefix
    security_groups                     = var.security_groups
    subnets                             = var.subnets
    internal                            = var.lb_internal

    enable_cross_zone_load_balancing    = var.enable_cross_zone_load_balancing
    enable_deletion_protection          = var.enable_deletion_protection  
    load_balancer_type                  = var.load_balancer_type
    idle_timeout                        = var.idle_timeout
    enable_http2                        = var.enable_http2
    ip_address_type                     = var.ip_address_type
   
    access_logs {
        enabled = var.access_logs_enabled
        bucket  = var.access_logs_bucket
        prefix  = var.access_logs_prefix
    }

    # not working with subnets
    #subnet_mapping {
    #    subnet_id       = ""
    #    allocation_id   = ""
    #}

    timeouts {
        create  = var.timeouts_create
        update  = var.timeouts_update  
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    tags = merge(
        var.tags,
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
    )

    depends_on = []
}