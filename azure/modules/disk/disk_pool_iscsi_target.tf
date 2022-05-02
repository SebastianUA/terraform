#-----------------------------------------------------------
# Azure disk pool iscsi target
#-----------------------------------------------------------
resource "azurerm_disk_pool_iscsi_target" "disk_pool_iscsi_target" {
  count = var.enable_disk_pool_iscsi_target ? 1 : 0

  name          = var.disk_pool_iscsi_target_name != "" ? var.disk_pool_iscsi_target_name : "${lower(var.name)}-disk-pool-iscsi-target-${lower(var.environment)}"
  acl_mode      = var.disk_pool_iscsi_target_acl_mode
  disks_pool_id = var.disk_pool_iscsi_target_disks_pool_id != "" ? var.disk_pool_iscsi_target_disks_pool_id : (var.enable_disk_pool ? azurerm_disk_pool.disk_pool[count.index].id : null)

  target_iqn = var.disk_pool_iscsi_target_target_iqn

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.disk_pool_iscsi_target_timeouts)) > 0 ? [var.disk_pool_iscsi_target_timeouts] : []

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
    azurerm_disk_pool.disk_pool
  ]
}