#---------------------------------------------------
# AWS CloudWatch event rule
#---------------------------------------------------
resource "aws_cloudwatch_event_rule" "cw_event_rule" {
  count = var.enable_cw_event_rule ? 1 : 0

  name        = var.cw_event_rule_name != "" ? var.cw_event_rule_name : "${lower(var.name)}-cw_event_rule-${lower(var.environment)}"
  description = var.cw_event_rule_description != "" ? var.cw_event_rule_description : "${lower(var.name)}-cw_event_rule-${lower(var.environment)}"
  is_enabled  = var.is_enabled_for_event_rule

  event_pattern = var.cw_event_rule_event_pattern

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
