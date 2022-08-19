#---------------------------------------------------
# AWS CloudWatch event target
#---------------------------------------------------
resource "aws_cloudwatch_event_target" "cw_event_target" {
  count = var.enbale_cw_event_target ? 1 : 0

  rule      = var.cw_event_rule_name != "" ? var.cw_event_rule_name : element(concat(aws_cloudwatch_event_rule.cw_event_rule.*.name, [""]), 0)
  target_id = var.cw_event_target_target_id
  arn       = var.cw_event_target_arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
