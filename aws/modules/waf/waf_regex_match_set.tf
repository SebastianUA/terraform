#---------------------------------------------------
# AWS WAF regex match set
#---------------------------------------------------
resource "aws_waf_regex_match_set" "waf_regex_match_set" {
  count = var.enable_waf_regex_match_set ? 1 : 0

  name = var.waf_regex_match_set_name != "" ? lower(var.waf_regex_match_set_name) : "${lower(var.name)}-regex-match-set-${lower(var.environment)}"

  regex_match_tuple {
    field_to_match {
      data = var.regex_match_tuple_field_to_match_data
      type = upper(var.regex_match_tuple_field_to_match_type)
    }

    regex_pattern_set_id = var.regex_match_tuple_regex_pattern_set_id != "" ? var.regex_match_tuple_regex_pattern_set_id : element(concat(aws_waf_regex_pattern_set.waf_regex_pattern_set.*.id, [""]), 0)
    text_transformation  = upper(var.regex_match_tuple_text_transformation)
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_waf_regex_pattern_set.waf_regex_pattern_set
  ]
}
