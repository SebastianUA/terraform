#---------------------------------------------------
# AWS Route53 resolver rule
#---------------------------------------------------
resource "aws_route53_resolver_rule" "route53_resolver_rule" {
  count = var.enable_route53_resolver_rule ? 1 : 0

  domain_name = var.route53_resolver_rule_domain_name
  rule_type   = var.route53_resolver_rule_rule_type

  name                 = var.route53_resolver_rule_name != "" ? lower(var.route53_resolver_rule_name) : "${lower(var.name)}-route53-resolve-rule-${lower(var.environment)}"
  resolver_endpoint_id = var.route53_resolver_rule_resolver_endpoint_id != "" ? var.route53_resolver_rule_resolver_endpoint_id : element(concat(aws_route53_resolver_endpoint.route53_resolver_endpoint.*.id, [""]), 0)

  dynamic "target_ip" {
    iterator = target_ip
    for_each = var.route53_resolver_rule_target_ip

    content {
      ip = lookup(target_ip.value, "ip", null)

      port = lookup(target_ip.value, "port", null)
    }
  }

  tags = merge(
    {
      Name = var.route53_resolver_rule_name != "" ? lower(var.route53_resolver_rule_name) : "${lower(var.name)}-route53-resolve-rule-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route53_resolver_endpoint.route53_resolver_endpoint
  ]
}
