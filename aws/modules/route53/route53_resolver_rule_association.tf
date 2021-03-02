#---------------------------------------------------
# AWS route53 resolver rule association
#---------------------------------------------------
resource "aws_route53_resolver_rule_association" "route53_resolver_rule_association" {
  count = var.enable_route53_resolver_rule_association ? 1 : 0

  name             = var.route53_resolver_rule_association_name != "" ? lower(var.route53_resolver_rule_association_name) : "${lower(var.name)}-route53-resolve-rule-association-${lower(var.environment)}"
  resolver_rule_id = var.route53_resolver_rule_association_resolver_rule_id != "" ? var.route53_resolver_rule_association_resolver_rule_id : element(concat(aws_route53_resolver_rule.route53_resolver_rule.*.id, [""]), 0)
  vpc_id           = var.route53_resolver_rule_association_vpc_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route53_resolver_rule.route53_resolver_rule
  ]
}
