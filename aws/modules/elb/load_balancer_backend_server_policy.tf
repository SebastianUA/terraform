#---------------------------------------------------
# AWS load balancer backend server policy
#---------------------------------------------------
resource "aws_load_balancer_backend_server_policy" "load_balancer_backend_server_policy" {
  count = var.enable_load_balancer_backend_server_policy ? 1 : 0

  load_balancer_name = var.load_balancer_backend_server_policy_load_balancer_name != "" ? var.load_balancer_backend_server_policy_load_balancer_name : (var.enable_elb ? aws_elb.elb[0].name : null)
  instance_port      = var.load_balancer_backend_server_policy_instance_port
  policy_names       = coalescelist(var.load_balancer_backend_server_policy_policy_names, aws_load_balancer_policy.load_balancer_policy[0].policy_name)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elb.elb,
    aws_load_balancer_policy.load_balancer_policy
  ]
}