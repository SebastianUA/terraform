#---------------------------------------------------
# AWS CloudWatch event rule
#---------------------------------------------------
resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  count = var.enable_cloudwatch_event_rule ? 1 : 0

  name        = var.cloudwatch_event_rule_name != null ? var.cloudwatch_event_rule_name : (var.cloudwatch_event_rule_name_prefix != null ? null : "${lower(var.name)}-cw-event-rule-${lower(var.environment)}")
  name_prefix = var.cloudwatch_event_rule_name_prefix != null ? var.cloudwatch_event_rule_name_prefix : (var.cloudwatch_event_rule_name != null ? null : var.cloudwatch_event_rule_name_prefix)
  description = var.cloudwatch_event_rule_description

  schedule_expression = var.cloudwatch_event_rule_schedule_expression
  event_bus_name      = var.cloudwatch_event_rule_event_bus_name
  event_pattern       = var.cloudwatch_event_rule_event_pattern
  role_arn            = var.cloudwatch_event_rule_role_arn
  is_enabled          = var.cloudwatch_event_rule_is_enabled

  tags = merge(
    {
      Name = var.cloudwatch_event_rule_name != null ? var.cloudwatch_event_rule_name : (var.cloudwatch_event_rule_name_prefix != null ? var.cloudwatch_event_rule_name_prefix : "${lower(var.name)}-cw-event-rule-${lower(var.environment)}")
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}