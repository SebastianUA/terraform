#---------------------------------------------------
# AWS WAF rule group
#---------------------------------------------------
resource "aws_waf_rule_group" "waf_rule_group" {
    count           = var.enable_waf_rule_group ? 1 : 0

    name            = var.waf_rule_group_name != "" ? lower(var.waf_rule_group_name) : "${lower(var.name)}-waf-rule-group-${lower(var.environment)}"
    metric_name     = var.waf_rule_group_metric_name

    activated_rule {
        action {
            type = upper(var.activated_rule_action_type)
        }

        priority = var.activated_rule_priority
        rule_id  = var.activated_rule_rule_id != "" ? var.activated_rule_rule_id : element(concat(aws_waf_rule.waf_rule.*.id, [""]), 0)
        type     = upper(var.activated_rule_type)
    }

    tags = merge(
        {
            "Name"          = var.waf_rule_group_name != "" ? lower(var.waf_rule_group_name) : "${lower(var.name)}-waf-rule-group-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = [
        aws_waf_rule.waf_rule
    ]
}
