#---------------------------------------------------
# AWS codestarnotifications notification rule
#---------------------------------------------------
resource "aws_codestarnotifications_notification_rule" "codestarnotifications_notification_rule" {
  count = var.enable_codestarnotifications_notification_rule ? 1 : 0

  name           = var.codestarnotifications_notification_rule_name != "" ? lower(var.codestarnotifications_notification_rule_name) : "${lower(var.name)}-codestarnotifications-rule-${lower(var.environment)}"
  resource       = var.codestarnotifications_notification_rule_resource
  detail_type    = upper(var.codestarnotifications_notification_rule_detail_type)
  event_type_ids = var.codestarnotifications_notification_rule_event_type_ids

  status = upper(var.codestarnotifications_notification_rule_status)

  dynamic "target" {
    iterator = target
    for_each = var.codestarnotifications_notification_rule_target
    content {
      address = aws_sns_topic.notif.arn
      type    = lookup(target.value, "type", null)
    }
  }

  tags = merge(
    {
      Name = var.codestarnotifications_notification_rule_name != "" ? lower(var.codestarnotifications_notification_rule_name) : "${lower(var.name)}-codestarnotifications-rule-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
