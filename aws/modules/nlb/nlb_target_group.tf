#---------------------------------------------------
# AWS NLB target group
#---------------------------------------------------
resource "aws_lb_target_group" "nlb_target_group" {
  count = var.enable_nlb_target_group ? 1 : 0

  name                               = var.nlb_target_group_name != null && var.nlb_target_group_name_prefix == null ? lower(var.nlb_target_group_name) : null
  name_prefix                        = var.nlb_target_group_name_prefix != null && var.nlb_target_group_name == null ? var.nlb_target_group_name_prefix : null
  port                               = var.nlb_target_group_port
  protocol                           = upper(var.nlb_target_group_protocol)
  vpc_id                             = var.nlb_target_group_vpc_id
  target_type                        = var.nlb_target_group_target_type
  deregistration_delay               = var.nlb_target_group_deregistration_delay
  slow_start                         = var.nlb_target_group_slow_start
  lambda_multi_value_headers_enabled = var.nlb_target_group_lambda_multi_value_headers_enabled
  proxy_protocol_v2                  = var.nlb_target_group_proxy_protocol_v2

  dynamic "health_check" {
    iterator = health_check
    for_each = var.nlb_target_group_health_check

    content {
      enabled             = lookup(health_check.value, "enabled", null)
      interval            = lookup(health_check.value, "interval", null)
      port                = lookup(health_check.value, "port", null)
      protocol            = lookup(health_check.value, "protocol", null)
      path                = lookup(health_check.value, "path", null)
      timeout             = lookup(health_check.value, "timeout", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      matcher             = lookup(health_check.value, "matcher", null)
    }
  }

  tags = merge(
    {
      Name = var.nlb_target_group_name != "" && var.nlb_target_group_name_prefix == "" ? lower(var.nlb_target_group_name) : var.nlb_target_group_name_prefix
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
