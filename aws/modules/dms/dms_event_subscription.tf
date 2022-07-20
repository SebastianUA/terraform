#---------------------------------------------------
# AWS dms event subscription
#---------------------------------------------------
resource "aws_dms_event_subscription" "dms_event_subscription" {
  count = var.enable_dms_event_subscription ? 1 : 0

  name          = var.dms_event_subscription_name != "" ? lower(var.dms_event_subscription_name) : "${lower(var.name)}-dms-event-subscription-${lower(var.environment)}"
  source_ids    = concat(var.dms_event_subscription_source_ids, try(aws_dms_replication_task.dms_replication_task[count.index].replication_task_id, [""]))
  sns_topic_arn = var.dms_event_subscription_sns_topic_arn

  enabled          = var.dms_event_subscription_enabled
  event_categories = var.dms_event_subscription_event_categories
  source_type      = var.dms_event_subscription_source_type

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dms_event_subscription_timeouts)) > 0 ? [var.dms_event_subscription_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.dms_event_subscription_name != "" ? lower(var.dms_event_subscription_name) : "${lower(var.name)}-dms-event-subscription-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      source_ids
    ]
  }

  depends_on = [
    aws_dms_replication_task.dms_replication_task
  ]
}