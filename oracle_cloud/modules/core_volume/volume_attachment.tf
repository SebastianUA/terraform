#-----------------------------------------------------------
# core volume attachment
#-----------------------------------------------------------
resource "oci_core_volume_attachment" "core_volume_attachment" {
  count = var.enable_core_volume_attachment ? 1 : 0

  # Required
  attachment_type = var.core_volume_attachment_attachment_type
  instance_id     = var.core_volume_attachment_instance_id
  volume_id       = var.core_volume_attachment_volume_id != "" && !var.enable_core_volume ? var.core_volume_attachment_volume_id : (var.enable_core_volume ? element(oci_core_volume.core_volume.*.id, 0) : null)

  # Optional
  device                              = var.core_volume_attachment_device
  display_name                        = var.core_volume_attachment_display_name
  encryption_in_transit_type          = var.core_volume_attachment_encryption_in_transit_type
  is_agent_auto_iscsi_login_enabled   = var.core_volume_attachment_is_agent_auto_iscsi_login_enabled
  is_pv_encryption_in_transit_enabled = var.core_volume_attachment_is_pv_encryption_in_transit_enabled
  is_read_only                        = var.core_volume_attachment_is_read_only
  is_shareable                        = var.core_volume_attachment_is_shareable
  use_chap                            = var.core_volume_attachment_use_chap

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_volume_attachment_timeouts)) > 0 ? [var.core_volume_attachment_timeouts] : []

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