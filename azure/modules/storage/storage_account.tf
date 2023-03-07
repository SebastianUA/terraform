#-----------------------------------------------------------
# Azure storage account
#-----------------------------------------------------------
resource "azurerm_storage_account" "storage_account" {
  count = var.enable_storage_account ? 1 : 0

  name                     = var.storage_account_name != "" ? var.storage_account_name : "${lower(var.name)}-storage-account-${lower(var.environment)}"
  resource_group_name      = var.storage_account_resource_group_name
  location                 = var.storage_account_location
  account_tier             = var.storage_account_account_tier
  account_replication_type = var.storage_account_account_replication_type

  account_kind = var.storage_account_account_kind
  # cross_tenant_replication_enabled  = var.storage_account_cross_tenant_replication_enabled
  access_tier                       = var.storage_account_access_tier
  edge_zone                         = var.storage_account_edge_zone
  enable_https_traffic_only         = var.storage_account_enable_https_traffic_only
  min_tls_version                   = var.storage_account_min_tls_version
  allow_nested_items_to_be_public   = var.storage_account_allow_nested_items_to_be_public
  shared_access_key_enabled         = var.storage_account_shared_access_key_enabled
  is_hns_enabled                    = var.storage_account_is_hns_enabled
  nfsv3_enabled                     = var.storage_account_nfsv3_enabled
  large_file_share_enabled          = var.storage_account_large_file_share_enabled
  queue_encryption_key_type         = var.storage_account_queue_encryption_key_type
  table_encryption_key_type         = var.storage_account_table_encryption_key_type
  infrastructure_encryption_enabled = var.storage_account_infrastructure_encryption_enabled

  dynamic "custom_domain" {
    iterator = custom_domain
    for_each = length(keys(var.storage_account_custom_domain)) > 0 ? [var.storage_account_custom_domain] : []

    content {
      name = lookup(custom_domain.value, "name", null)

      use_subdomain = lookup(custom_domain.value, "use_subdomain", null)
    }
  }

  dynamic "customer_managed_key" {
    iterator = customer_managed_key
    for_each = length(keys(var.storage_account_customer_managed_key)) > 0 ? [var.storage_account_customer_managed_key] : []

    content {
      key_vault_key_id          = lookup(customer_managed_key.value, "key_vault_key_id", null)
      user_assigned_identity_id = lookup(customer_managed_key.value, "user_assigned_identity_id", null)
    }
  }

  dynamic "identity" {
    iterator = identity
    for_each = length(keys(var.storage_account_identity)) > 0 ? [var.storage_account_identity] : []

    content {
      type = lookup(identity.value, "type", null)

      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "blob_properties" {
    iterator = blob_properties
    for_each = length(keys(var.storage_account_blob_properties)) > 0 ? [var.storage_account_blob_properties] : []

    content {
      versioning_enabled       = lookup(blob_properties.value, "versioning_enabled", null)
      change_feed_enabled      = lookup(blob_properties.value, "change_feed_enabled", null)
      default_service_version  = lookup(blob_properties.value, "default_service_version", null)
      last_access_time_enabled = lookup(blob_properties.value, "last_access_time_enabled", null)
      # change_feed_retention_in_days = lookup(blob_properties.value, "change_feed_retention_in_days", null)

      # dynamic "restore_policy" {
      #   iterator = restore_policy
      #   for_each = length(keys(lookup(blob_properties.value, "restore_policy", {}))) > 0 ? [lookup(blob_properties.value, "restore_policy", {})] : []

      #   content {
      #     days    = lookup(restore_policy.value, "days", null)
      #   }
      # }

      dynamic "cors_rule" {
        iterator = cors_rule
        for_each = length(keys(lookup(blob_properties.value, "cors_rule", {}))) > 0 ? [lookup(blob_properties.value, "cors_rule", {})] : []

        content {
          allowed_headers    = lookup(cors_rule.value, "allowed_headers", null)
          allowed_methods    = lookup(cors_rule.value, "allowed_methods", null)
          allowed_origins    = lookup(cors_rule.value, "allowed_origins", null)
          exposed_headers    = lookup(cors_rule.value, "exposed_headers", null)
          max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds", null)
        }
      }

      dynamic "delete_retention_policy" {
        iterator = delete_retention_policy
        for_each = length(keys(lookup(blob_properties.value, "delete_retention_policy", {}))) > 0 ? [lookup(blob_properties.value, "delete_retention_policy", {})] : []

        content {
          days = lookup(delete_retention_policy.value, "days", null)
        }
      }

      dynamic "container_delete_retention_policy" {
        iterator = container_delete_retention_policy
        for_each = length(keys(lookup(blob_properties.value, "container_delete_retention_policy", {}))) > 0 ? [lookup(blob_properties.value, "container_delete_retention_policy", {})] : []

        content {
          days = lookup(container_delete_retention_policy.value, "days", null)
        }
      }
    }
  }

  dynamic "queue_properties" {
    iterator = queue_properties
    for_each = length(keys(var.storage_account_queue_properties)) > 0 ? [var.storage_account_queue_properties] : []

    content {
      dynamic "cors_rule" {
        iterator = cors_rule
        for_each = length(keys(lookup(queue_properties.value, "cors_rule", {}))) > 0 ? [lookup(queue_properties.value, "cors_rule", {})] : []

        content {
          allowed_headers    = lookup(cors_rule.value, "allowed_headers", null)
          allowed_methods    = lookup(cors_rule.value, "allowed_methods", null)
          allowed_origins    = lookup(cors_rule.value, "allowed_origins", null)
          exposed_headers    = lookup(cors_rule.value, "exposed_headers", null)
          max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds", null)
        }
      }

      dynamic "logging" {
        iterator = logging
        for_each = length(keys(lookup(queue_properties.value, "logging", {}))) > 0 ? [lookup(queue_properties.value, "logging", {})] : []

        content {
          delete  = lookup(logging.value, "delete", null)
          read    = lookup(logging.value, "read", null)
          version = lookup(logging.value, "version", null)
          write   = lookup(logging.value, "write", null)

          retention_policy_days = lookup(logging.value, "retention_policy_days", null)
        }
      }

      dynamic "minute_metrics" {
        iterator = minute_metrics
        for_each = length(keys(lookup(queue_properties.value, "minute_metrics", {}))) > 0 ? [lookup(queue_properties.value, "minute_metrics", {})] : []

        content {
          enabled = lookup(minute_metrics.value, "enabled", null)
          version = lookup(minute_metrics.value, "version", null)

          include_apis          = lookup(minute_metrics.value, "include_apis", null)
          retention_policy_days = lookup(minute_metrics.value, "retention_policy_days", null)
        }
      }

      dynamic "hour_metrics" {
        iterator = hour_metrics
        for_each = length(keys(lookup(queue_properties.value, "hour_metrics", {}))) > 0 ? [lookup(queue_properties.value, "hour_metrics", {})] : []

        content {
          enabled = lookup(hour_metrics.value, "enabled", null)
          version = lookup(hour_metrics.value, "version", null)

          include_apis          = lookup(hour_metrics.value, "include_apis", null)
          retention_policy_days = lookup(hour_metrics.value, "retention_policy_days", null)
        }
      }
    }
  }

  dynamic "static_website" {
    iterator = static_website
    for_each = length(keys(var.storage_account_static_website)) > 0 ? [var.storage_account_static_website] : []

    content {
      index_document     = lookup(static_website.value, "index_document", null)
      error_404_document = lookup(static_website.value, "error_404_document", null)
    }
  }

  dynamic "share_properties" {
    iterator = share_properties
    for_each = length(keys(var.storage_account_share_properties)) > 0 ? [var.storage_account_share_properties] : []

    content {
      dynamic "cors_rule" {
        iterator = cors_rule
        for_each = length(keys(lookup(share_properties.value, "cors_rule", {}))) > 0 ? [lookup(share_properties.value, "cors_rule", {})] : []

        content {
          allowed_headers    = lookup(cors_rule.value, "allowed_headers", null)
          allowed_methods    = lookup(cors_rule.value, "allowed_methods", null)
          allowed_origins    = lookup(cors_rule.value, "allowed_origins", null)
          exposed_headers    = lookup(cors_rule.value, "exposed_headers", null)
          max_age_in_seconds = lookup(cors_rule.value, "max_age_in_seconds", null)
        }
      }

      dynamic "retention_policy" {
        iterator = retention_policy
        for_each = length(keys(lookup(share_properties.value, "retention_policy", {}))) > 0 ? [lookup(share_properties.value, "retention_policy", {})] : []

        content {
          days = lookup(retention_policy.value, "days", null)
        }
      }

      dynamic "smb" {
        iterator = smb
        for_each = length(keys(lookup(share_properties.value, "smb", {}))) > 0 ? [lookup(share_properties.value, "smb", {})] : []

        content {
          versions                        = lookup(smb.value, "versions", null)
          authentication_types            = lookup(smb.value, "authentication_types", null)
          kerberos_ticket_encryption_type = lookup(smb.value, "kerberos_ticket_encryption_type", null)
          channel_encryption_type         = lookup(smb.value, "channel_encryption_type", null)
        }
      }

    }
  }

  dynamic "network_rules" {
    iterator = network_rules
    for_each = length(keys(var.storage_account_network_rules)) > 0 ? [var.storage_account_network_rules] : []

    content {
      default_action = lookup(network_rules.value, "default_action", null)

      bypass                     = lookup(network_rules.value, "bypass", null)
      ip_rules                   = lookup(network_rules.value, "ip_rules", null)
      virtual_network_subnet_ids = lookup(network_rules.value, "virtual_network_subnet_ids", null)

      dynamic "private_link_access" {
        iterator = private_link_access
        for_each = length(keys(lookup(network_rules.value, "private_link_access", {}))) > 0 ? [lookup(network_rules.value, "private_link_access", {})] : []

        content {
          endpoint_resource_id = lookup(private_link_access.value, "endpoint_resource_id", null)

          endpoint_tenant_id = lookup(private_link_access.value, "endpoint_tenant_id", null)
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    iterator = azure_files_authentication
    for_each = length(keys(var.storage_account_azure_files_authentication)) > 0 ? [var.storage_account_azure_files_authentication] : []

    content {
      directory_type = lookup(azure_files_authentication.value, "directory_type", null)

      dynamic "active_directory" {
        iterator = active_directory
        for_each = length(keys(lookup(azure_files_authentication.value, "active_directory", {}))) > 0 ? [lookup(azure_files_authentication.value, "active_directory", {})] : []

        content {
          storage_sid         = lookup(active_directory.value, "storage_sid", null)
          domain_name         = lookup(active_directory.value, "domain_name", null)
          domain_sid          = lookup(active_directory.value, "domain_sid", null)
          domain_guid         = lookup(active_directory.value, "domain_guid", null)
          forest_name         = lookup(active_directory.value, "forest_name", null)
          netbios_domain_name = lookup(active_directory.value, "netbios_domain_name", null)
        }
      }
    }
  }

  dynamic "routing" {
    iterator = routing
    for_each = length(keys(var.storage_account_routing)) > 0 ? [var.storage_account_routing] : []

    content {
      publish_internet_endpoints  = lookup(routing.value, "publish_internet_endpoints", null)
      publish_microsoft_endpoints = lookup(routing.value, "publish_microsoft_endpoints", null)
      choice                      = lookup(routing.value, "choice", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_account_timeouts)) > 0 ? [var.storage_account_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.storage_account_name != "" ? var.storage_account_name : "${lower(var.name)}-storage-account-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
