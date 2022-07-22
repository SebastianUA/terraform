#-----------------------------------------------------------
# Azure mysql firewall rule
#-----------------------------------------------------------
resource "azurerm_mysql_firewall_rule" "mysql_firewall_rule" {
  count = var.enable_mysql_firewall_rule ? 1 : 0

  name                = var.mysql_firewall_rule_name != "" ? var.mysql_firewall_rule_name : "${lower(var.name)}-mysql-firewall-rule-${lower(var.environment)}"
  server_name         = var.mysql_firewall_rule_server_name != "" ? var.mysql_firewall_rule_server_name : (var.enable_mysql_server ? azurerm_mysql_server.mysql_server[count.index].name : null)
  resource_group_name = var.mysql_firewall_rule_resource_group_name
  start_ip_address    = var.mysql_firewall_rule_start_ip_address
  end_ip_address      = var.mysql_firewall_rule_end_ip_address

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_firewall_rule_timeouts)) > 0 ? [var.mysql_firewall_rule_timeouts] : []

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