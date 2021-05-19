#---------------------------------------------------
# AWS WAF rule group
#---------------------------------------------------
resource "aws_waf_rule_group" "waf_rule_group" {
  count = var.enable_waf_rule_group ? 1 : 0

  name        = var.waf_rule_group_name != "" ? lower(var.waf_rule_group_name) : "${lower(var.name)}-waf-rule-group-${lower(var.environment)}"
  metric_name = var.waf_rule_group_metric_name

  dynamic "activated_rule" {
    iterator = activated_rule
    for_each = var.waf_rule_group_activated_rule

    content {
      action {
        type = lookup(activated_rule.value, "action_type", null)
      }

      priority = lookup(activated_rule.value, "priority", null)
      rule_id  = lookup(activated_rule.value, "rule_id", element(concat(aws_waf_rule.waf_rule.*.id, [""]), 0))
      type     = lookup(activated_rule.value, "type", null)
    }
  }

  tags = merge(
    {
      Name = var.waf_rule_group_name != "" ? lower(var.waf_rule_group_name) : "${lower(var.name)}-waf-rule-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_waf_rule.waf_rule
  ]
}
