#-----------------------------------------------------------
# Azure mysql flexible server configuration
#-----------------------------------------------------------
resource "azurerm_mysql_flexible_server_configuration" "mysql_flexible_server_configuration" {
  count = var.enable_mysql_flexible_server_configuration ? length(var.mysql_flexible_server_configuration_parameters) : 0

  name                = lookup(var.mysql_flexible_server_configuration_parameters[count.index], "name", null)
  resource_group_name = var.mysql_flexible_server_configuration_resource_group_name
  server_name         = var.mysql_flexible_server_configuration_server_name != "" ? var.mysql_flexible_server_configuration_server_name : (var.enable_mysql_server ? azurerm_mysql_flexible_server.mysql_flexible_server[0].name : null)
  value               = lookup(var.mysql_flexible_server_configuration_parameters[count.index], "value", null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_flexible_server_configuration_timeouts)) > 0 ? [var.mysql_flexible_server_configuration_timeouts] : []

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