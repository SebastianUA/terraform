#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "this"
}

variable "environment" {
  description = "Environment for service"
  default     = "test"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# Azure kubernetes cluster
#-----------------------------------------------------------
variable "enable_kubernetes_cluster" {
  description = "Enable kubernetes cluster usage"
  default     = false
}

variable "kubernetes_cluster_name" {
  description = "The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
  default     = ""
}

variable "kubernetes_cluster_location" {
  description = "(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_resource_group_name" {
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_dns_prefix" {
  description = "(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_default_node_pool" {
  description = "(Required) A default_node_pool block"
  default     = {}
}

variable "kubernetes_cluster_dns_prefix_private_cluster" {
  description = "Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_automatic_channel_upgrade" {
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none."
  default     = null
}

variable "kubernetes_cluster_api_server_authorized_ip_ranges" {
  description = "(Optional) The IP ranges to allow for incoming traffic to the server nodes."
  default     = null
}

variable "kubernetes_cluster_azure_policy_enabled" {
  description = "(Optional) Should the Azure Policy Add-On be enabled? For more details please visit Understand Azure Policy for Azure Kubernetes Service"
  default     = null
}

variable "kubernetes_cluster_disk_encryption_set_id" {
  description = "(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information can be found in the documentation."
  default     = null
}

variable "kubernetes_cluster_http_application_routing_enabled" {
  description = "(Optional) Should HTTP Application Routing be enabled?"
  default     = null
}

variable "kubernetes_cluster_kubernetes_version" {
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
  default     = null
}

variable "kubernetes_cluster_local_account_disabled" {
  description = "(Optional) - If true local accounts will be disabled. Defaults to false. See the documentation for more information."
  default     = null
}

variable "kubernetes_cluster_node_resource_group" {
  description = "(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_open_service_mesh_enabled" {
  description = "(Optional) Is Open Service Mesh enabled? For more details, please visit Open Service Mesh for AKS."
  default     = null
}

variable "kubernetes_cluster_private_cluster_enabled" {
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_private_dns_zone_id" {
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_private_cluster_public_fqdn_enabled" {
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false."
  default     = null
}

variable "kubernetes_cluster_public_network_access_enabled" {
  description = "(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_role_based_access_control_enabled" {
  description = "(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_run_command_enabled" {
  description = "(Optional) Whether to enable run command for the cluster or not. Defaults to true."
  default     = null
}

variable "kubernetes_cluster_service_principal" {
  description = "(Optional) A service_principal block. One of either identity or service_principal must be specified."
  default     = {}
}

variable "kubernetes_cluster_sku_tier" {
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
  default     = null
}

variable "kubernetes_cluster_aci_connector_linux" {
  description = "(Optional) A aci_connector_linux block. For more details, please visit Create and configure an AKS cluster to use virtual nodes."
  default     = {}
}

variable "kubernetes_cluster_auto_scaler_profile" {
  description = "(Optional) A auto_scaler_profile block"
  default     = []
}

variable "kubernetes_cluster_azure_active_directory_role_based_access_control" {
  description = "(Optional) - A azure_active_directory_role_based_access_control block"
  default     = {}
}

variable "kubernetes_cluster_http_proxy_config" {
  description = "(Optional) A http_proxy_config block"
  default     = {}
}

variable "kubernetes_cluster_identity" {
  description = "(Optional) An identity block. One of either identity or service_principal must be specified."
  default     = {}
}

variable "kubernetes_cluster_ingress_application_gateway" {
  description = "(Optional) A ingress_application_gateway block."
  default     = {}
}

variable "kubernetes_cluster_key_vault_secrets_provider" {
  description = "(Optional) A key_vault_secrets_provider block as defined below. For more details, please visit Azure Keyvault Secrets Provider for AKS."
  default     = {}
}

variable "kubernetes_cluster_kubelet_identity" {
  description = "A kubelet_identity block. Changing this forces a new resource to be created."
  default     = {}
}

variable "kubernetes_cluster_linux_profile" {
  description = "(Optional) A linux_profile block"
  default     = {}
}

variable "kubernetes_cluster_maintenance_window" {
  description = "(Optional) A maintenance_window block"
  default     = {}
}

variable "kubernetes_cluster_microsoft_defender" {
  description = "(Optional) A microsoft_defender block"
  default     = {}
}

variable "kubernetes_cluster_network_profile" {
  description = "(Optional) A network_profile block"
  default     = {}
}

variable "kubernetes_cluster_oms_agent" {
  description = "(Optional) A oms_agent block"
  default     = {}
}

variable "kubernetes_cluster_windows_profile" {
  description = "(Optional) A windows_profile block"
  default     = {}
}

variable "kubernetes_cluster_timeouts" {
  description = "Set timeouts for kubernetes cluster"
  default     = {}
}

#-----------------------------------------------------------
# Azure kubernetes cluster node pool
#-----------------------------------------------------------
variable "enable_kubernetes_cluster_node_pool" {
  description = "Enable kubernetes cluster node pool usage"
  default     = false
}

variable "kubernetes_cluster_node_pool_name" {
  description = "The name of the Node Pool which should be created within the Kubernetes Cluster. Changing this forces a new resource to be created."
  default     = ""
}

variable "kubernetes_cluster_node_pool_kubernetes_cluster_id" {
  description = "The ID of the Kubernetes Cluster where this Node Pool should exist. Changing this forces a new resource to be created."
  default     = ""
}

variable "kubernetes_cluster_node_pool_vm_size" {
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 (inclusive) for user pools and between 1 and 1000 (inclusive) for system pools and must be a value in the range min_count - max_count."
  default     = null
}

variable "kubernetes_cluster_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false"
  default     = null
}

variable "kubernetes_cluster_node_pool_enable_host_encryption" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  default     = null
}

variable "kubernetes_cluster_node_pool_enable_node_public_ip" {
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_eviction_policy" {
  description = "(Optional) The Eviction Policy which should be used for Virtual Machines within the Virtual Machine Scale Set powering this Node Pool. Possible values are Deallocate and Delete. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_fips_enabled" {
  description = "(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_kubelet_disk_type" {
  description = "(Optional) The type of disk used by kubelet. Possible values are OS and Temporary."
  default     = null
}

variable "kubernetes_cluster_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_mode" {
  description = "(Optional) Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User"
  default     = null
}

variable "kubernetes_cluster_node_pool_node_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool."
  default     = null
}

variable "kubernetes_cluster_node_pool_node_public_ip_prefix_id" {
  description = "(Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_node_taints" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_orchestrator_version" {
  description = "(Optional) Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)"
  default     = null
}

variable "kubernetes_cluster_node_pool_os_disk_size_gb" {
  description = "(Optional) The Agent Operating System disk size in GB. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_pod_subnet_id" {
  description = "(Optional) The ID of the Subnet where the pods in the Node Pool should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_os_sku" {
  description = "(Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_os_type" {
  description = "(Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux."
  default     = null
}

variable "kubernetes_cluster_node_pool_priority" {
  description = "(Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_proximity_placement_group_id" {
  description = "(Optional) The ID of the Proximity Placement Group where the Virtual Machine Scale Set that powers this Node Pool will be placed. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_spot_max_price" {
  description = "(Optional) The maximum price you're willing to pay in USD per Virtual Machine. Valid values are -1 (the current on-demand price for a Virtual Machine) or a positive value with up to five decimal places. Changing this forces a new resource to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_scale_down_mode" {
  description = "(Optional) Specifies how the node pool should deal with scaled-down nodes. Allowed values are Delete and Deallocate. Defaults to Delete."
  default     = null
}

variable "kubernetes_cluster_node_pool_ultra_ssd_enabled" {
  description = "(Optional) Used to specify whether the UltraSSD is enabled in the Node Pool. Defaults to false. See the documentation for more information."
  default     = null
}

variable "kubernetes_cluster_node_pool_vnet_subnet_id" {
  description = "(Optional) The ID of the Subnet where this Node Pool should exist."
  default     = null
}

variable "kubernetes_cluster_node_pool_workload_runtime" {
  description = "(Optional) Used to specify the workload runtime. Allowed values are OCIContainer and WasmWasi"
  default     = null
}

variable "kubernetes_cluster_node_pool_zones" {
  description = "(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool should be located. Changing this forces a new Kubernetes Cluster Node Pool to be created."
  default     = null
}

variable "kubernetes_cluster_node_pool_max_count" {
  description = "The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  default     = null
}

variable "kubernetes_cluster_node_pool_min_count" {
  description = "The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  default     = null
}

variable "kubernetes_cluster_node_pool_kubelet_config" {
  description = "(Optional) A kubelet_config block"
  default     = {}
}

variable "kubernetes_cluster_node_pool_linux_os_config" {
  description = "(Optional) A linux_os_config block"
  default     = {}
}

variable "kubernetes_cluster_node_pool_upgrade_settings" {
  description = "(Optional) A upgrade_settings block"
  default     = {}
}

variable "kubernetes_cluster_node_pool_timeouts" {
  description = "Set timeouts for kubernetes cluster node pool"
  default     = {}
}
