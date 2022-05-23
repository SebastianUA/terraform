#-----------------------------------------------------------
# Azure databricks workspace
#-----------------------------------------------------------
resource "azurerm_databricks_workspace" "databricks_workspace" {
  count = var.enable_databricks_workspace ? 1 : 0

  name                = var.databricks_workspace_name != "" ? var.databricks_workspace_name : "${lower(var.name)}-databricks-workspace-${lower(var.environment)}"
  resource_group_name = var.databricks_workspace_resource_group_name
  location            = var.databricks_workspace_location
  sku                 = var.databricks_workspace_sku

  load_balancer_backend_address_pool_id = var.databricks_workspace_load_balancer_backend_address_pool_id
  managed_services_cmk_key_vault_key_id = var.databricks_workspace_managed_services_cmk_key_vault_key_id
  managed_resource_group_name           = var.databricks_workspace_managed_resource_group_name
  customer_managed_key_enabled          = var.databricks_workspace_customer_managed_key_enabled
  infrastructure_encryption_enabled     = var.databricks_workspace_infrastructure_encryption_enabled
  public_network_access_enabled         = var.databricks_workspace_public_network_access_enabled
  network_security_group_rules_required = var.databricks_workspace_network_security_group_rules_required

  dynamic "custom_parameters" {
    iterator = custom_parameters
    for_each = [var.databricks_workspace_custom_parameters]

    content {
      machine_learning_workspace_id                        = lookup(custom_parameters.value, "machine_learning_workspace_id", null)
      nat_gateway_name                                     = lookup(custom_parameters.value, "nat_gateway_name", null)
      public_ip_name                                       = lookup(custom_parameters.value, "public_ip_name", null)
      no_public_ip                                         = lookup(custom_parameters.value, "no_public_ip", null)
      public_subnet_name                                   = lookup(custom_parameters.value, "public_subnet_name", null)
      public_subnet_network_security_group_association_id  = lookup(custom_parameters.value, "public_subnet_network_security_group_association_id", null)
      private_subnet_name                                  = lookup(custom_parameters.value, "private_subnet_name", null)
      private_subnet_network_security_group_association_id = lookup(custom_parameters.value, "private_subnet_network_security_group_association_id", null)
      storage_account_name                                 = lookup(custom_parameters.value, "storage_account_name", null)
      storage_account_sku_name                             = lookup(custom_parameters.value, "storage_account_sku_name", null)
      virtual_network_id                                   = lookup(custom_parameters.value, "virtual_network_id", null)
      vnet_address_prefix                                  = lookup(custom_parameters.value, "vnet_address_prefix", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.databricks_workspace_timeouts)) > 0 ? [var.databricks_workspace_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.databricks_workspace_name != "" ? var.databricks_workspace_name : "${lower(var.name)}-databricks-workspace-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}