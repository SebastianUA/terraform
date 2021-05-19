#---------------------------------------------------
# AWS WAF regex match set
#---------------------------------------------------
resource "aws_waf_regex_match_set" "waf_regex_match_set" {
  count = var.enable_waf_regex_match_set ? 1 : 0

  name = var.waf_regex_match_set_name != "" ? lower(var.waf_regex_match_set_name) : "${lower(var.name)}-regex-match-set-${lower(var.environment)}"

  dynamic "regex_match_tuple" {
    iterator = regex_match_tuple
    for_each = var.waf_regex_match_set_regex_match_tuple

    content {
      field_to_match {
        data = lookup(regex_match_tuple.value, "data", null)
        type = lookup(regex_match_tuple.value, "type", null)
      }

      regex_pattern_set_id = lookup(regex_match_tuple.value, "regex_pattern_set_id", element(concat(aws_waf_regex_pattern_set.waf_regex_pattern_set.*.id, [""]), 0))
      text_transformation  = lookup(regex_match_tuple.value, "text_transformation", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_waf_regex_pattern_set.waf_regex_pattern_set
  ]
}
