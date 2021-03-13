#---------------------------------------------------
# AWS ELB lb cookie stickiness policy
#---------------------------------------------------
resource "aws_lb_cookie_stickiness_policy" "lb_cookie_stickiness_policy" {
  count = var.enable_lb_cookie_stickiness_policy ? length(var.lb_cookie_stickiness_policy_stack) : 0

  name                     = lookup(var.lb_cookie_stickiness_policy_stack[count.index], "name", "${lower(var.name)}-lb-cookie-stickiness-policy-${lower(var.environment)}")
  load_balancer            = lookup(var.lb_cookie_stickiness_policy_stack[count.index], "load_balancer", (var.enable_elb ? aws_elb.elb[0].id : null))
  lb_port                  = lookup(var.lb_cookie_stickiness_policy_stack[count.index], "lb_port", null)
  cookie_expiration_period = lookup(var.lb_cookie_stickiness_policy_stack[count.index], "cookie_expiration_period", null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elb.elb
  ]
}