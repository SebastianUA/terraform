#-----------------------------------------------------------
# Azure container registry
#-----------------------------------------------------------
resource "azurerm_container_registry" "container_registry" {
  count = var.enable_container_registry ? 1 : 0

  name                = var.container_registry_name != "" ? var.container_registry_name : "${lower(var.name)}-container-registry-${lower(var.environment)}"
  resource_group_name = var.container_registry_resource_group_name
  location            = var.container_registry_location
  sku                 = var.container_registry_sku

  admin_enabled                 = var.container_registry_admin_enabled
  public_network_access_enabled = var.container_registry_public_network_access_enabled
  quarantine_policy_enabled     = var.container_registry_quarantine_policy_enabled
  zone_redundancy_enabled       = var.container_registry_zone_redundancy_enabled
  export_policy_enabled         = var.container_registry_export_policy_enabled
  anonymous_pull_enabled        = var.container_registry_anonymous_pull_enabled
  data_endpoint_enabled         = var.container_registry_data_endpoint_enabled
  network_rule_bypass_option    = var.container_registry_network_rule_bypass_option

  dynamic "georeplications" {
    iterator = georeplications
    for_each = var.container_registry_georeplications

    content {
      location = lookup(georeplications.value, "location", null)

      regional_endpoint_enabled = lookup(georeplications.value, "regional_endpoint_enabled", null)
      zone_redundancy_enabled   = lookup(georeplications.value, "zone_redundancy_enabled", null)
      tags                      = lookup(georeplications.value, "tags", null)
    }
  }

  dynamic "network_rule_set" {
    iterator = network_rule_set
    for_each = var.container_registry_network_rule_set

    content {
      default_action = lookup(network_rule_set.value, "default_action", null)

      dynamic "virtual_network" {
        iterator = virtual_network
        for_each = lookup(network_rule_set.value, "virtual_network", [])

        content {
          action    = lookup(virtual_network.value, "action", null)
          subnet_id = lookup(virtual_network.value, "subnet_id", null)
        }
      }

      dynamic "ip_rule" {
        iterator = ip_rule
        for_each = lookup(network_rule_set.value, "ip_rule", [])

        content {
          action   = lookup(ip_rule.value, "action", null)
          ip_range = lookup(ip_rule.value, "action", null)
        }
      }
    }
  }

  dynamic "retention_policy" {
    iterator = retention_policy
    for_each = [var.container_registry_retention_policy]

    content {
      days    = lookup(retention_policy.value, "days", null)
      enabled = lookup(retention_policy.value, "enabled", null)
    }
  }

  dynamic "trust_policy" {
    iterator = trust_policy
    for_each = [var.container_registry_trust_policy]

    content {
      enabled = lookup(trust_policy.value, "enabled", null)
    }
  }

  dynamic "identity" {
    iterator = identity
    for_each = [var.container_registry_identity]

    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "encryption" {
    iterator = encryption
    for_each = [var.container_registry_encryption]

    content {
      key_vault_key_id   = lookup(encryption.value, "key_vault_key_id", null)
      identity_client_id = lookup(encryption.value, "identity_client_id", null)

      enabled = lookup(encryption.value, "enabled", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.container_registry_timeouts)) > 0 ? [var.container_registry_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.container_registry_name != "" ? var.container_registry_name : "${lower(var.name)}-container-registry-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}