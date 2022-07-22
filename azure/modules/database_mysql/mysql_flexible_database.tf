#-----------------------------------------------------------
# Azure mysql flexible database
#-----------------------------------------------------------
resource "azurerm_mysql_flexible_database" "mysql_flexible_database" {
  count = var.enable_mysql_flexible_database ? 1 : 0

  name                = var.mysql_flexible_database_name != "" ? var.mysql_flexible_database_name : "${lower(var.name)}-mysql-flexible-database-${lower(var.environment)}"
  server_name         = var.mysql_flexible_database_server_name != "" ? var.mysql_flexible_database_server_name : (var.enable_mysql_server ? azurerm_mysql_flexible_server.mysql_flexible_server[count.index].name : null)
  resource_group_name = var.mysql_flexible_database_resource_group_name
  charset             = var.mysql_flexible_database_charset
  collation           = var.mysql_flexible_database_collation

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_flexible_database_timeouts)) > 0 ? [var.mysql_flexible_database_timeouts] : []

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
    azurerm_mysql_flexible_server.mysql_flexible_server
  ]
}