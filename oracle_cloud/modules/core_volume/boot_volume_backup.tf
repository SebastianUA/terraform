#-----------------------------------------------------------
# core boot volume backup
#-----------------------------------------------------------
resource "oci_core_boot_volume_backup" "core_boot_volume_backup" {
  count = var.enable_core_boot_volume_backup ? 1 : 0

  # Required
  boot_volume_id = var.core_boot_volume_backup_boot_volume_id != "" && !var.enable_core_boot_volume ? var.core_boot_volume_backup_boot_volume_id : (var.enable_core_boot_volume ? element(oci_core_boot_volume.core_boot_volume.*.id, 0) : null)

  # Optional
  display_name = var.core_boot_volume_backup_display_name != "" ? var.core_boot_volume_backup_display_name : "${lower(var.name)}-boot-volume-backup-${lower(var.environment)}"
  kms_key_id   = var.core_boot_volume_backup_kms_key_id
  type         = var.core_boot_volume_backup_type

  defined_tags = var.core_boot_volume_backup_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_boot_volume_backup_display_name != "" ? var.core_boot_volume_backup_display_name : "${lower(var.name)}-boot-volume-backup-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_boot_volume_backup_timeouts)) > 0 ? [var.core_boot_volume_backup_timeouts] : []

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