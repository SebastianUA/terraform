#---------------------------------------------------
# AWS WAF xss match set
#---------------------------------------------------
resource "aws_waf_xss_match_set" "waf_xss_match_set" {
  count = var.enable_waf_xss_match_set ? 1 : 0

  name = var.waf_xss_match_set_name != "" ? lower(var.waf_xss_match_set_name) : "${lower(var.name)}-xss-match-set-${lower(var.environment)}"

  dynamic "xss_match_tuples" {
    iterator = xss_match_tuples
    for_each = var.waf_xss_match_set_xss_match_tuples

    content {
      text_transformation = lookup(xss_match_tuples.value, "text_transformation", null)

      field_to_match {
        type = lookup(xss_match_tuples.value, "type", null)
        data = lookup(xss_match_tuples.value, "data", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
