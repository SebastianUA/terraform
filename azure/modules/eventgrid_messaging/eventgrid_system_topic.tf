#-----------------------------------------------------------
# Azure eventgrid system topic
#-----------------------------------------------------------
resource "azurerm_eventgrid_system_topic" "eventgrid_system_topic" {
  count = var.enable_eventgrid_system_topic ? 1 : 0

  name                   = var.eventgrid_system_topic_name != "" ? var.eventgrid_system_topic_name : "${lower(var.name)}-eventgrid-system-topic-${lower(var.environment)}"
  location               = var.eventgrid_system_topic_location
  resource_group_name    = var.eventgrid_system_topic_resource_group_name
  source_arm_resource_id = var.eventgrid_system_topic_source_arm_resource_id
  topic_type             = var.eventgrid_system_topic_topic_type

  dynamic "identity" {
    iterator = identity
    for_each = length(keys(var.eventgrid_system_topic_identity)) > 0 ? [var.eventgrid_system_topic_identity] : []

    content {
      type = lookup(identity.value, "type", null)

      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.eventgrid_system_topic_timeouts)) > 0 ? [var.eventgrid_system_topic_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.eventgrid_system_topic_name != "" ? var.eventgrid_system_topic_name : "${lower(var.name)}-eventgrid-system-topic-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}