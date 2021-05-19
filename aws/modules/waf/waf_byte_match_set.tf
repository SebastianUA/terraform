#---------------------------------------------------
# AWS WAF byte match set
#---------------------------------------------------
resource "aws_waf_byte_match_set" "waf_byte_match_set" {
  count = var.enable_waf_byte_match_set ? 1 : 0

  name = var.waf_byte_match_set_name != "" ? lower(var.waf_byte_match_set_name) : "${lower(var.name)}-byte-match-set-${lower(var.environment)}"

  dynamic "byte_match_tuples" {
    iterator = byte_match_tuples
    for_each = var.waf_byte_match_set_byte_match_tuples

    content {
      text_transformation   = lookup(byte_match_tuples.value, "text_transformation", null)
      target_string         = lookup(byte_match_tuples.value, "target_string", null)
      positional_constraint = lookup(byte_match_tuples.value, "positional_constraint", null)

      field_to_match {
        type = lookup(byte_match_tuples.value, "type", null)
        data = lookup(byte_match_tuples.value, "data", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
