#---------------------------------------------------
# AWS LB target group
#---------------------------------------------------
resource "aws_lb_target_group" "alb_target_group" {
  count = var.enable_alb_target_group ? 1 : 0

  name        = var.alb_target_group_name != "" ? var.alb_target_group_name : (var.alb_target_group_name_prefix == null ? "${lower(var.name)}-alb-tg-${lower(var.environment)}" : null)
  name_prefix = var.alb_target_group_name_prefix != null ? (var.alb_target_group_name == "" ? var.alb_target_group_name_prefix : null) : null

  port                 = var.alb_target_group_port
  protocol             = upper(var.alb_target_group_protocol)
  vpc_id               = var.alb_target_group_vpc_id
  target_type          = var.alb_target_group_target_type
  deregistration_delay = var.alb_target_group_deregistration_delay
  slow_start           = var.alb_target_group_slow_start

  dynamic "health_check" {
    iterator = health_check
    for_each = var.alb_target_group_health_check

    content {
      enabled             = lookup(health_check.value, "enabled", null)
      interval            = lookup(health_check.value, "interval", null)
      path                = lookup(health_check.value, "path", null)
      port                = lookup(health_check.value, "port", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      timeout             = lookup(health_check.value, "timeout", null)
      protocol            = lookup(health_check.value, "protocol", null)
      matcher             = lookup(health_check.value, "matcher", null)
    }
  }

  dynamic "stickiness" {
    iterator = stickiness
    for_each = var.alb_target_group_stickiness

    content {
      type            = lookup(stickiness.value, "type", null)
      cookie_duration = lookup(stickiness.value, "cookie_duration", null)
      enabled         = lookup(stickiness.value, "enabled", null)
    }
  }

  tags = merge(
    {
      Name = var.alb_target_group_name != "" ? var.alb_target_group_name : (var.alb_target_group_name_prefix == null ? "${lower(var.name)}-alb-tg-${lower(var.environment)}" : var.alb_target_group_name_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
