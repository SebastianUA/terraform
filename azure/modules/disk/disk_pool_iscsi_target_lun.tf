#-----------------------------------------------------------
# Azure disk pool iscsi target lun
#-----------------------------------------------------------
resource "azurerm_disk_pool_iscsi_target_lun" "disk_pool_iscsi_target_lun" {
  count = var.enable_disk_pool_iscsi_target_lun ? 1 : 0

  name                                 = var.disk_pool_iscsi_target_lun_name != "" ? var.disk_pool_iscsi_target_lun_name : "${lower(var.name)}-disk-pool-iscsi-target-lun-${lower(var.environment)}"
  iscsi_target_id                      = var.disk_pool_iscsi_target_lun_iscsi_target_id != "" ? var.disk_pool_iscsi_target_lun_iscsi_target_id : (var.enable_disk_pool_iscsi_target ? azurerm_disk_pool_iscsi_target.disk_pool_iscsi_target[count.index].id : null)
  disk_pool_managed_disk_attachment_id = var.disk_pool_iscsi_target_lun_disk_pool_managed_disk_attachment_id != "" ? var.disk_pool_iscsi_target_lun_disk_pool_managed_disk_attachment_id : (var.enable_disk_pool_managed_disk_attachment ? azurerm_disk_pool_managed_disk_attachment.disk_pool_managed_disk_attachment[count.index].id : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.disk_pool_iscsi_target_lun_timeouts)) > 0 ? [var.disk_pool_iscsi_target_lun_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_disk_pool_iscsi_target.disk_pool_iscsi_target,
    azurerm_disk_pool_managed_disk_attachment.disk_pool_managed_disk_attachment
  ]
}