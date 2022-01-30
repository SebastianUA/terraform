#---------------------------------------------------
# AWS DB event subscription
#---------------------------------------------------
resource "aws_db_event_subscription" "db_event_subscription" {
  count = var.enable_db_event_subscription ? 1 : 0

  name        = var.db_event_subscription_name != "" && var.db_event_subscription_name_prefix == "" ? lower(var.db_event_subscription_name) : null
  name_prefix = var.db_event_subscription_name_prefix != "" && var.db_event_subscription_name == "" ? lower(var.db_event_subscription_name_prefix) : null
  sns_topic   = var.db_event_subscription_sns_topic

  source_type      = var.db_event_subscription_source_type
  source_ids       = var.db_event_subscription_source_ids
  enabled          = var.db_event_subscription_enabled
  event_categories = var.db_event_subscription_event_categories

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.db_event_subscription_timeouts)) > 0 ? [var.db_event_subscription_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.db_event_subscription_name != "" && var.db_event_subscription_name_prefix == "" ? lower(var.db_event_subscription_name) : lower(var.db_event_subscription_name_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
