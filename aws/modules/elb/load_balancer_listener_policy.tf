#---------------------------------------------------
# AWS load balancer listener policy
#---------------------------------------------------
resource "aws_load_balancer_listener_policy" "load_balancer_listener_policy" {
  count = var.enable_load_balancer_listener_policy ? 1 : 0

  load_balancer_name = var.load_balancer_listener_policy_load_balancer_name != "" ? var.load_balancer_listener_policy_load_balancer_name : (var.enable_elb ? aws_elb.elb[0].name : null)
  load_balancer_port = var.load_balancer_listener_policy_load_balancer_port
  policy_names       = coalescelist(var.load_balancer_listener_policy_policy_names, aws_load_balancer_policy.load_balancer_policy[0].policy_name)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elb.elb,
    aws_load_balancer_policy.load_balancer_policy
  ]
}