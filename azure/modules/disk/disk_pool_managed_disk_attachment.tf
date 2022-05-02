#-----------------------------------------------------------
# Azure disk pool managed disk attachment
#-----------------------------------------------------------
resource "azurerm_disk_pool_managed_disk_attachment" "disk_pool_managed_disk_attachment" {
  count = var.enable_disk_pool_managed_disk_attachment ? 1 : 0

  disk_pool_id    = var.disk_pool_managed_disk_attachment_disk_pool_id != "" ? var.disk_pool_managed_disk_attachment_disk_pool_id : (var.enable_disk_pool ? azurerm_disk_pool.disk_pool[count.index].id : null)
  managed_disk_id = var.disk_pool_managed_disk_attachment_managed_disk_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.disk_pool_managed_disk_attachment_timeouts)) > 0 ? [var.disk_pool_managed_disk_attachment_timeouts] : []

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