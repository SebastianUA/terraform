#---------------------------------------------------
# AWS ELB proxy protocol policy
#---------------------------------------------------
resource "aws_proxy_protocol_policy" "proxy_protocol_policy" {
  count = var.enable_proxy_protocol_policy ? 1 : 0

  load_balancer  = var.proxy_protocol_policy_load_balancer != "" ? var.proxy_protocol_policy_load_balancer : aws_elb.elb[0].name
  instance_ports = var.proxy_protocol_policy_instance_ports

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elb.elb
  ]
}