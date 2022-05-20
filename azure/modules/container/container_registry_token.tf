#-----------------------------------------------------------
# Azure container registry token
#-----------------------------------------------------------
resource "azurerm_container_registry_token" "container_registry_token" {
  count = var.enable_container_registry_token ? 1 : 0

  name                    = var.container_registry_token_name != "" ? var.container_registry_token_name : "${lower(var.name)}-container-registry-token-${lower(var.environment)}"
  container_registry_name = var.container_registry_token_container_registry_name != "" ? var.container_registry_token_container_registry_name : (var.enable_container_registry ? azurerm_container_registry.container_registry[count.index].name : null)
  resource_group_name     = var.container_registry_token_resource_group_name
  scope_map_id            = var.container_registry_token_scope_map_id != "" ? var.container_registry_token_scope_map_id : (var.enable_container_registry_scope_map ? azurerm_container_registry_scope_map.container_registry_scope_map[count.index].id : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.container_registry_token_timeouts)) > 0 ? [var.container_registry_token_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.container_registry_token_name != "" ? var.container_registry_token_name : "${lower(var.name)}-container-registry-token-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_container_registry.container_registry,
    azurerm_container_registry_scope_map.container_registry_scope_map
  ]
}