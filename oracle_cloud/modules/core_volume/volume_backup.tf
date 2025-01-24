#-----------------------------------------------------------
# core volume backup
#-----------------------------------------------------------
resource "oci_core_volume_backup" "core_volume_backup" {
  count = var.enable_core_volume_backup ? 1 : 0

  # Required
  volume_id = var.core_volume_backup_volume_id != "" && !var.enable_core_volume ? var.core_volume_backup_volume_id : (var.enable_core_volume ? element(oci_core_volume_group.core_volume_group.*.id, 0) : null)

  # Optional
  display_name = var.core_volume_backup_display_name
  kms_key_id   = var.core_volume_backup_kms_key_id
  type         = var.core_volume_backup_type

  defined_tags = merge(
    {
      "company.Name" = var.core_volume_backup_display_name != "" ? var.core_volume_backup_display_name : "${lower(var.name)}-volume-backup-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_volume_backup_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_volume_backup_timeouts)) > 0 ? [var.core_volume_backup_timeouts] : []

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