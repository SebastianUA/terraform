#---------------------------------------------------
# AWS LB target group
#---------------------------------------------------
resource "aws_lb_target_group" "alb_target_group" {
  count = var.enable_alb_target_group && ! var.enable_alb_target_group_prefix ? 1 : 0

  name                 = var.alb_target_group_name != "" ? lower(var.alb_target_group_name) : "${lower(var.name)}-alb-tg-${lower(var.environment)}"
  port                 = var.backend_port
  protocol             = upper(var.backend_protocol)
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  tags = merge(
    {
      "Name" = var.alb_target_group_name != "" ? lower(var.alb_target_group_name) : "${lower(var.name)}-alb-tg-${lower(var.environment)}"
    },
    var.tags
  )

  health_check {
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.health_check_port
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    protocol            = var.backend_protocol
    matcher             = var.health_check_matcher
  }

  stickiness {
    type            = var.stickiness_type
    cookie_duration = var.stickiness_cookie_duration
    enabled         = var.stickiness_cookie_duration != 1 ? true : false
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb.alb
  ]
}

resource "aws_lb_target_group" "alb_target_group_prefix" {
  count = var.enable_alb_target_group && var.enable_alb_target_group_prefix ? 1 : 0

  name_prefix          = var.tg_name_prefix != "" ? lower(var.tg_name_prefix) : "alb-"
  port                 = var.backend_port
  protocol             = upper(var.backend_protocol)
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  tags = merge(
    {
      "Name" = var.tg_name_prefix != "" ? lower(var.tg_name_prefix) : "alb-"
    },
    var.tags
  )

  health_check {
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.health_check_port
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    protocol            = var.backend_protocol
    matcher             = var.health_check_matcher
  }

  stickiness {
    type            = var.stickiness_type
    cookie_duration = var.stickiness_cookie_duration
    enabled         = var.stickiness_cookie_duration != 1 ? true : false
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb.alb_prefix
  ]
}
