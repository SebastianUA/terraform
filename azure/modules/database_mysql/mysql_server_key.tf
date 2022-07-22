#-----------------------------------------------------------
# Azure mysql server key
#-----------------------------------------------------------
resource "azurerm_mysql_server_key" "mysql_server_key" {
  count = var.enable_mysql_server_key ? 1 : 0

  server_id        = var.mysql_server_key_server_id != "" ? var.mysql_server_key_server_id : (var.enable_mysql_server ? azurerm_mysql_server.mysql_server[count.index].name : null)
  key_vault_key_id = var.mysql_server_key_key_vault_key_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_server_key_timeouts)) > 0 ? [var.mysql_server_key_timeouts] : []

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
    azurerm_mysql_server.mysql_server
  ]
}