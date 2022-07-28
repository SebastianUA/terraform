#-----------------------------------------------------------
# Azure subnet
#-----------------------------------------------------------
resource "azurerm_subnet" "subnet" {
  count = var.enable_subnet ? 1 : 0

  name                 = var.subnet_name != "" ? var.subnet_name : "${lower(var.name)}-subnet-${lower(var.environment)}"
  resource_group_name  = var.subnet_resource_group_name
  virtual_network_name = var.subnet_virtual_network_name != "" ? var.subnet_virtual_network_name : (var.enable_virtual_network ? azurerm_virtual_network.virtual_network[0].name : null)
  address_prefixes     = var.subnet_address_prefixes

  enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  enforce_private_link_service_network_policies  = var.subnet_enforce_private_link_service_network_policies

  service_endpoints           = var.subnet_service_endpoints
  service_endpoint_policy_ids = var.subnet_service_endpoint_policy_ids

  dynamic "delegation" {
    iterator = delegation
    for_each = var.subnet_delegation

    content {
      name = lookup(delegation.value, "name", null)

      dynamic "service_delegation" {
        iterator = service_delegation
        for_each = lookup(delegation.value, "service_delegation", [])

        content {
          name = lookup(service_delegation.value, "name", null)

          actions = lookup(service_delegation.value, "actions", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subnet_timeouts)) > 0 ? [var.subnet_timeouts] : []

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

  depends_on = []
}