#-----------------------------------------------------------
# Azure mysql configuration
#-----------------------------------------------------------
resource "azurerm_mysql_configuration" "mysql_configuration" {
  count = var.enable_mysql_configuration ? 1 : 0

  name                = var.mysql_configuration_name != "" ? var.mysql_configuration_name : "${lower(var.name)}-mysql-configuration-${lower(var.environment)}"
  server_name         = var.mysql_configuration_server_name != "" ? var.mysql_configuration_server_name : (var.enable_mysql_server ? azurerm_mysql_server.mysql_server[count.index].name : null)
  resource_group_name = var.mysql_configuration_resource_group_name
  value               = var.mysql_configuration_value

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_configuration_timeouts)) > 0 ? [var.mysql_configuration_timeouts] : []

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
