#-----------------------------------------------------------
# Azure storage table
#-----------------------------------------------------------
resource "azurerm_storage_table" "storage_table" {
  count = var.enable_storage_table ? 1 : 0

  name                 = var.storage_table_name != "" ? var.storage_table_name : "${lower(var.name)}-storage-table-${lower(var.environment)}"
  storage_account_name = var.storage_table_storage_account_name != "" ? var.storage_table_storage_account_name : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].name : null)

  dynamic "acl" {
    iterator = acl
    for_each = var.storage_table_acl

    content {
      id = lookup(acl.value, "id", null)

      dynamic "access_policy" {
        iterator = access_policy
        for_each = length(keys(lookup(acl.value, "access_policy", {}))) > 0 ? [lookup(acl.value, "access_policy", {})] : []

        content {
          expiry      = lookup(access_policy.value, "expiry", null)
          permissions = lookup(access_policy.value, "permissions", null)
          start       = lookup(access_policy.value, "start", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_table_timeouts)) > 0 ? [var.storage_table_timeouts] : []

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