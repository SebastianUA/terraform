#---------------------------------------------------
# Create AWS NLB target group
#---------------------------------------------------
resource "aws_lb_target_group" "nlb_target_group" {
    count                               = var.enable_nlb_target_group ? 1 : 0

    name                                = var.nlb_target_group_name != "" && var.name_prefix == "" ? lower(var.nlb_target_group_name) : null
    name_prefix                         = var.name_prefix != "" && var.nlb_target_group_name == "" ? var.name_prefix : null
    port                                = var.backend_port
    protocol                            = upper(var.backend_protocol)
    vpc_id                              = var.vpc_id
    target_type                         = var.target_type
    deregistration_delay                = var.deregistration_delay
    slow_start                          = var.slow_start
    lambda_multi_value_headers_enabled  = var.lambda_multi_value_headers_enabled
    proxy_protocol_v2                   = var.proxy_protocol_v2

    dynamic "health_check" {
        for_each = var.health_check
        content {
            enabled             = lookup(health_check.value, "enabled",  null)
            interval            = lookup(health_check.value, "interval",  null)
            port                = lookup(health_check.value, "port",  null)
            protocol            = lookup(health_check.value, "protocol",  null)
            path                = lookup(health_check.value, "path",  null)
            timeout             = lookup(health_check.value, "timeout",  null)
            healthy_threshold   = lookup(health_check.value, "healthy_threshold",  null)
            unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold",  null)
            matcher             = lookup(health_check.value, "matcher",  null)
        }
    }

    tags = merge(
        {
            "Name"          = var.nlb_target_group_name != "" && var.name_prefix == "" ? lower(var.nlb_target_group_name) : var.name_prefix
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = []
}
