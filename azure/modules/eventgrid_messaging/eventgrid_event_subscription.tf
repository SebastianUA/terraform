#-----------------------------------------------------------
# Azure eventgrid event subscription
#-----------------------------------------------------------
resource "azurerm_eventgrid_event_subscription" "eventgrid_event_subscription" {
  count = var.enable_eventgrid_event_subscription ? 1 : 0

  name                = var.enable_eventgrid_event_subscription_name != "" ? var.enable_eventgrid_event_subscription_name : "${lower(var.name)}-eventgrid-system-topic-event-subscription-${lower(var.environment)}"
  system_topic        = var.enable_eventgrid_event_subscription_system_topic != "" ? var.enable_eventgrid_event_subscription_system_topic : (var.enable_eventgrid_system_topic ? azurerm_eventgrid_topic.eventgrid_topic[count.index].name : null)
  resource_group_name = var.enable_eventgrid_event_subscription_resource_group_name

  expiration_time_utc                  = var.enable_eventgrid_event_subscription_expiration_time_utc
  event_delivery_schema                = var.enable_eventgrid_event_subscription_event_delivery_schema
  eventhub_endpoint_id                 = var.enable_eventgrid_event_subscription_eventhub_endpoint_id
  hybrid_connection_endpoint_id        = var.enable_eventgrid_event_subscription_hybrid_connection_endpoint_id
  service_bus_queue_endpoint_id        = var.enable_eventgrid_event_subscription_service_bus_queue_endpoint_id
  service_bus_topic_endpoint_id        = var.enable_eventgrid_event_subscription_service_bus_topic_endpoint_id
  included_event_types                 = var.enable_eventgrid_event_subscription_included_event_types
  labels                               = var.enable_eventgrid_event_subscription_labels
  advanced_filtering_on_arrays_enabled = var.enable_eventgrid_event_subscription_advanced_filtering_on_arrays_enabled

  dynamic "azure_function_endpoint" {
    iterator = azure_function_endpoint
    for_each = length(keys(var.eventgrid_event_subscription_azure_function_endpoint)) > 0 ? [var.eventgrid_event_subscription_azure_function_endpoint] : []

    content {
      function_id = lookup(azure_function_endpoint.value, "function_id", null)

      max_events_per_batch              = lookup(azure_function_endpoint.value, "max_events_per_batch", null)
      preferred_batch_size_in_kilobytes = lookup(azure_function_endpoint.value, "preferred_batch_size_in_kilobytes", null)
    }
  }

  dynamic "storage_queue_endpoint" {
    iterator = storage_queue_endpoint
    for_each = length(keys(var.eventgrid_event_subscription_storage_queue_endpoint)) > 0 ? [var.eventgrid_event_subscription_storage_queue_endpoint] : []

    content {
      storage_account_id = lookup(storage_queue_endpoint.value, "storage_account_id", null)
      queue_name         = lookup(storage_queue_endpoint.value, "queue_name", null)

      queue_message_time_to_live_in_seconds = lookup(storage_queue_endpoint.value, "queue_message_time_to_live_in_seconds", null)
    }
  }

  dynamic "webhook_endpoint" {
    iterator = webhook_endpoint
    for_each = length(keys(var.eventgrid_event_subscription_webhook_endpoint)) > 0 ? [var.eventgrid_event_subscription_webhook_endpoint] : []

    content {
      url = lookup(webhook_endpoint.value, "url", null)

      base_url                          = lookup(webhook_endpoint.value, "base_url", null)
      max_events_per_batch              = lookup(webhook_endpoint.value, "max_events_per_batch", null)
      preferred_batch_size_in_kilobytes = lookup(webhook_endpoint.value, "preferred_batch_size_in_kilobytes", null)
      active_directory_tenant_id        = lookup(webhook_endpoint.value, "active_directory_tenant_id", null)
      active_directory_app_id_or_uri    = lookup(webhook_endpoint.value, "active_directory_app_id_or_uri", null)
    }
  }

  dynamic "subject_filter" {
    iterator = subject_filter
    for_each = length(keys(var.eventgrid_event_subscription_subject_filter)) > 0 ? [var.eventgrid_event_subscription_subject_filter] : []

    content {
      subject_begins_with = lookup(subject_filter.value, "subject_begins_with", null)
      subject_ends_with   = lookup(subject_filter.value, "subject_ends_with", null)
      case_sensitive      = lookup(subject_filter.value, "case_sensitive", null)
    }
  }

  dynamic "advanced_filter" {
    iterator = advanced_filter
    for_each = var.eventgrid_system_topic_event_subscription_advanced_filter

    content {
      dynamic "bool_equals" {
        iterator = bool_equals
        for_each = lookup(advanced_filter.value, "bool_equals", [])

        content {
          key   = lookup(bool_equals.value, "key", null)
          value = lookup(bool_equals.value, "value", null)
        }
      }

      dynamic "number_greater_than" {
        iterator = number_greater_than
        for_each = lookup(advanced_filter.value, "number_greater_than", [])

        content {
          key   = lookup(number_greater_than.value, "key", null)
          value = lookup(number_greater_than.value, "value", null)
        }
      }

      dynamic "number_greater_than_or_equals" {
        iterator = number_greater_than_or_equals
        for_each = lookup(advanced_filter.value, "number_greater_than_or_equals", [])

        content {
          key   = lookup(number_greater_than_or_equals.value, "key", null)
          value = lookup(number_greater_than_or_equals.value, "value", null)
        }
      }

      dynamic "number_less_than" {
        iterator = number_less_than
        for_each = lookup(advanced_filter.value, "number_less_than", [])

        content {
          key   = lookup(number_less_than.value, "key", null)
          value = lookup(number_less_than.value, "value", null)
        }
      }

      dynamic "number_less_than_or_equals" {
        iterator = number_less_than_or_equals
        for_each = lookup(advanced_filter.value, "number_less_than_or_equals", [])

        content {
          key   = lookup(number_less_than_or_equals.value, "key", null)
          value = lookup(number_less_than_or_equals.value, "value", null)
        }
      }

      dynamic "number_in" {
        iterator = number_in
        for_each = lookup(advanced_filter.value, "number_in", [])

        content {
          key   = lookup(number_in.value, "key", null)
          value = lookup(number_in.value, "value", null)
        }
      }

      dynamic "number_not_in" {
        iterator = number_not_in
        for_each = lookup(advanced_filter.value, "number_not_in", [])

        content {
          key   = lookup(number_not_in.value, "key", null)
          value = lookup(number_not_in.value, "value", null)
        }
      }

      dynamic "number_in_range" {
        iterator = number_in_range
        for_each = lookup(advanced_filter.value, "number_in_range", [])

        content {
          key   = lookup(number_in_range.value, "key", null)
          value = lookup(number_in_range.value, "value", null)
        }
      }

      dynamic "number_not_in_range" {
        iterator = number_not_in_range
        for_each = lookup(advanced_filter.value, "number_not_in_range", [])

        content {
          key   = lookup(number_not_in_range.value, "key", null)
          value = lookup(number_not_in_range.value, "value", null)
        }
      }

      dynamic "string_begins_with" {
        iterator = string_begins_with
        for_each = lookup(advanced_filter.value, "string_begins_with", [])

        content {
          key   = lookup(string_begins_with.value, "key", null)
          value = lookup(string_begins_with.value, "value", null)
        }
      }

      dynamic "string_not_begins_with" {
        iterator = string_not_begins_with
        for_each = lookup(advanced_filter.value, "string_not_begins_with", [])

        content {
          key   = lookup(string_not_begins_with.value, "key", null)
          value = lookup(string_not_begins_with.value, "value", null)
        }
      }

      dynamic "string_ends_with" {
        iterator = string_ends_with
        for_each = lookup(advanced_filter.value, "string_ends_with", [])

        content {
          key   = lookup(string_ends_with.value, "key", null)
          value = lookup(string_ends_with.value, "value", null)
        }
      }

      dynamic "string_not_ends_with" {
        iterator = string_not_ends_with
        for_each = lookup(advanced_filter.value, "string_not_ends_with", [])

        content {
          key   = lookup(string_not_ends_with.value, "key", null)
          value = lookup(string_not_ends_with.value, "value", null)
        }
      }

      dynamic "string_contains" {
        iterator = string_contains
        for_each = lookup(advanced_filter.value, "string_contains", [])

        content {
          key   = lookup(string_contains.value, "key", null)
          value = lookup(string_contains.value, "value", null)
        }
      }

      dynamic "string_not_contains" {
        iterator = string_not_contains
        for_each = lookup(advanced_filter.value, "string_not_contains", [])

        content {
          key   = lookup(string_not_contains.value, "key", null)
          value = lookup(string_not_contains.value, "value", null)
        }
      }

      dynamic "string_in" {
        iterator = string_in
        for_each = lookup(advanced_filter.value, "string_in", [])

        content {
          key   = lookup(string_in.value, "key", null)
          value = lookup(string_in.value, "value", null)
        }
      }

      dynamic "string_not_in" {
        iterator = string_not_in
        for_each = lookup(advanced_filter.value, "string_not_in", [])

        content {
          key   = lookup(string_not_in.value, "key", null)
          value = lookup(string_not_in.value, "value", null)
        }
      }

      dynamic "is_not_null" {
        iterator = is_not_null
        for_each = lookup(advanced_filter.value, "is_not_null", [])

        content {
          key   = lookup(is_not_null.value, "key", null)
          value = lookup(is_not_null.value, "value", null)
        }
      }

      dynamic "is_null_or_undefined" {
        iterator = is_null_or_undefined
        for_each = lookup(advanced_filter.value, "is_null_or_undefined", [])

        content {
          key   = lookup(is_null_or_undefined.value, "key", null)
          value = lookup(is_null_or_undefined.value, "value", null)
        }
      }
    }
  }

  dynamic "delivery_identity" {
    iterator = delivery_identity
    for_each = var.eventgrid_event_subscription_delivery_identity

    content {
      type = lookup(delivery_identity.value, "type", null)

      user_assigned_identity = lookup(delivery_identity.value, "user_assigned_identity", null)
    }
  }

  dynamic "delivery_property" {
    iterator = delivery_property
    for_each = var.eventgrid_event_subscription_delivery_property

    content {
      header_name = lookup(delivery_property.value, "header_name", null)
      type        = lookup(delivery_property.value, "type", null)

      value        = lookup(delivery_property.value, "value", null)
      source_field = lookup(delivery_property.value, "source_field", null)
      secret       = lookup(delivery_property.value, "secret", null)
    }
  }

  dynamic "dead_letter_identity" {
    iterator = dead_letter_identity
    for_each = length(keys(var.eventgrid_event_subscription_dead_letter_identity)) > 0 ? [var.eventgrid_event_subscription_dead_letter_identity] : []

    content {
      type = lookup(dead_letter_identity.value, "type", null)

      user_assigned_identity = lookup(dead_letter_identity.value, "user_assigned_identity", null)
    }
  }

  dynamic "storage_blob_dead_letter_destination" {
    iterator = storage_blob_dead_letter_destination
    for_each = length(keys(var.eventgrid_event_subscription_storage_blob_dead_letter_destination)) > 0 ? [var.eventgrid_event_subscription_storage_blob_dead_letter_destination] : []

    content {
      storage_account_id          = lookup(storage_blob_dead_letter_destination.value, "storage_account_id", null)
      storage_blob_container_name = lookup(storage_blob_dead_letter_destination.value, "storage_blob_container_name", null)
    }
  }

  dynamic "retry_policy" {
    iterator = retry_policy
    for_each = length(keys(var.eventgrid_event_subscription_retry_policy)) > 0 ? [var.eventgrid_event_subscription_retry_policy] : []

    content {
      max_delivery_attempts = lookup(retry_policy.value, "max_delivery_attempts", null)
      event_time_to_live    = lookup(retry_policy.value, "event_time_to_live", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.eventgrid_event_subscription_timeouts)) > 0 ? [var.eventgrid_event_subscription_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_eventgrid_topic.eventgrid_topic
  ]
}