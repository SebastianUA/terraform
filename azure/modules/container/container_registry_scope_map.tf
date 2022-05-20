#-----------------------------------------------------------
# Azure container registry scope map
#-----------------------------------------------------------
resource "azurerm_container_registry_scope_map" "container_registry_scope_map" {
  count = var.enable_container_registry_scope_map ? 1 : 0

  name                    = var.container_registry_scope_map_name != "" ? var.container_registry_scope_map_name : "${lower(var.name)}-container-registry-scope-map-${lower(var.environment)}"
  container_registry_name = var.container_registry_scope_map_container_registry_name != "" ? var.container_registry_scope_map_container_registry_name : (var.enable_container_registry ? azurerm_container_registry.container_registry[count.index].name : null)
  resource_group_name     = var.container_registry_scope_map_resource_group_name
  actions                 = var.container_registry_scope_map_actions

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.container_registry_scope_map_timeouts)) > 0 ? [var.container_registry_webhook_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.container_registry_scope_map_name != "" ? var.container_registry_scope_map_name : "${lower(var.name)}-container-registry-scope-map-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_container_registry.container_registry
  ]
}