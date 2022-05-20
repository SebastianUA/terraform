#-----------------------------------------------------------
# Azure container registry agent pool
#-----------------------------------------------------------
resource "azurerm_container_registry_agent_pool" "container_registry_agent_pool" {
  count = var.enable_container_registry_agent_pool ? 1 : 0

  name                    = var.container_registry_agent_pool_name != "" ? var.container_registry_agent_pool_name : "${lower(var.name)}-container-registry-agent-pool-${lower(var.environment)}"
  resource_group_name     = var.container_registry_agent_pool_resource_group_name
  location                = var.container_registry_agent_pool_location
  container_registry_name = var.container_registry_agent_pool_container_registry_name != "" ? var.container_registry_agent_pool_ : (var.enable_container_registry ? azurerm_container_registry.container_registry[count.index].name : null)

  instance_count            = var.container_registry_agent_pool_instance_count
  tier                      = var.container_registry_agent_pool_tier
  virtual_network_subnet_id = var.container_registry_agent_pool_virtual_network_subnet_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.container_registry_agent_pool_timeouts)) > 0 ? [var.container_registry_agent_pool_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.container_registry_agent_pool_name != "" ? var.container_registry_agent_pool_name : "${lower(var.name)}-container-registry-agent-pool-${lower(var.environment)}"
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