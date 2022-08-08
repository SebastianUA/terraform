#---------------------------------------------------
# AWS dms event subscription
#---------------------------------------------------
resource "aws_dms_event_subscription" "dms_event_subscription" {
  for_each = { for k, v in var.dms_event_subscriptions : k => v if var.enable_dms_event_subscription }

  name          = lookup(each.value, "name", "${lower(var.name)}-dms-event-subscription-${lower(var.environment)}-${each.key + 1}")
  source_ids    = concat(lookup(each.value, "source_ids", []), try(aws_dms_replication_task.dms_replication_task.*.replication_task_id, [""]))
  sns_topic_arn = lookup(each.value, "sns_topic_arn", null)

  enabled          = lookup(each.value, "enabled", null)
  event_categories = lookup(each.value, "event_categories", null)
  source_type      = lookup(each.value, "source_type", null)

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
      Name = lookup(each.value, "name", "${lower(var.name)}-dms-event-subscription-${lower(var.environment)}-${each.key + 1}")
    },
    var.tags,
    lookup(each.value, "tags", {})
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