#---------------------------------------------------
# AWS WAF web acl
#---------------------------------------------------
resource "aws_waf_web_acl" "waf_web_acl" {
  count = var.enable_waf_web_acl ? 1 : 0

  name        = var.waf_web_acl_name != "" ? lower(var.waf_web_acl_name) : "${lower(var.name)}-waf-web-acl-${lower(var.environment)}"
  metric_name = var.waf_web_acl_metric_name

  default_action {
    type = upper(var.waf_web_acl_default_action_type)
  }

  rules {
    action {
      type = var.waf_web_acl_rules_action_type
    }

    override_action {
      type = var.waf_web_acl_rules_override_action_type
    }

    priority = var.waf_web_acl_rules_priority
    rule_id  = var.waf_web_acl_rules_rule_id != "" ? var.waf_web_acl_rules_rule_id : element(concat(aws_waf_rule.waf_rule.*.id, [""]), 0)
    type     = upper(var.waf_web_acl_rules_type)
  }

  logging_configuration {
    log_destination = var.logging_configuration_log_destination

    redacted_fields {
      field_to_match {
        type = upper(var.logging_configuration_redacted_fields_field_to_match_type)
        data = var.logging_configuration_redacted_fields_field_to_match_data
      }
    }
  }

  tags = merge(
    {
      "Name" = var.waf_web_acl_name != "" ? lower(var.waf_web_acl_name) : "${lower(var.name)}-waf-web-acl-${lower(var.environment)}"
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
