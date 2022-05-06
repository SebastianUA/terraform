#-----------------------------------------------------------
# Azure virtual desktop host pool registration info
#-----------------------------------------------------------
resource "azurerm_virtual_desktop_host_pool_registration_info" "virtual_desktop_host_pool_registration_info" {
  count = var.enable_virtual_desktop_host_pool_registration_info ? 1 : 0

  hostpool_id     = var.virtual_desktop_host_pool_registration_info_hostpool_id != "" ? var.virtual_desktop_host_pool_registration_info_hostpool_id : (var.enable_virtual_desktop_host_pool ? azurerm_virtual_desktop_host_pool.virtual_desktop_host_pool[count.index].id : null)
  expiration_date = var.virtual_desktop_host_pool_registration_info_expiration_date

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_virtual_desktop_host_pool.virtual_desktop_host_pool
  ]
}