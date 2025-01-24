#-----------------------------------------------------------
# functions application
#-----------------------------------------------------------
resource "oci_functions_application" "functions_application" {
  count = var.enable_functions_application ? 1 : 0

  # Required
  compartment_id = var.functions_application_compartment_id
  display_name   = var.functions_application_display_name != "" ? var.functions_application_display_name : "${lower(var.name)}-application-${lower(var.environment)}"
  subnet_ids     = var.functions_application_subnet_ids

  # Optional
  config                     = var.functions_application_config
  network_security_group_ids = var.functions_application_network_security_group_ids
  shape                      = var.functions_application_shape
  syslog_url                 = var.functions_application_syslog_url

  dynamic "image_policy_config" {
    iterator = image_policy_config
    for_each = length(keys(var.functions_application_image_policy_config)) > 0 ? [var.functions_application_image_policy_config] : []

    content {
      # Required
      is_policy_enabled = lookup(image_policy_config.value, "is_policy_enabled", null)

      # Optional
      dynamic "key_details" {
        iterator = key_details
        for_each = length(keys(lookup(image_policy_config.value, "key_details", {}))) > 0 ? [lookup(image_policy_config.value, "key_details", {})] : []

        content {
          # Required
          kms_key_id = lookup(key_details.value, "kms_key_id", null)
        }
      }
    }
  }

  dynamic "trace_config" {
    iterator = trace_config
    for_each = length(keys(var.functions_application_trace_config)) > 0 ? [var.functions_application_trace_config] : []

    content {
      # Optional
      domain_id  = lookup(trace_config.value, "domain_id", null)
      is_enabled = lookup(trace_config.value, "is_enabled", null)
    }
  }

  defined_tags = merge(
    {
      "company.Name" = var.functions_application_display_name != "" ? var.functions_application_display_name : "${lower(var.name)}-application-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.functions_application_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.functions_application_timeouts)) > 0 ? [var.functions_application_timeouts] : []

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