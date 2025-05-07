#-----------------------------------------------------------
# core drg attachments list
#-----------------------------------------------------------
resource "oci_core_drg_attachments_list" "core_drg_attachments_list" {
  count = var.enable_core_drg_attachments_list ? 1 : 0

  # Required
  drg_id = var.core_drg_attachments_list_drg_id && !var.enable_core_drg ? var.core_drg_attachments_list_drg_id : (var.enable_core_drg ? element(oci_core_drg.core_drg.*.id, 0) : null)

  # Optional
  attachment_type  = var.core_drg_attachments_list_attachment_type
  is_cross_tenancy = var.core_drg_attachments_list_is_cross_tenancy

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_drg_attachments_list_timeouts)) > 0 ? [var.core_drg_attachments_list_timeouts] : []

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