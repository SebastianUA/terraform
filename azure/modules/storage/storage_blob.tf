#-----------------------------------------------------------
# Azure storage blob
#-----------------------------------------------------------
resource "azurerm_storage_blob" "storage_blob" {
  count = var.enable_storage_blob ? 1 : 0

  name                   = var.storage_blob_name
  storage_account_name   = var.storage_blob_storage_account_name != "" ? var.storage_blob_storage_account_name : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].name : null)
  storage_container_name = var.storage_blob_storage_container_name != "" ? var.storage_blob_storage_container_name : (var.enable_storage_container ? azurerm_storage_container.storage_container[count.index].name : null)
  type                   = var.storage_blob_type

  size           = var.storage_blob_size
  access_tier    = var.storage_blob_access_tier
  cache_control  = var.storage_blob_cache_control
  content_type   = var.storage_blob_content_type
  content_md5    = var.storage_blob_content_md5
  source         = var.storage_blob_source
  source_content = var.storage_blob_source_content
  source_uri     = var.storage_blob_source_uri
  parallelism    = var.storage_blob_parallelism
  metadata       = var.storage_blob_metadata

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_blob_timeouts)) > 0 ? [var.storage_blob_timeouts] : []

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
    azurerm_storage_account.storage_account,
    azurerm_storage_container.storage_container
  ]
}