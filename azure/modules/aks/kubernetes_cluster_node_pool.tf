#-----------------------------------------------------------
# Azure kubernetes cluster node pool
#-----------------------------------------------------------
resource "azurerm_kubernetes_cluster_node_pool" "kubernetes_cluster_node_pool" {
  count = var.enable_kubernetes_cluster_node_pool ? 1 : 0

  name                  = var.kubernetes_cluster_node_pool_name != "" ? var.kubernetes_cluster_node_pool_name : "${lower(var.name)}-k8s-cluster-node-pool-${lower(var.environment)}"
  kubernetes_cluster_id = var.kubernetes_cluster_node_pool_kubernetes_cluster_id != "" ? var.kubernetes_cluster_node_pool_kubernetes_cluster_id : (var.enable_kubernetes_cluster ? azurerm_kubernetes_cluster.kubernetes_cluster[count.index].id : null)
  vm_size               = var.kubernetes_cluster_node_pool_vm_size

  enable_auto_scaling          = var.kubernetes_cluster_node_pool_enable_auto_scaling
  enable_host_encryption       = var.kubernetes_cluster_node_pool_enable_host_encryption
  enable_node_public_ip        = var.kubernetes_cluster_node_pool_enable_node_public_ip
  eviction_policy              = var.kubernetes_cluster_node_pool_eviction_policy
  fips_enabled                 = var.kubernetes_cluster_node_pool_fips_enabled
  kubelet_disk_type            = var.kubernetes_cluster_node_pool_kubelet_disk_type
  max_pods                     = var.kubernetes_cluster_node_pool_max_pods
  mode                         = var.kubernetes_cluster_node_pool_mode
  node_labels                  = var.kubernetes_cluster_node_pool_node_labels
  node_public_ip_prefix_id     = var.kubernetes_cluster_node_pool_node_public_ip_prefix_id
  node_taints                  = var.kubernetes_cluster_node_pool_node_taints
  orchestrator_version         = var.kubernetes_cluster_node_pool_orchestrator_version
  os_disk_size_gb              = var.kubernetes_cluster_node_pool_os_disk_size_gb
  os_disk_type                 = var.kubernetes_cluster_node_pool_os_disk_type
  pod_subnet_id                = var.kubernetes_cluster_node_pool_pod_subnet_id
  os_sku                       = var.kubernetes_cluster_node_pool_os_sku
  os_type                      = var.kubernetes_cluster_node_pool_os_type
  priority                     = var.kubernetes_cluster_node_pool_priority
  proximity_placement_group_id = var.kubernetes_cluster_node_pool_proximity_placement_group_id
  spot_max_price               = var.kubernetes_cluster_node_pool_spot_max_price
  scale_down_mode              = var.kubernetes_cluster_node_pool_scale_down_mode
  ultra_ssd_enabled            = var.kubernetes_cluster_node_pool_ultra_ssd_enabled
  vnet_subnet_id               = var.kubernetes_cluster_node_pool_vnet_subnet_id
  workload_runtime             = var.kubernetes_cluster_node_pool_workload_runtime
  zones                        = var.kubernetes_cluster_node_pool_zones
  node_count                   = var.kubernetes_cluster_node_pool_node_count
  max_count                    = var.kubernetes_cluster_node_pool_max_count
  min_count                    = var.kubernetes_cluster_node_pool_min_count

  dynamic "kubelet_config" {
    iterator = kubelet_config
    for_each = [var.kubernetes_cluster_node_pool_kubelet_config]

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
    for_each = [var.kubernetes_cluster_node_pool_linux_os_config]

    content {
      swap_file_size_mb             = lookup(linux_os_config.value, "swap_file_size_mb", null)
      sysctl_config                 = lookup(linux_os_config.value, "sysctl_config", null)
      transparent_huge_page_defrag  = lookup(linux_os_config.value, "transparent_huge_page_defrag", null)
      transparent_huge_page_enabled = lookup(linux_os_config.value, "transparent_huge_page_enabled", null)
    }
  }

  dynamic "upgrade_settings" {
    iterator = upgrade_settings
    for_each = [var.kubernetes_cluster_node_pool_upgrade_settings]

    content {
      max_surge = lookup(upgrade_settings.value, "max_surge", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kubernetes_cluster_node_pool_timeouts)) > 0 ? [var.kubernetes_cluster_node_pool_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.kubernetes_cluster_node_pool_name != "" ? var.kubernetes_cluster_node_pool_name : "${lower(var.name)}-k8s-cluster-node-pool-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_kubernetes_cluster.kubernetes_cluster
  ]
}