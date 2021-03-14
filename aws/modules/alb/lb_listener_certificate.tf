#---------------------------------------------------
# AWS LB listener certificate
#---------------------------------------------------
resource "aws_lb_listener_certificate" "alb_listener_certificate" {
  count = var.enable_alb_listener_certificate ? 1 : 0

  listener_arn    = var.alb_listener_certificate_listener_arn != "" && ! var.enable_alb_listener ? var.alb_listener_certificate_listener_arn : (upper(var.alb_listener_protocol) == "HTTPS" ? aws_lb_listener.alb_listener[0].arn : null)
  certificate_arn = var.alb_listener_certificate_certificate_arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb_listener.alb_listener
  ]
}
