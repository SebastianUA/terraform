#-----------------------------------------------------------
# Azure active directory domain service replica set
#-----------------------------------------------------------
resource "azurerm_active_directory_domain_service_replica_set" "active_directory_domain_service_replica_set" {
  count = var.enable_active_directory_domain_service_replica_set ? 1 : 0

  domain_service_id = var.active_directory_domain_service_replica_set_domain_service_id != "" ? var.active_directory_domain_service_replica_set_domain_service_id : (var.enable_active_directory_domain_service ? azurerm_active_directory_domain_service.active_directory_domain_service[count.index].id : null)
  location          = var.active_directory_domain_service_replica_set_location
  subnet_id         = var.active_directory_domain_service_replica_set_subnet_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.active_directory_domain_service_replica_set_timeouts)) > 0 ? [var.active_directory_domain_service_replica_set_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      azurerm_active_directory_domain_service.active_directory_domain_service
    ]
  }
}