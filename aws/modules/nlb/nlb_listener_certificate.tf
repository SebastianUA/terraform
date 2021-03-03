#---------------------------------------------------
# AWS NLB listener certificate
#---------------------------------------------------
resource "aws_lb_listener_certificate" "nlb_listener_certificate" {
  count = var.enable_nlb_listener_certificate ? 1 : 0

  listener_arn    = var.nlb_listener_certificate_listener_arn != "" && !var.enable_nlb_listener ? var.nlb_listener_certificate_listener_arn : (upper(var.nlb_listener_protocol) == "HTTPS" ? aws_lb_listener.nlb_listener[0].arn : null)
  certificate_arn = var.nlb_listener_certificate_certificate_arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb_listener.nlb_listener
  ]
}
