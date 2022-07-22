#-----------------------------------------------------------
# Azure mysql active directory administrator
#-----------------------------------------------------------
resource "azurerm_mysql_active_directory_administrator" "mysql_active_directory_administrator" {
  count = var.enable_mysql_active_directory_administrator ? 1 : 0

  server_name         = var.mysql_active_directory_administrator_server_name != "" ? var.mysql_active_directory_administrator_server_name : (var.enable_mysql_server ? azurerm_mysql_server.mysql_server[count.index].name : null)
  resource_group_name = var.mysql_active_directory_administrator_resource_group_name
  login               = var.mysql_active_directory_administrator_login
  object_id           = var.mysql_active_directory_administrator_object_id
  tenant_id           = var.mysql_active_directory_administrator_tenant_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_active_directory_administrator_timeouts)) > 0 ? [var.mysql_active_directory_administrator_timeouts] : []

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
