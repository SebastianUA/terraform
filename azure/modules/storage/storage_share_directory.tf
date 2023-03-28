#-----------------------------------------------------------
# Azure storage share directory
#-----------------------------------------------------------
resource "azurerm_storage_share_directory" "storage_share_directory" {
  count = var.enable_storage_share_directory ? 1 : 0

  name                 = var.storage_share_directory_name != "" ? var.storage_share_directory_name : "${lower(var.name)}-storage-share-directory-${lower(var.environment)}"
  share_name           = var.storage_share_directory_share_name != "" ? var.storage_share_directory_share_name : (var.enable_storage_share ? azurerm_storage_share.storage_share[count.index].name : null)
  storage_account_name = var.storage_share_directory_storage_account_name != "" ? var.storage_share_directory_storage_account_name : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].name : null)

  metadata = var.storage_share_directory_metadata

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_share_directory_timeouts)) > 0 ? [var.storage_share_directory_timeouts] : []

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
    azurerm_storage_share.storage_share,
    azurerm_storage_account.storage_account
  ]
}
