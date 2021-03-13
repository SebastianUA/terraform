#---------------------------------------------------
# AWS ELB app cookie stickiness policy
#---------------------------------------------------
resource "aws_app_cookie_stickiness_policy" "app_cookie_stickiness_policy" {
  count = var.enable_app_cookie_stickiness_policy ? length(var.app_cookie_stickiness_policy_stack) : 0

  name          = lookup(var.app_cookie_stickiness_policy_stack[count.index], "name", "${lower(var.name)}-app-cookie-stickiness-policy-${lower(var.environment)}")
  load_balancer = lookup(var.app_cookie_stickiness_policy_stack[count.index], "load_balancer", (var.enable_elb ? aws_elb.elb[0].id : null))
  lb_port       = lookup(var.app_cookie_stickiness_policy_stack[count.index], "lb_port", null)
  cookie_name   = lookup(var.app_cookie_stickiness_policy_stack[count.index], "cookie_name", null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elb.elb
  ]
}