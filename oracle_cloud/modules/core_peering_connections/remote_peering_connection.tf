#-----------------------------------------------------------
# core remote peering connection
#-----------------------------------------------------------
resource "oci_core_remote_peering_connection" "core_remote_peering_connection" {
  count = var.enable_core_remote_peering_connection ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  drg_id         = var.core_remote_peering_connection_drg_id

  # Optional
  display_name     = var.core_remote_peering_connection_display_name != "" ? var.core_remote_peering_connection_display_name : "${lower(var.name)}-remote-peer-con-${lower(var.environment)}-${count.index + 1}"
  peer_id          = var.core_remote_peering_connection_peer_id
  peer_region_name = var.core_remote_peering_connection_peer_region_name

  defined_tags = var.var.core_remote_peering_connection_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_remote_peering_connection_display_name != "" ? var.core_remote_peering_connection_display_name : "${lower(var.name)}-remote-peer-con-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_remote_peering_connection_timeouts)) > 0 ? [var.core_remote_peering_connection_timeouts] : []

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