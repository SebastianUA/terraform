#-----------------------------------------------------------
# outbound connector
#-----------------------------------------------------------
resource "oci_file_storage_outbound_connector" "file_storage_outbound_connector" {
  count = var.enable_file_storage_outbound_connector ? 1 : 0

  # Required
  availability_domain     = var.file_storage_outbound_connector_availability_domain
  bind_distinguished_name = var.file_storage_outbound_connector_bind_distinguished_name
  compartment_id          = var.file_storage_outbound_connector_compartment_id
  connector_type          = var.file_storage_outbound_connector_connector_type

  dynamic "endpoints" {
    iterator = endpoints
    for_each = var.file_storage_outbound_connector_endpoints

    content {
      # Required
      hostname = lookup(endpoints.value, "hostname", null)
      port     = lookup(endpoints.value, "port", null)
    }
  }

  # Optional
  display_name            = var.file_storage_outbound_connector_display_name != "" ? var.file_storage_outbound_connector_display_name : "${lower(var.name)}-nfs-out-connector-${lower(var.environment)}"
  password_secret_id      = var.file_storage_outbound_connector_password_secret_id
  password_secret_version = var.file_storage_outbound_connector_password_secret_version

  dynamic "locks" {
    iterator = locks
    for_each = var.file_storage_outbound_connector_locks

    content {
      # Required
      type = lookup(locks.value, "type", null)

      # Optional
      message             = lookup(locks.value, "message", null)
      related_resource_id = lookup(locks.value, "related_resource_id", null)
      time_created        = lookup(locks.value, "time_created", null)
    }
  }

  defined_tags = merge(
    {
      Name = var.file_storage_outbound_connector_display_name != "" ? var.file_storage_outbound_connector_display_name : "${lower(var.name)}-nfs-out-connector-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.file_storage_outbound_connector_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.file_storage_outbound_connector_timeouts)) > 0 ? [var.file_storage_outbound_connector_timeouts] : []

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