# Work with AKS via terraform

A terraform module for making AKS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.1.0"
    }
  }
}


provider "azurerm" {
  # Configuration options
}


module "base_resource_group" {
  source = "../../modules/base"

  enable_resource_group   = true
  resource_group_name     = "res-group"
  resource_group_location = "West Europe"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

module "aks" {
  source = "../../modules/aks"

  enable_kubernetes_cluster              = true
  kubernetes_cluster_name                = "test-eks-1"
  kubernetes_cluster_location            = module.base_resource_group.resource_group_location
  kubernetes_cluster_resource_group_name = module.base_resource_group.resource_group_name
  kubernetes_cluster_dns_prefix          = "exampleaks1"
  kubernetes_cluster_oidc_issuer_enabled = true

  kubernetes_cluster_default_node_pool = {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  kubernetes_cluster_identity = {
    type = "SystemAssigned"
  }


  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_kubernetes_cluster` - Enable kubernetes cluster usage (`default = False`)
- `kubernetes_cluster_name` - The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created. (`default = ""`)
- `kubernetes_cluster_location` - (Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_resource_group_name` - (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_dns_prefix` - (Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_default_node_pool` - (Required) A default_node_pool block (`default = {}`)
- `kubernetes_cluster_dns_prefix_private_cluster` - Optional) Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_automatic_channel_upgrade` - (Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none. (`default = null`)
- `kubernetes_cluster_api_server_authorized_ip_ranges` - (Optional) The IP ranges to allow for incoming traffic to the server nodes. (`default = null`)
- `kubernetes_cluster_azure_policy_enabled` - (Optional) Should the Azure Policy Add-On be enabled? For more details please visit Understand Azure Policy for Azure Kubernetes Service (`default = null`)
- `kubernetes_cluster_disk_encryption_set_id` - (Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information can be found in the documentation. (`default = null`)
- `kubernetes_cluster_http_application_routing_enabled` - (Optional) Should HTTP Application Routing be enabled? (`default = null`)
- `kubernetes_cluster_kubernetes_version` - (Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). (`default = null`)
- `kubernetes_cluster_local_account_disabled` - (Optional) - If true local accounts will be disabled. Defaults to false. See the documentation for more information. (`default = null`)
- `kubernetes_cluster_node_resource_group` - (Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_open_service_mesh_enabled` - (Optional) Is Open Service Mesh enabled? For more details, please visit Open Service Mesh for AKS. (`default = null`)
- `kubernetes_cluster_private_cluster_enabled` - (Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_private_dns_zone_id` - (Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_private_cluster_public_fqdn_enabled` - (Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false. (`default = null`)
- `kubernetes_cluster_public_network_access_enabled` - (Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_role_based_access_control_enabled` - (Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_run_command_enabled` - (Optional) Whether to enable run command for the cluster or not. Defaults to true. (`default = null`)
- `kubernetes_cluster_service_principal` - (Optional) A service_principal block. One of either identity or service_principal must be specified. (`default = {}`)
- `kubernetes_cluster_sku_tier` - (Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free. (`default = null`)
- `kubernetes_cluster_aci_connector_linux` - (Optional) A aci_connector_linux block. For more details, please visit Create and configure an AKS cluster to use virtual nodes. (`default = {}`)
- `kubernetes_cluster_auto_scaler_profile` - (Optional) A auto_scaler_profile block (`default = []`)
- `kubernetes_cluster_azure_active_directory_role_based_access_control` - (Optional) - A azure_active_directory_role_based_access_control block (`default = {}`)
- `kubernetes_cluster_http_proxy_config` - (Optional) A http_proxy_config block (`default = {}`)
- `kubernetes_cluster_identity` - (Optional) An identity block. One of either identity or service_principal must be specified. (`default = {}`)
- `kubernetes_cluster_ingress_application_gateway` - (Optional) A ingress_application_gateway block. (`default = {}`)
- `kubernetes_cluster_key_vault_secrets_provider` - (Optional) A key_vault_secrets_provider block as defined below. For more details, please visit Azure Keyvault Secrets Provider for AKS. (`default = {}`)
- `kubernetes_cluster_kubelet_identity` - A kubelet_identity block. Changing this forces a new resource to be created. (`default = {}`)
- `kubernetes_cluster_linux_profile` - (Optional) A linux_profile block (`default = {}`)
- `kubernetes_cluster_maintenance_window` - (Optional) A maintenance_window block (`default = {}`)
- `kubernetes_cluster_microsoft_defender` - (Optional) A microsoft_defender block (`default = {}`)
- `kubernetes_cluster_network_profile` - (Optional) A network_profile block (`default = {}`)
- `kubernetes_cluster_oms_agent` - (Optional) A oms_agent block (`default = {}`)
- `kubernetes_cluster_windows_profile` - (Optional) A windows_profile block (`default = {}`)
- `kubernetes_cluster_timeouts` - Set timeouts for kubernetes cluster (`default = {}`)
- `enable_kubernetes_cluster_node_pool` - Enable kubernetes cluster node pool usage (`default = False`)
- `kubernetes_cluster_node_pool_name` - The name of the Node Pool which should be created within the Kubernetes Cluster. Changing this forces a new resource to be created. (`default = ""`)
- `kubernetes_cluster_node_pool_kubernetes_cluster_id` - The ID of the Kubernetes Cluster where this Node Pool should exist. Changing this forces a new resource to be created. (`default = ""`)
- `kubernetes_cluster_node_pool_vm_size` - (Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_node_count` - (Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 (inclusive) for user pools and between 1 and 1000 (inclusive) for system pools and must be a value in the range min_count - max_count. (`default = null`)
- `kubernetes_cluster_node_pool_enable_auto_scaling` - (Optional) Whether to enable auto-scaler. Defaults to false (`default = null`)
- `kubernetes_cluster_node_pool_enable_host_encryption` - (Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false. (`default = null`)
- `kubernetes_cluster_node_pool_enable_node_public_ip` - (Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_eviction_policy` - (Optional) The Eviction Policy which should be used for Virtual Machines within the Virtual Machine Scale Set powering this Node Pool. Possible values are Deallocate and Delete. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_fips_enabled` - (Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_kubelet_disk_type` - (Optional) The type of disk used by kubelet. Possible values are OS and Temporary. (`default = null`)
- `kubernetes_cluster_node_pool_max_pods` - (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_mode` - (Optional) Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User (`default = null`)
- `kubernetes_cluster_node_pool_node_labels` - (Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. (`default = null`)
- `kubernetes_cluster_node_pool_node_public_ip_prefix_id` - (Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. enable_node_public_ip should be true. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_node_taints` - (Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_orchestrator_version` - (Optional) Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade) (`default = null`)
- `kubernetes_cluster_node_pool_os_disk_size_gb` - (Optional) The Agent Operating System disk size in GB. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_os_disk_type` - (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_pod_subnet_id` - (Optional) The ID of the Subnet where the pods in the Node Pool should exist. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_os_sku` - (Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: Ubuntu, CBLMariner. Defaults to Ubuntu. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_os_type` - (Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux. (`default = null`)
- `kubernetes_cluster_node_pool_priority` - (Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_proximity_placement_group_id` - (Optional) The ID of the Proximity Placement Group where the Virtual Machine Scale Set that powers this Node Pool will be placed. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_spot_max_price` - (Optional) The maximum price you're willing to pay in USD per Virtual Machine. Valid values are -1 (the current on-demand price for a Virtual Machine) or a positive value with up to five decimal places. Changing this forces a new resource to be created. (`default = null`)
- `kubernetes_cluster_node_pool_scale_down_mode` - (Optional) Specifies how the node pool should deal with scaled-down nodes. Allowed values are Delete and Deallocate. Defaults to Delete. (`default = null`)
- `kubernetes_cluster_node_pool_ultra_ssd_enabled` - (Optional) Used to specify whether the UltraSSD is enabled in the Node Pool. Defaults to false. See the documentation for more information. (`default = null`)
- `kubernetes_cluster_node_pool_vnet_subnet_id` - (Optional) The ID of the Subnet where this Node Pool should exist. (`default = null`)
- `kubernetes_cluster_node_pool_workload_runtime` - (Optional) Used to specify the workload runtime. Allowed values are OCIContainer and WasmWasi (`default = null`)
- `kubernetes_cluster_node_pool_zones` - (Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool should be located. Changing this forces a new Kubernetes Cluster Node Pool to be created. (`default = null`)
- `kubernetes_cluster_node_pool_max_count` - The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count. (`default = null`)
- `kubernetes_cluster_node_pool_min_count` - The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count. (`default = null`)
- `kubernetes_cluster_node_pool_kubelet_config` - (Optional) A kubelet_config block (`default = {}`)
- `kubernetes_cluster_node_pool_linux_os_config` - (Optional) A linux_os_config block (`default = {}`)
- `kubernetes_cluster_node_pool_upgrade_settings` - (Optional) A upgrade_settings block (`default = {}`)
- `kubernetes_cluster_node_pool_timeouts` - Set timeouts for kubernetes cluster node pool (`default = {}`)

## Module Output Variables
----------------------
- `kubernetes_cluster_id` - The Kubernetes Managed Cluster ID.
- `kubernetes_cluster_fqdn` - The FQDN of the Azure Kubernetes Managed Cluster.
- `kubernetes_cluster_private_fqdn` - The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster.
- `kubernetes_cluster_portal_fqdn` - The FQDN for the Azure Portal resources when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster.
- `kubernetes_cluster_kube_admin_config` - A kube_admin_config block. This is only available when Role Based Access Control with Azure Active Directory is enabled and local accounts enabled.
- `kubernetes_cluster_kube_admin_config_raw` - Raw Kubernetes config for the admin account to be used by kubectl and other compatible tools. This is only available when Role Based Access Control with Azure Active Directory is enabled and local accounts enabled.
- `kubernetes_cluster_kube_config` - A kube_config block as defined
- `kubernetes_cluster_kube_config_raw` - Raw Kubernetes config to be used by kubectl and other compatible tools.
- `kubernetes_cluster_http_application_routing_zone_name` - The Zone Name of the HTTP Application Routing.
- `kubernetes_cluster_oidc_issuer_url` - The OIDC issuer URL that is associated with the cluster.
- `kubernetes_cluster_node_resource_group` - The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster.
- `kubernetes_cluster_load_balancer_profile` - load balancer profile
- `kubernetes_cluster_nat_gateway_profile` - nat gateway profile
- `kubernetes_cluster_identity` - An identity block
- `kubernetes_cluster_ingress_application_gateway` - The ingress_application_gateway block
- `kubernetes_cluster_oms_agent` - The oms_agent block
- `kubernetes_cluster_oms_agent_identity` - The oms_agent_identity block
- `kubernetes_cluster_key_vault_secrets_provider` - The key_vault_secrets_provider block
- `kubernetes_cluster_secret_identity` - The secret_identity block
- `kubernetes_cluster_node_pool_id` - The ID of the Kubernetes Cluster Node Pool.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
