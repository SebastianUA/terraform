#-----------------------------------------------------------
# Azure eventgrid topic
#-----------------------------------------------------------
resource "azurerm_eventgrid_topic" "eventgrid_topic" {
  count = var.enable_eventgrid_topic ? 1 : 0

  name                = var.eventgrid_topic_name != "" ? var.eventgrid_topic_name : "${lower(var.name)}-eventgrid-topic-${lower(var.environment)}"
  resource_group_name = var.eventgrid_topic_resource_group_name
  location            = var.eventgrid_topic_location

  input_schema                  = var.eventgrid_topic_input_schema
  public_network_access_enabled = var.eventgrid_topic_public_network_access_enabled
  local_auth_enabled            = var.eventgrid_topic_local_auth_enabled

  dynamic "identity" {
    iterator = identity
    for_each = length(keys(var.eventgrid_topic_identity)) > 0 ? [var.eventgrid_topic_identity] : []

    content {
      type = lookup(identity.value, "type", null)

      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "input_mapping_fields" {
    iterator = input_mapping_fields
    for_each = length(keys(var.eventgrid_topic_input_mapping_fields)) > 0 ? [var.eventgrid_topic_input_mapping_fields] : []

    content {
      id           = lookup(input_mapping_fields.value, "id", null)
      topic        = lookup(input_mapping_fields.value, "topic", null)
      event_type   = lookup(input_mapping_fields.value, "event_type", null)
      event_time   = lookup(input_mapping_fields.value, "event_time", null)
      data_version = lookup(input_mapping_fields.value, "data_version", null)
      subject      = lookup(input_mapping_fields.value, "subject", null)
    }
  }

  dynamic "input_mapping_default_values" {
    iterator = input_mapping_default_values
    for_each = length(keys(var.eventgrid_topic_input_mapping_default_values)) > 0 ? [var.eventgrid_topic_input_mapping_default_values] : []

    content {
      event_type   = lookup(input_mapping_default_values.value, "event_type", null)
      data_version = lookup(input_mapping_default_values.value, "data_version", null)
      subject      = lookup(input_mapping_default_values.value, "subject", null)
    }
  }

  dynamic "inbound_ip_rule" {
    iterator = inbound_ip_rule
    for_each = var.eventgrid_topic_inbound_ip_rule

    content {
      ip_mask = lookup(inbound_ip_rule.value, "ip_mask", null)

      action = lookup(inbound_ip_rule.value, "action", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.eventgrid_topic_timeouts)) > 0 ? [var.eventgrid_topic_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.eventgrid_topic_name != "" ? var.eventgrid_topic_name : "${lower(var.name)}-eventgrid-topic-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}