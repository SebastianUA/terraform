#---------------------------------------------------
# AWS WAF web acl
#---------------------------------------------------
resource "aws_waf_web_acl" "waf_web_acl" {
  count = var.enable_waf_web_acl ? 1 : 0

  name        = var.waf_web_acl_name != "" ? lower(var.waf_web_acl_name) : "${lower(var.name)}-waf-web-acl-${lower(var.environment)}"
  metric_name = var.waf_web_acl_metric_name

  dynamic "default_action" {
    iterator = default_action
    for_each = var.waf_web_acl_default_action
    content {
      type = lookup(default_action.value, "type", null)
    }
  }

  dynamic "rules" {
    iterator = rules
    for_each = var.waf_web_acl_rules
    content {
      action {
        type = lookup(rules.value, "action_type", null)
      }

      override_action {
        type = lookup(rules.value, "override_action_type", null)
      }

      priority = lookup(rules.value, "priority", null)
      rule_id  = lookup(rules.value, "priority", element(concat(aws_waf_rule.waf_rule.*.id, [""]), 0))
      type     = lookup(rules.value, "type", null)
    }
  }

  dynamic "logging_configuration" {
    iterator = logging_configuration
    for_each = var.waf_web_acl_logging_configuration
    content {
      log_destination = lookup(logging_configuration.value, "log_destination", null)

      redacted_fields {
        field_to_match {
          type = lookup(logging_configuration.value, "type", null)
          data = lookup(logging_configuration.value, "data", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.waf_web_acl_name != "" ? lower(var.waf_web_acl_name) : "${lower(var.name)}-waf-web-acl-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_waf_ipset.waf_ipset,
    aws_waf_rule.waf_rule
  ]
}
