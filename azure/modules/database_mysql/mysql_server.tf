#-----------------------------------------------------------
# Azure mysql server
#-----------------------------------------------------------
resource "azurerm_mysql_server" "mysql_server" {
  count = var.enable_mysql_server ? 1 : 0

  name                = var.mysql_server_name != "" ? var.mysql_server_name : "${lower(var.name)}-mysql-server-${lower(var.environment)}"
  resource_group_name = var.mysql_server_resource_group_name
  location            = var.mysql_server_location
  sku_name            = var.mysql_server_sku_name
  version             = var.mysql_server_version

  create_mode                  = var.mysql_server_create_mode
  creation_source_server_id    = var.mysql_server_creation_source_server_id
  administrator_login          = var.mysql_server_administrator_login
  administrator_login_password = var.mysql_server_administrator_login_password

  auto_grow_enabled            = var.mysql_server_auto_grow_enabled
  backup_retention_days        = var.mysql_server_backup_retention_days
  restore_point_in_time        = var.mysql_server_restore_point_in_time
  geo_redundant_backup_enabled = var.mysql_server_geo_redundant_backup_enabled


  public_network_access_enabled = var.mysql_server_public_network_access_enabled

  infrastructure_encryption_enabled = var.mysql_server_infrastructure_encryption_enabled
  ssl_enforcement_enabled           = var.mysql_server_ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = var.mysql_server_ssl_minimal_tls_version_enforced

  storage_mb = var.mysql_server_storage_mb

  dynamic "identity" {
    iterator = identity
    for_each = length(keys(var.mysql_server_identity)) > 0 ? [var.mysql_server_identity] : []

    content {
      type = lookup(identity.value, "type", null)
    }
  }

  dynamic "threat_detection_policy" {
    iterator = threat_detection_policy
    for_each = length(keys(var.mysql_server_threat_detection_policy)) > 0 ? [var.mysql_server_threat_detection_policy] : []

    content {
      enabled = lookup(threat_detection_policy.value, "enabled", null)

      disabled_alerts            = lookup(threat_detection_policy.value, "disabled_alerts", null)
      email_account_admins       = lookup(threat_detection_policy.value, "email_account_admins", null)
      email_addresses            = lookup(threat_detection_policy.value, "email_addresses", null)
      retention_days             = lookup(threat_detection_policy.value, "retention_days", null)
      storage_account_access_key = lookup(threat_detection_policy.value, "storage_account_access_key", null)
      storage_endpoint           = lookup(threat_detection_policy.value, "storage_endpoint", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.mysql_server_timeouts)) > 0 ? [var.mysql_server_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.mysql_server_name != "" ? var.mysql_server_name : "${lower(var.name)}-mysql-server-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}