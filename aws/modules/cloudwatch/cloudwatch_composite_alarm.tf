#---------------------------------------------------
# Cloudwatch composite alarm
#---------------------------------------------------
resource "aws_cloudwatch_composite_alarm" "cw_composite_alarm" {
  count = var.enable_cw_composite_alarm ? 1 : 0

  alarm_name = var.cw_composite_alarm_name != "" ? var.cw_composite_alarm_name : "${lower(var.name)}-cw-composite-alarm-${lower(var.environment)}"
  alarm_rule = var.cw_composite_alarm_rule

  actions_enabled           = var.cw_composite_alarm_actions_enabled
  alarm_description         = var.cw_composite_alarm_description
  alarm_actions             = var.cw_composite_alarm_actions
  ok_actions                = var.cw_composite_alarm_ok_actions
  insufficient_data_actions = var.cw_composite_alarm_insufficient_data_actions

  tags = merge(
    {
      Name = var.cw_composite_alarm_name != "" ? var.cw_composite_alarm_name : "${lower(var.name)}-cw-composite-alarm-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}