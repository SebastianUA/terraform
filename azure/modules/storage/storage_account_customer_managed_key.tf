#-----------------------------------------------------------
# Azure storage account customer managed key
#-----------------------------------------------------------
resource "azurerm_storage_account_customer_managed_key" "storage_account_customer_managed_key" {
  count = var.enable_storage_account_customer_managed_key ? 1 : 0

  storage_account_id = var.storage_account_customer_managed_key_storage_account_id != "" ? var.storage_account_customer_managed_key_storage_account_id : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].id : null)
  key_vault_id       = var.storage_account_customer_managed_key_key_vault_id
  key_name           = var.storage_account_customer_managed_key_key_name

  key_version               = var.storage_account_customer_managed_key_key_version
  user_assigned_identity_id = var.storage_account_customer_managed_key_user_assigned_identity_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_account_customer_managed_key_timeouts)) > 0 ? [var.storage_account_customer_managed_key_timeouts] : []

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