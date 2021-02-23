#---------------------------------------------------
# AWS WAF sql injection match set
#---------------------------------------------------
resource "aws_waf_sql_injection_match_set" "waf_sql_injection_match_set" {
  count = var.enable_waf_sql_injection_match_set ? 1 : 0

  name = var.waf_sql_injection_match_set_name != "" ? lower(var.waf_sql_injection_match_set_name) : "${lower(var.name)}-sql-injection-match-set-${lower(var.environment)}"

  dynamic "sql_injection_match_tuples" {
    iterator = sql_injection_match_tuples
    for_each = var.sql_injection_match_tuples
    content {
      text_transformation = lookup(sql_injection_match_tuples.value, "text_transformation", null)

      field_to_match {
        type = lookup(sql_injection_match_tuples.value, "type", null)
        data = lookup(sql_injection_match_tuples.value, "data", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
