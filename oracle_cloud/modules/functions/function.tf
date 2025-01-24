#-----------------------------------------------------------
# functions function
#-----------------------------------------------------------
resource "oci_functions_function" "functions_function" {
  count = var.enable_functions_function ? 1 : 0

  # Required
  application_id = var.functions_function_application_id != "" && !var.enable_functions_application ? var.functions_function_application_id : (var.enable_functions_application ? element(oci_functions_application.functions_application.*.id, 0) : null)
  display_name   = var.functions_function_display_name != "" ? var.functions_function_display_name : "${lower(var.name)}-function-${lower(var.environment)}"
  memory_in_mbs  = var.functions_function_memory_in_mbs

  # Optional
  config = var.functions_function_config

  image              = var.functions_function_image
  image_digest       = var.functions_function_image_digest
  timeout_in_seconds = var.functions_function_timeout_in_seconds

  dynamic "provisioned_concurrency_config" {
    iterator = provisioned_concurrency_config
    for_each = length(keys(var.functions_function_provisioned_concurrency_config)) > 0 ? [var.functions_function_provisioned_concurrency_config] : []

    content {
      # Required
      strategy = lookup(provisioned_concurrency_config.value, "strategy", null)

      # Optional
      count = lookup(provisioned_concurrency_config.value, "count", null)
    }
  }

  dynamic "source_details" {
    iterator = source_details
    for_each = var.functions_function_source_details

    content {
      # Required
      pbf_listing_id = lookup(source_details.value, "pbf_listing_id", null)
      source_type    = lookup(source_details.value, "source_type", null)
    }
  }

  dynamic "trace_config" {
    iterator = trace_config
    for_each = length(keys(var.functions_function_trace_config)) > 0 ? [var.functions_function_trace_config] : []

    content {
      # Optional
      is_enabled = lookup(trace_config.value, "is_enabled", null)
    }
  }

  defined_tags = var.functions_function_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.functions_function_display_name != "" ? var.functions_function_display_name : "${lower(var.name)}-function-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.functions_function_timeouts)) > 0 ? [var.functions_function_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}