#---------------------------------------------------
# AWS WAF size constraint set
#---------------------------------------------------
resource "aws_waf_size_constraint_set" "waf_size_constraint_set" {
  count = var.enable_waf_size_constraint_set ? 1 : 0

  name = var.waf_size_constraint_set_name != "" ? lower(var.waf_size_constraint_set_name) : "${lower(var.name)}-size-constraint-set-${lower(var.environment)}"

  dynamic "size_constraints" {
    iterator = size_constraints
    for_each = var.waf_size_constraint_set_size_constraints

    content {
      field_to_match {
        type = lookup(size_constraints.value, "type", null)
        data = lookup(size_constraints.value, "data", null)
      }

      text_transformation = lookup(size_constraints.value, "text_transformation", null)
      comparison_operator = lookup(size_constraints.value, "comparison_operator", null)
      size                = lookup(size_constraints.value, "size", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
