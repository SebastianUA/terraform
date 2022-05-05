#-----------------------------------------------------------
# Azure active directory domain service
#-----------------------------------------------------------
resource "azurerm_active_directory_domain_service" "active_directory_domain_service" {
  count = var.enable_active_directory_domain_service ? 1 : 0

  name                = var.active_directory_domain_service_name != "" ? var.active_directory_domain_service_name : "${lower(var.name)}-ad-domain-service-identity-${lower(var.environment)}"
  location            = var.active_directory_domain_service_location
  resource_group_name = var.active_directory_domain_service_resource_group_name
  sku                 = var.active_directory_domain_service_sku
  domain_name         = var.active_directory_domain_service_domain_name

  dynamic "initial_replica_set" {
    iterator = initial_replica_set
    for_each = var.active_directory_domain_service_initial_replica_set

    content {
      subnet_id = lookup(initial_replica_set.value, "subnet_id", null)
    }
  }

  filtered_sync_enabled = var.active_directory_domain_service_filtered_sync_enabled

  dynamic "secure_ldap" {
    iterator = secure_ldap
    for_each = var.active_directory_domain_service_secure_ldap

    content {
      enabled                  = lookup(secure_ldap.value, "enabled", null)
      pfx_certificate          = lookup(secure_ldap.value, "pfx_certificate", null)
      pfx_certificate_password = lookup(secure_ldap.value, "pfx_certificate_password", null)

      external_access_enabled = lookup(secure_ldap.value, "external_access_enabled", null)
    }
  }

  dynamic "notifications" {
    iterator = notifications
    for_each = var.user_assigned_identity_notifications

    content {
      additional_recipients = lookup(notifications.value, "additional_recipients", null)
      notify_dc_admins      = lookup(notifications.value, "notify_dc_admins", null)
      notify_global_admins  = lookup(notifications.value, "notify_global_admins", null)
    }
  }

  dynamic "security" {
    iterator = security
    for_each = length(keys(var.user_assigned_identity_security)) > 0 ? [var.user_assigned_identity_security] : []

    content {
      sync_kerberos_passwords = lookup(security.value, "sync_kerberos_passwords", null)
      sync_ntlm_passwords     = lookup(security.value, "sync_ntlm_passwords", null)
      sync_on_prem_passwords  = lookup(security.value, "sync_on_prem_passwords", null)
      ntlm_v1_enabled         = lookup(security.value, "ntlm_v1_enabled", null)
      tls_v1_enabled          = lookup(security.value, "tls_v1_enabled", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.user_assigned_identity_timeouts)) > 0 ? [var.user_assigned_identity_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.active_directory_domain_service_name != "" ? var.active_directory_domain_service_name : "${lower(var.name)}-ad-domain-service-identity-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}