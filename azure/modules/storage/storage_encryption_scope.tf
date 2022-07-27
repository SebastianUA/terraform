#-----------------------------------------------------------
# Azure storage encryption scope
#-----------------------------------------------------------
resource "azurerm_storage_encryption_scope" "storage_encryption_scope" {
  count = var.enable_storage_encryption_scope ? 1 : 0

  name               = var.storage_encryption_scope_name != "" ? var.storage_encryption_scope_name : "${lower(var.name)}-storage-encryption-scope-${lower(var.environment)}"
  storage_account_id = var.storage_encryption_scope_storage_account_id != "" ? var.storage_encryption_scope_storage_account_id : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].id : null)
  source             = var.storage_encryption_scope_source

  infrastructure_encryption_required = var.storage_encryption_scope_infrastructure_encryption_required
  key_vault_key_id                   = var.storage_encryption_scope_key_vault_key_ids

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_encryption_scope_timeouts)) > 0 ? [var.storage_encryption_scope_timeouts] : []

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
    azurerm_storage_account.storage_account
  ]
}