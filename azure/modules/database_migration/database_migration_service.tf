#-----------------------------------------------------------
# Azure database migration service
#-----------------------------------------------------------
resource "azurerm_database_migration_service" "database_migration_service" {
  count = var.enable_database_migration_service ? 1 : 0

  name                = var.database_migration_service_name != "" ? var.database_migration_service_name : "${lower(var.name)}-db-migration-service-${lower(var.environment)}"
  location            = var.database_migration_service_location
  resource_group_name = var.database_migration_service_resource_group_name
  subnet_id           = var.database_migration_service_subnet_id
  sku_name            = var.database_migration_service_sku_name

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.database_migration_service_timeouts)) > 0 ? [var.database_migration_service_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.database_migration_service_name != "" ? var.database_migration_service_name : "${lower(var.name)}-db-migration-service-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}