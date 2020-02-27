#---------------------------------------------------
# AWS WAF geo match set
#---------------------------------------------------
resource "aws_waf_geo_match_set" "waf_geo_match_set" {
    count           = var.enable_waf_geo_match_set ? 1 : 0

    name            = var.waf_geo_match_set_name != "" ? lower(var.waf_geo_match_set_name) : "${lower(var.name)}-geo-match-set-${lower(var.environment)}"

    dynamic "geo_match_constraint" {
        for_each = var.waf_geo_match_set_geo_match_constraint
        content {
            type  = lookup(waf_geo_match_set_geo_match_constraint.value, "type", null)
            value = lookup(waf_geo_match_set_geo_match_constraint.value, "value", null)
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}
