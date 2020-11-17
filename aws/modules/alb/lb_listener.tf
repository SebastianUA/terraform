#---------------------------------------------------
# AWS LB listeners
#---------------------------------------------------
resource "aws_lb_listener" "frontend_http" {
  count = var.enable_alb && ! var.enable_alb_prefix && trimspace(element(split(",", var.alb_protocols), 1)) == "HTTP" || trimspace(element(split(",", var.alb_protocols), 2)) == "HTTP" ? 1 : 0

  load_balancer_arn = element(aws_lb.alb.*.arn, 0)
  port              = var.frontend_http_port
  protocol          = var.frontend_http_protocol

  default_action {
    target_group_arn = element(aws_lb_target_group.alb_target_group.*.arn, 0)
    type             = var.frontend_http_default_action_type
    #redirect            = ""
    #fixed_response      = ""
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb.alb,
    aws_lb_target_group_attachment.alb_target_group_attachment,
    aws_lb_target_group.alb_target_group
  ]
}

resource "aws_lb_listener" "frontend_https" {
  count = var.enable_alb && ! var.enable_alb_prefix && trimspace(element(split(",", var.alb_protocols), 1)) == "HTTPS" || trimspace(element(split(",", var.alb_protocols), 2)) == "HTTPS" ? 1 : 0

  load_balancer_arn = element(aws_lb.alb.*.arn, 0)
  port              = var.frontend_https_port
  protocol          = var.frontend_https_protocol
  certificate_arn   = var.certificate_arn
  ssl_policy        = var.ssl_policy

  default_action {
    target_group_arn = element(aws_lb_target_group.alb_target_group.*.arn, 0)
    type             = var.frontend_https_default_action_type
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb.alb,
    aws_lb_target_group_attachment.alb_target_group_attachment,
    aws_lb_target_group.alb_target_group
  ]
}

resource "aws_lb_listener" "frontend_http_prefix" {
  count = var.enable_alb && var.enable_alb_prefix && trimspace(element(split(",", var.alb_protocols), 1)) == "HTTP" || trimspace(element(split(",", var.alb_protocols), 2)) == "HTTPS" ? 1 : 0

  load_balancer_arn = element(aws_lb.alb_prefix.*.arn, 0)
  port              = var.frontend_http_port
  protocol          = var.frontend_http_protocol

  default_action {
    target_group_arn = element(aws_lb_target_group.alb_target_group_prefix.*.arn, 0)
    type             = var.frontend_http_default_action_type
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb.alb_prefix,
    aws_lb_target_group_attachment.alb_target_group_attachment_prefix,
    aws_lb_target_group.alb_target_group_prefix
  ]
}

resource "aws_lb_listener" "frontend_https_prefix" {
  count = var.enable_alb && var.enable_alb_prefix && trimspace(element(split(",", var.alb_protocols), 1)) == "HTTPS" || trimspace(element(split(",", var.alb_protocols), 2)) == "HTTPS" ? 1 : 0

  load_balancer_arn = element(aws_lb.alb_prefix.*.arn, 0)
  port              = var.frontend_https_port
  protocol          = var.frontend_https_protocol
  certificate_arn   = var.certificate_arn
  ssl_policy        = var.ssl_policy

  default_action {
    target_group_arn = element(aws_lb_target_group.alb_target_group_prefix.*.arn, 0)
    type             = var.frontend_https_default_action_type
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb.alb_prefix,
    aws_lb_target_group_attachment.alb_target_group_attachment_prefix,
    aws_lb_target_group.alb_target_group_prefix
  ]
}
