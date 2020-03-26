#---------------------------------------------------
# AWS WAF rule
#---------------------------------------------------
resource "aws_waf_rule" "waf_rule" {
    count       = var.enable_waf_rule ? 1 : 0

    name        = var.waf_rule_name != "" ? lower(var.waf_rule_name) : "${lower(var.name)}-${var.waf_rule_metric_name}-rule-${lower(var.environment)}"
    metric_name = var.waf_rule_metric_name

    dynamic "predicates" {
        for_each = var.waf_rule_predicates
        content {
            data_id = lookup(waf_rule_predicates.value, "data_id", element(concat(aws_waf_ipset.waf_ipset.*.id, [""]), 0))
            negated = lookup(waf_rule_predicates.value, "negated", null)
            type    = lookup(waf_rule_predicates.value, "type", null)
        }
    }

    tags        = merge(
        {
            "Name"  = var.waf_rule_name != "" ? lower(var.waf_rule_name) : "${lower(var.name)}-${var.waf_rule_metric_name}-rule-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = [
        aws_waf_ipset.waf_ipset
    ]
}
