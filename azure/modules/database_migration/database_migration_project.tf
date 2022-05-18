#-----------------------------------------------------------
# Azure database migration project
#-----------------------------------------------------------
resource "azurerm_database_migration_project" "database_migration_project" {
  count = var.enable_database_migration_project ? 1 : 0

  name                = var.database_migration_project_name != "" ? var.database_migration_project_name : "${lower(var.name)}-db-migration-project-${lower(var.environment)}"
  service_name        = var.database_migration_project_service_name != "" ? var.database_migration_project_service_name : (var.enable_database_migration_service ? azurerm_database_migration_service.database_migration_service[count.index].name : null)
  resource_group_name = var.database_migration_project_resource_group_name
  location            = var.database_migration_project_location
  source_platform     = var.database_migration_project_source_platform
  target_platform     = var.database_migration_project_target_platform

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.database_migration_project_timeouts)) > 0 ? [var.database_migration_project_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.database_migration_project_name != "" ? var.database_migration_project_name : "${lower(var.name)}-db-migration-project-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_database_migration_service.database_migration_service
  ]
}