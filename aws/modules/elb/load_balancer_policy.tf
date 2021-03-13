#---------------------------------------------------
# AWS load balancer policy
#---------------------------------------------------
resource "aws_load_balancer_policy" "load_balancer_policy" {
  count = var.enable_load_balancer_policy ? 1 : 0

  load_balancer_name = var.load_balancer_policy_load_balancer_name != "" ? var.load_balancer_policy_load_balancer_name : aws_elb.elb[0].name
  policy_name        = var.load_balancer_policy_policy_name != "" ? var.load_balancer_policy_policy_name : "${lower(var.name)}-load-balancer-policy-${lower(var.environment)}"
  policy_type_name   = var.load_balancer_policy_policy_type_name

  dynamic "policy_attribute" {
    iterator = policy_attribute
    for_each = var.load_balancer_policy_policy_attribute

    content {
      name  = lookup(policy_attribute.value, "name", null)
      value = lookup(policy_attribute.value, "value", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elb.elb
  ]
}