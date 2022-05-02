#-----------------------------------------------------------
# Azure disk pool
#-----------------------------------------------------------
resource "azurerm_disk_pool" "disk_pool" {
  count = var.enable_disk_pool ? 1 : 0

  name                = var.disk_pool_name != "" ? var.disk_pool_name : "${lower(var.name)}-disk-pool-${lower(var.environment)}"
  resource_group_name = var.disk_pool_resource_group_name
  location            = var.disk_pool_location
  sku_name            = var.disk_pool_sku_name
  subnet_id           = var.disk_pool_subnet_id
  zones               = var.disk_pool_zones

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.disk_pool_timeouts)) > 0 ? [var.disk_pool_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.disk_pool_name != "" ? var.disk_pool_name : "${lower(var.name)}-disk-pool-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
