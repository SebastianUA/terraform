#-----------------------------------------------------------
# Azure kubernetes cluster
#-----------------------------------------------------------
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  count = var.enable_kubernetes_cluster ? 1 : 0

  name                = var.kubernetes_cluster_name != "" ? var.kubernetes_cluster_name : "${lower(var.name)}-k8s-cluster-${lower(var.environment)}"
  location            = var.kubernetes_cluster_location
  resource_group_name = var.kubernetes_cluster_resource_group_name
  oidc_issuer_enabled = var.kubernetes_cluster_oidc_issuer_enabled

  dynamic "default_node_pool" {
    iterator = default_node_pool
    for_each = [var.kubernetes_cluster_default_node_pool]

    content {
      name    = lookup(default_node_pool.value, "name", null)
      vm_size = lookup(default_node_pool.value, "vm_size", null)

      enable_auto_scaling    = lookup(default_node_pool.value, "enable_auto_scaling", null)
      enable_host_encryption = lookup(default_node_pool.value, "enable_host_encryption", null)
      enable_node_public_ip  = lookup(default_node_pool.value, "enable_node_public_ip", null)
      fips_enabled           = lookup(default_node_pool.value, "enable_node_public_ip", null)
      node_count             = lookup(default_node_pool.value, "node_count", null)

      dynamic "kubelet_config" {
        iterator = kubelet_config
        for_each = lookup(default_node_pool.value, "kubelet_config", [])

        content {
          allowed_unsafe_sysctls    = lookup(kubelet_config.value, "allowed_unsafe_sysctls", null)
          container_log_max_line    = lookup(kubelet_config.value, "container_log_max_line", null)
          container_log_max_size_mb = lookup(kubelet_config.value, "container_log_max_size_mb", null)
          cpu_cfs_quota_enabled     = lookup(kubelet_config.value, "cpu_cfs_quota_enabled", null)
          cpu_cfs_quota_period      = lookup(kubelet_config.value, "cpu_cfs_quota_period", null)
          cpu_manager_policy        = lookup(kubelet_config.value, "cpu_manager_policy", null)
          image_gc_high_threshold   = lookup(kubelet_config.value, "image_gc_high_threshold", null)
          image_gc_low_threshold    = lookup(kubelet_config.value, "image_gc_low_threshold", null)
          pod_max_pid               = lookup(kubelet_config.value, "pod_max_pid", null)
          topology_manager_policy   = lookup(kubelet_config.value, "topology_manager_policy", null)
        }
      }

      dynamic "linux_os_config" {
        iterator = linux_os_config
        for_each = lookup(default_node_pool.value, "linux_os_config", [])

        content {
          swap_file_size_mb             = lookup(linux_os_config.value, "swap_file_size_mb", null)
          sysctl_config                 = lookup(linux_os_config.value, "sysctl_config", null)
          transparent_huge_page_defrag  = lookup(linux_os_config.value, "transparent_huge_page_defrag", null)
          transparent_huge_page_enabled = lookup(linux_os_config.value, "transparent_huge_page_enabled", null)
        }
      }
    }
  }

  dns_prefix                          = var.kubernetes_cluster_dns_prefix
  dns_prefix_private_cluster          = var.kubernetes_cluster_dns_prefix_private_cluster
  automatic_channel_upgrade           = var.kubernetes_cluster_automatic_channel_upgrade
  api_server_authorized_ip_ranges     = var.kubernetes_cluster_api_server_authorized_ip_ranges
  azure_policy_enabled                = var.kubernetes_cluster_azure_policy_enabled
  disk_encryption_set_id              = var.kubernetes_cluster_disk_encryption_set_id
  http_application_routing_enabled    = var.kubernetes_cluster_http_application_routing_enabled
  kubernetes_version                  = var.kubernetes_cluster_kubernetes_version
  local_account_disabled              = var.kubernetes_cluster_local_account_disabled
  node_resource_group                 = var.kubernetes_cluster_node_resource_group
  open_service_mesh_enabled           = var.kubernetes_cluster_open_service_mesh_enabled
  private_cluster_enabled             = var.kubernetes_cluster_private_cluster_enabled
  private_dns_zone_id                 = var.kubernetes_cluster_private_dns_zone_id
  private_cluster_public_fqdn_enabled = var.kubernetes_cluster_private_cluster_public_fqdn_enabled
  public_network_access_enabled       = var.kubernetes_cluster_public_network_access_enabled
  role_based_access_control_enabled   = var.kubernetes_cluster_role_based_access_control_enabled
  run_command_enabled                 = var.kubernetes_cluster_run_command_enabled
  sku_tier                            = var.kubernetes_cluster_sku_tier

  dynamic "service_principal" {
    iterator = service_principal
    for_each = [var.kubernetes_cluster_service_principal]

    content {
      client_id     = lookup(service_principal.value, "client_id", null)
      client_secret = lookup(service_principal.value, "client_secret", null)
    }
  }

  dynamic "aci_connector_linux" {
    iterator = aci_connector_linux
    for_each = [var.kubernetes_cluster_aci_connector_linux]

    content {
      subnet_name = lookup(aci_connector_linux.value, "subnet_name", null)
    }
  }

  dynamic "auto_scaler_profile" {
    iterator = auto_scaler_profile
    for_each = var.kubernetes_cluster_auto_scaler_profile

    content {
      balance_similar_node_groups      = lookup(auto_scaler_profile.value, "balance_similar_node_groups", null)
      expander                         = lookup(auto_scaler_profile.value, "expander", null)
      max_graceful_termination_sec     = lookup(auto_scaler_profile.value, "max_graceful_termination_sec", null)
      max_node_provisioning_time       = lookup(auto_scaler_profile.value, "max_node_provisioning_time", null)
      max_unready_nodes                = lookup(auto_scaler_profile.value, "max_unready_nodes", null)
      max_unready_percentage           = lookup(auto_scaler_profile.value, "max_unready_percentage", null)
      new_pod_scale_up_delay           = lookup(auto_scaler_profile.value, "new_pod_scale_up_delay", null)
      scale_down_delay_after_add       = lookup(auto_scaler_profile.value, "scale_down_delay_after_add", null)
      scale_down_delay_after_delete    = lookup(auto_scaler_profile.value, "scale_down_delay_after_delete", null)
      scale_down_delay_after_failure   = lookup(auto_scaler_profile.value, "scale_down_delay_after_failure", null)
      scan_interval                    = lookup(auto_scaler_profile.value, "scan_interval", null)
      scale_down_unneeded              = lookup(auto_scaler_profile.value, "scale_down_unneeded", null)
      scale_down_unready               = lookup(auto_scaler_profile.value, "scale_down_unready", null)
      scale_down_utilization_threshold = lookup(auto_scaler_profile.value, "scale_down_utilization_threshold", null)
      empty_bulk_delete_max            = lookup(auto_scaler_profile.value, "empty_bulk_delete_max", null)
      skip_nodes_with_local_storage    = lookup(auto_scaler_profile.value, "skip_nodes_with_local_storage", null)
      skip_nodes_with_system_pods      = lookup(auto_scaler_profile.value, "skip_nodes_with_system_pods", null)
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    iterator = azure_active_directory_role_based_access_control
    for_each = var.kubernetes_cluster_azure_active_directory_role_based_access_control

    content {
      managed   = lookup(azure_active_directory_role_based_access_control.value, "managed", null)
      tenant_id = lookup(azure_active_directory_role_based_access_control.value, "tenant_id", null)

      # If Managed true
      admin_group_object_ids = lookup(azure_active_directory_role_based_access_control.value, "admin_group_object_ids", null)
      azure_rbac_enabled     = lookup(azure_active_directory_role_based_access_control.value, "azure_rbac_enabled", null)

      # If Managed false
      client_app_id     = lookup(azure_active_directory_role_based_access_control.value, "client_app_id", null)
      server_app_id     = lookup(azure_active_directory_role_based_access_control.value, "server_app_id", null)
      server_app_secret = lookup(azure_active_directory_role_based_access_control.value, "server_app_secret", null)
    }
  }

  dynamic "http_proxy_config" {
    iterator = http_proxy_config
    for_each = var.kubernetes_cluster_http_proxy_config

    content {
      http_proxy  = lookup(http_proxy_config.value, "http_proxy", null)
      https_proxy = lookup(http_proxy_config.value, "https_proxy", null)
      no_proxy    = lookup(http_proxy_config.value, "no_proxy", null)
      trusted_ca  = lookup(http_proxy_config.value, "trusted_ca", null)
    }
  }

  dynamic "identity" {
    iterator = identity
    for_each = length(keys(var.kubernetes_cluster_identity)) > 0 ? [var.kubernetes_cluster_identity] : []

    content {
      type = lookup(identity.value, "type", null)

      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "ingress_application_gateway" {
    iterator = ingress_application_gateway
    for_each = [var.kubernetes_cluster_ingress_application_gateway]

    content {
      gateway_id   = lookup(ingress_application_gateway.value, "gateway_id", null)
      gateway_name = lookup(ingress_application_gateway.value, "gateway_name", null)
      subnet_cidr  = lookup(ingress_application_gateway.value, "subnet_cidr", null)
      subnet_id    = lookup(ingress_application_gateway.value, "subnet_id", null)
    }
  }

  dynamic "key_vault_secrets_provider" {
    iterator = key_vault_secrets_provider
    for_each = [var.kubernetes_cluster_key_vault_secrets_provider]

    content {
      dynamic "secret_identity" {
        iterator = secret_identity
        for_each = lookup(key_vault_secrets_provider.value, "secret_identity", [])

        content {
          client_id                 = lookup(secret_identity.value, "client_id", null)
          object_id                 = lookup(secret_identity.value, "object_id", null)
          user_assigned_identity_id = lookup(secret_identity.value, "user_assigned_identity_id", null)
        }
      }
    }
  }

  dynamic "kubelet_identity" {
    iterator = kubelet_identity
    for_each = [var.kubernetes_cluster_kubelet_identity]

    content {
      client_id                 = lookup(kubelet_identity.value, "client_id", null)
      object_id                 = lookup(kubelet_identity.value, "object_id", null)
      user_assigned_identity_id = lookup(kubelet_identity.value, "user_assigned_identity_id", null)
    }
  }

  dynamic "linux_profile" {
    iterator = linux_profile
    for_each = [var.kubernetes_cluster_linux_profile]

    content {
      admin_username = lookup(linux_profile.value, "admin_username", null)
      ssh_key        = lookup(linux_profile.value, "ssh_key", null)
    }
  }

  dynamic "maintenance_window" {
    iterator = maintenance_window
    for_each = [var.kubernetes_cluster_maintenance_window]

    content {
      dynamic "allowed" {
        iterator = allowed
        for_each = lookup(maintenance_window.value, "allowed", [])

        content {
          day   = lookup(allowed.value, "day", null)
          hours = lookup(allowed.value, "hours", null)
        }
      }

      dynamic "not_allowed" {
        iterator = not_allowed
        for_each = lookup(maintenance_window.value, "not_allowed", [])

        content {
          end   = lookup(not_allowed.value, "end", null)
          start = lookup(not_allowed.value, "start", null)
        }
      }
    }
  }

  dynamic "microsoft_defender" {
    iterator = microsoft_defender
    for_each = [var.kubernetes_cluster_microsoft_defender]

    content {
      log_analytics_workspace_id = lookup(microsoft_defender.value, "log_analytics_workspace_id", null)
    }
  }

  dynamic "network_profile" {
    iterator = network_profile
    for_each = [var.kubernetes_cluster_network_profile]

    content {
      network_plugin = lookup(network_profile.value, "network_plugin", null)

      network_mode       = lookup(network_profile.value, "network_mode", null)
      network_policy     = lookup(network_profile.value, "network_policy", null)
      dns_service_ip     = lookup(network_profile.value, "dns_service_ip", null)
      docker_bridge_cidr = lookup(network_profile.value, "docker_bridge_cidr", null)
      outbound_type      = lookup(network_profile.value, "outbound_type", null)
    }
  }

  dynamic "oms_agent" {
    iterator = oms_agent
    for_each = [var.kubernetes_cluster_oms_agent]

    content {
      log_analytics_workspace_id = lookup(oms_agent.value, "log_analytics_workspace_id", null)
    }
  }

  dynamic "windows_profile" {
    iterator = windows_profile
    for_each = [var.kubernetes_cluster_windows_profile]

    content {
      admin_username = lookup(windows_profile.value, "admin_username", null)
      admin_password = lookup(windows_profile.value, "admin_password", null)

      license = lookup(windows_profile.value, "license", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kubernetes_cluster_timeouts)) > 0 ? [var.kubernetes_cluster_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.kubernetes_cluster_name != "" ? var.kubernetes_cluster_name : "${lower(var.name)}-k8s-cluster-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}