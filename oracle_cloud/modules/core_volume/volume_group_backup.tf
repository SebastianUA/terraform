#-----------------------------------------------------------
# core volume group backup
#-----------------------------------------------------------
resource "oci_core_volume_group_backup" "core_volume_group_backup" {
  count = var.enable_core_volume_group_backup ? 1 : 0

  # Required
  volume_group_id = var.core_volume_group_backup_volume_group_id != "" && !var.enable_core_volume_group ? var.core_volume_group_backup_volume_group_id : (var.enable_core_volume_group ? element(oci_core_volume_group.core_volume_group.*.id, 0) : null)

  # Optional
  compartment_id = var.core_volume_group_backup_compartment_id
  display_name   = var.core_volume_group_backup_display_name != "" ? var.core_volume_group_backup_display_name : "${lower(var.name)}-volume-group-backup-${lower(var.environment)}"
  type           = var.core_volume_group_backup_type

  defined_tags = merge(
    {
      "company.Name" = var.core_volume_group_backup_display_name != "" ? var.core_volume_group_backup_display_name : "${lower(var.name)}-volume-group-backup-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_volume_group_backup_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_volume_group_backup_timeouts)) > 0 ? [var.core_volume_group_backup_timeouts] : []

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