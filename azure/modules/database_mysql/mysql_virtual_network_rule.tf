#-----------------------------------------------------------
# Azure mysql virtual network rule
#-----------------------------------------------------------
resource "azurerm_mysql_virtual_network_rule" "mysql_virtual_network_rule" {
  count = var.enable_mysql_virtual_network_rule ? 1 : 0

  name                = var.mysql_virtual_network_rule_name != "" ? var.mysql_virtual_network_rule_name : "${lower(var.name)}-mysql-virtual-network-rule-${lower(var.environment)}"
  resource_group_name = var.mysql_virtual_network_rule_resource_group_name
  server_name         = var.mysql_virtual_network_rule_server_name != "" ? var.mysql_virtual_network_rule_server_name : (var.enable_mysql_server ? azurerm_mysql_server.mysql_server[count.index].name : null)
  subnet_id           = var.mysql_virtual_network_rule_subnet_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_virtual_network_rule_timeouts)) > 0 ? [var.mysql_virtual_network_rule_timeouts] : []

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