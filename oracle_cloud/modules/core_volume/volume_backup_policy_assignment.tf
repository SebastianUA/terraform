#-----------------------------------------------------------
# core volume backup policy assignment
#-----------------------------------------------------------
resource "oci_core_volume_backup_policy_assignment" "core_volume_backup_policy_assignment" {
  count = var.enable_core_volume_backup_policy_assignment ? 1 : 0

  # Required
  asset_id  = var.core_volume_backup_policy_assignment_asset_id != "" && !var.enable_core_volume ? var.core_volume_backup_policy_assignment_asset_id : (var.enable_core_volume ? element(oci_core_volume.core_volume.*.id, 0) : null)
  policy_id = var.core_volume_backup_policy_assignment_policy_id != "" && !var.enable_core_volume_backup_policy ? var.core_volume_backup_policy_assignment_policy_id : (var.enable_core_volume_backup_policy ? element(oci_core_volume_backup_policy.core_volume_backup_policy.*.id, 0) : null)

  # Optional
  xrc_kms_key_id = var.core_volume_backup_policy_assignment_xrc_kms_key_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_volume_backup_policy_assignment_timeouts)) > 0 ? [var.core_volume_backup_policy_assignment_timeouts] : []

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