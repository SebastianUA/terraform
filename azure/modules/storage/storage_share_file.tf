#-----------------------------------------------------------
# Azure storage share file
#-----------------------------------------------------------
resource "azurerm_storage_share_file" "storage_share_file" {
  count = var.enable_storage_share_file ? 1 : 0

  name             = var.storage_share_file_name
  storage_share_id = var.storage_share_file_storage_share_id != "" ? var.storage_share_file_storage_share_id : (var.enable_storage_account ? azurerm_storage_share.storage_share[count.index].id : null)

  source              = var.storage_share_file_source
  path                = var.storage_share_file_path
  content_type        = var.storage_share_file_content_type
  content_md5         = var.storage_share_file_content_md5
  content_encoding    = var.storage_share_file_content_encoding
  content_disposition = var.storage_share_file_content_disposition
  metadata            = var.storage_share_file_metadata

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_share_file_timeouts)) > 0 ? [var.storage_share_file_timeouts] : []

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
    azurerm_storage_share.storage_share
  ]
}
