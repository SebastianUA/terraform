#---------------------------------------------------
# AWS ELB lb ssl negotiation policy
#---------------------------------------------------
resource "aws_lb_ssl_negotiation_policy" "lb_ssl_negotiation_policy" {
  count = var.enable_lb_ssl_negotiation_policy ? 1 : 0

  name          = var.lb_ssl_negotiation_policy_name != "" ? var.lb_ssl_negotiation_policy_name : "${lower(var.name)}-lb-ssl-negotiation-policy-${lower(var.environment)}"
  load_balancer = var.lb_ssl_negotiation_policy_load_balancer != "" ? var.lb_ssl_negotiation_policy_load_balancer : (var.enable_elb ? aws_elb.elb[0].id : null)
  lb_port       = var.lb_ssl_negotiation_policy_lb_port

  dynamic "attribute" {
    iterator = attribute
    for_each = var.lb_ssl_negotiation_policy_attribute

    content {
      name  = lookup(attribute.value, "name", null)
      value = lookup(attribute.value, "value", null)
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