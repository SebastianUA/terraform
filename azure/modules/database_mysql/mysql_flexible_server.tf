#-----------------------------------------------------------
# Azure mysql flexible server
#-----------------------------------------------------------
resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  count = var.enable_mysql_flexible_server ? 1 : 0

  name                = var.mysql_flexible_server_name != "" ? var.mysql_flexible_server_name : "${lower(var.name)}-mysql-flexible-server-${lower(var.environment)}"
  resource_group_name = var.mysql_flexible_server_resource_group_name
  location            = var.mysql_flexible_server_location

  administrator_login    = var.mysql_flexible_server_administrator_login
  administrator_password = var.mysql_flexible_server_administrator_password
  create_mode            = var.mysql_flexible_server_create_mode
  source_server_id       = var.mysql_flexible_server_source_server_id

  backup_retention_days             = var.mysql_flexible_server_backup_retention_days
  geo_redundant_backup_enabled      = var.mysql_flexible_server_geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = var.mysql_flexible_server_point_in_time_restore_time_in_utc

  replication_role    = var.mysql_flexible_server_replication_role
  delegated_subnet_id = var.mysql_flexible_server_delegated_subnet_id

  sku_name = var.mysql_flexible_server_sku_name
  version  = var.mysql_flexible_server_version

  private_dns_zone_id = var.mysql_flexible_server_private_dns_zone_id
  zone                = var.mysql_flexible_server_zone

  dynamic "high_availability" {
    iterator = high_availability
    for_each = length(keys(var.mysql_flexible_server_high_availability)) > 0 ? [var.mysql_flexible_server_high_availability] : []

    content {
      mode = lookup(high_availability.value, "mode", null)

      standby_availability_zone = lookup(high_availability.value, "standby_availability_zone", null)
    }
  }

  dynamic "maintenance_window" {
    iterator = maintenance_window
    for_each = length(keys(var.mysql_flexible_server_maintenance_window)) > 0 ? [var.mysql_flexible_server_maintenance_window] : []

    content {
      day_of_week  = lookup(maintenance_window.value, "day_of_week", null)
      start_hour   = lookup(maintenance_window.value, "start_hour", null)
      start_minute = lookup(maintenance_window.value, "start_minute", null)
    }
  }

  dynamic "storage" {
    iterator = storage
    for_each = length(keys(var.mysql_flexible_server_storage)) > 0 ? [var.mysql_flexible_server_storage] : []

    content {
      auto_grow_enabled = lookup(storage.value, "auto_grow_enabled", null)
      iops              = lookup(storage.value, "iops", null)
      size_gb           = lookup(storage.value, "size_gb", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_flexible_server_timeouts)) > 0 ? [var.mysql_flexible_server_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.mysql_flexible_server_name != "" ? var.mysql_flexible_server_name : "${lower(var.name)}-mysql-flexible-server-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}