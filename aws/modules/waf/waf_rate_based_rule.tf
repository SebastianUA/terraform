#---------------------------------------------------
# AWS WAF rate based rule
#---------------------------------------------------
resource "aws_waf_rate_based_rule" "waf_rate_based_rule" {
    count       = var.enable_waf_rate_based_rule ? 1 : 0

    name        = var.waf_rate_based_rule_name != "" ? lower(var.waf_rate_based_rule_name) : "${lower(var.name)}-rate-based-rule-${lower(var.environment)}"
    metric_name = var.waf_rate_based_rule_metric_name

    rate_key    = upper(var.waf_rate_based_rule_rate_key)
    rate_limit  = var.waf_rate_based_rule_rate_limit

    dynamic "predicates" {
        for_each = var.waf_rate_based_rule_predicates
        content {
            data_id = lookup(waf_rate_based_rule_predicates.value, "data_id", element(concat(aws_waf_ipset.waf_ipset.*.id, [""]), 0))
            negated = lookup(waf_rate_based_rule_predicates.value, "negated", null)
            type    = lookup(waf_rate_based_rule_predicates.value, "type", null)
        }
    }

    tags = merge(
        {
            "Name"          = var.waf_rate_based_rule_name != "" ? lower(var.waf_rate_based_rule_name) : "${lower(var.name)}-rate-based-rule-${lower(var.environment)}"
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
        aws_waf_ipset.waf_ipset
    ]
}
