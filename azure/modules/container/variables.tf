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
# Azure container group
#-----------------------------------------------------------
variable "enable_container_group" {
  description = "Enable container group usage"
  default     = false
}

variable "container_group_name" {
  description = "Specifies the name of the Container Group. Changing this forces a new resource to be created."
  default     = ""
}

variable "container_group_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "container_group_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Container Group. Changing this forces a new resource to be created."
  default     = null
}

variable "container_group_os_type" {
  description = "(Required) The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created."
  default     = null
}

variable "container_group_container" {
  description = "(Required) The definition of a container that is part of the group as documented in the container block. Changing this forces a new resource to be created."
  default     = []
}

variable "container_group_dns_name_label" {
  description = "(Optional) The DNS label/name for the container groups IP. Changing this forces a new resource to be created."
  default     = null
}

variable "container_group_ip_address_type" {
  description = "(Optional) Specifies the IP address type of the container. Public, Private or None. Changing this forces a new resource to be created. If set to Private, network_profile_id also needs to be set."
  default     = null
}

variable "container_group_key_vault_key_id" {
  description = "(Optional) The Key Vault key URI for CMK encryption. Changing this forces a new resource to be created."
  default     = null
}

variable "container_group_network_profile_id" {
  description = "(Optional) Network profile ID for deploying to virtual network."
  default     = null
}

variable "container_group_restart_policy" {
  description = "(Optional) Restart policy for the container group. Allowed values are Always, Never, OnFailure. Defaults to Always. Changing this forces a new resource to be created."
  default     = null
}

variable "container_group_image_registry_credential" {
  description = "(Optional) A image_registry_credential block as documented. Changing this forces a new resource to be created."
  default     = {}
}

variable "container_group_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "container_group_init_container" {
  description = "(Optional) The definition of an init container that is part of the group as documented in the init_container block. Changing this forces a new resource to be created."
  default     = []
}

variable "container_group_dns_config" {
  description = "(Optional) A dns_config block"
  default     = {}
}

variable "container_group_diagnostics" {
  description = "(Optional) A diagnostics block"
  default     = {}
}

variable "container_group_exposed_port" {
  description = "(Optional) Zero or more exposed_port blocks as defined. Changing this forces a new resource to be created."
  default     = []
}

variable "container_group_timeouts" {
  description = "Set timeouts for container group"
  default     = {}
}

#-----------------------------------------------------------
# Azure container registry
#-----------------------------------------------------------
variable "enable_container_registry" {
  description = "Enable container registry usage"
  default     = false
}

variable "container_registry_name" {
  description = "Specifies the name of the Container Registry. Changing this forces a new resource to be created."
  default     = ""
}

variable "container_registry_resource_group_name" {
  description = " (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
  default     = null
}

variable "container_registry_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "container_registry_sku" {
  description = "(Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium."
  default     = null
}

variable "container_registry_admin_enabled" {
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  default     = null
}

variable "container_registry_public_network_access_enabled" {
  description = "(Optional) Whether public network access is allowed for the container registry. Defaults to true."
  default     = null
}

variable "container_registry_quarantine_policy_enabled" {
  description = "(Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false"
  default     = null
}

variable "container_registry_zone_redundancy_enabled" {
  description = "Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false."
  default     = null
}

variable "container_registry_export_policy_enabled" {
  description = "(Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false."
  default     = null
}

variable "container_registry_anonymous_pull_enabled" {
  description = "(Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU."
  default     = null
}

variable "container_registry_data_endpoint_enabled" {
  description = "Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU."
  default     = null
}

variable "container_registry_network_rule_bypass_option" {
  description = "(Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices."
  default     = null
}

variable "container_registry_georeplications" {
  description = "(Optional) A georeplications block"
  default     = []
}

variable "container_registry_network_rule_set" {
  description = "(Optional) A network_rule_set block"
  default     = []
}

variable "container_registry_retention_policy" {
  description = "(Optional) A retention_policy block"
  default     = {}
}

variable "container_registry_trust_policy" {
  description = "(Optional) A trust_policy block"
  default     = {}
}

variable "container_registry_identity" {
  description = "An identity block"
  default     = {}
}

variable "container_registry_encryption" {
  description = "(Optional) An encryption block"
  default     = {}
}

variable "container_registry_timeouts" {
  description = "Set timeouts for container registry"
  default     = {}
}

#-----------------------------------------------------------
# Azure container registry webhook
#-----------------------------------------------------------
variable "enable_container_registry_webhook" {
  description = "Enable container registry webhook usage"
  default     = false
}

variable "container_registry_webhook_name" {
  description = "Specifies the name of the Container Registry Webhook. Changing this forces a new resource to be created."
  default     = ""
}

variable "container_registry_webhook_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Container Registry Webhook. Changing this forces a new resource to be created."
  default     = null
}

variable "container_registry_webhook_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "container_registry_webhook_registry_name" {
  description = "The Name of Container registry this Webhook belongs to. Changing this forces a new resource to be created."
  default     = ""
}

variable "container_registry_webhook_service_uri" {
  description = "(Required) Specifies the service URI for the Webhook to post notifications."
  default     = null
}

variable "container_registry_webhook_actions" {
  description = "(Required) A list of actions that trigger the Webhook to post notifications. At least one action needs to be specified. Valid values are: push, delete, quarantine, chart_push, chart_delete"
  default     = null
}

variable "container_registry_webhook_status" {
  description = "(Optional) Specifies if this Webhook triggers notifications or not. Valid values: enabled and disabled. Default is enabled"
  default     = null
}

variable "container_registry_webhook_scope" {
  description = "(Optional) Specifies the scope of repositories that can trigger an event. For example, foo:* means events for all tags under repository foo. foo:bar means events for 'foo:bar' only. foo is equivalent to foo:latest. Empty means all events"
  default     = null
}

variable "container_registry_webhook_custom_headers" {
  description = "(Optional) Custom headers that will be added to the webhook notifications request."
  default     = null
}

variable "container_registry_webhook_timeouts" {
  description = "Set timeouts for container registry webhook"
  default     = {}
}

#-----------------------------------------------------------
# Azure container registry scope map
#-----------------------------------------------------------
variable "enable_container_registry_scope_map" {
  description = "Enable container registry scope map usage"
  default     = false
}

variable "container_registry_scope_map_name" {
  description = "Specifies the name of the scope map. Changing this forces a new resource to be created."
  default     = ""
}

variable "container_registry_scope_map_container_registry_name" {
  description = "The name of the Container Registry. Changing this forces a new resource to be created."
  default     = ""
}

variable "container_registry_scope_map_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Container Registry token. Changing this forces a new resource to be created."
  default     = null
}

variable "container_registry_scope_map_actions" {
  description = "(Required) A list of actions to attach to the scope map (e.g. repo/content/read, repo2/content/delete)."
  default     = null
}

variable "container_registry_scope_map_timeouts" {
  description = "Set timeouts for container registry scope map"
  default     = {}
}

#-----------------------------------------------------------
# Azure container registry agent pool
#-----------------------------------------------------------
variable "enable_container_registry_agent_pool" {
  description = "Enable container registry agent pool usage"
  default     = false
}

variable "container_registry_agent_pool_name" {
  description = "The name which should be used for this Azure Container Registry Agent Pool. Changing this forces a new Azure Container Registry Agent Pool to be created."
  default     = ""
}

variable "container_registry_agent_pool_resource_group_name" {
  description = "(Required) The name of the Resource Group where the Azure Container Registry Agent Pool should exist. Changing this forces a new Azure Container Registry Agent Pool to be created."
  default     = null
}

variable "container_registry_agent_pool_location" {
  description = "(Required) The Azure Region where the Azure Container Registry Agent Pool should exist. Changing this forces a new Azure Container Registry Agent Pool to be created."
  default     = null
}

variable "container_registry_agent_pool_container_registry_name" {
  description = "(Required) Name of Azure Container Registry to create an Agent Pool for. Changing this forces a new Azure Container Registry Agent Pool to be created."
  default     = ""
}

variable "container_registry_agent_pool_instance_count" {
  description = "(Optional) VMSS instance count. Defaults to 1."
  default     = null
}

variable "container_registry_agent_pool_tier" {
  description = "(Optional) Sets the VM your agent pool will run on. Valid values are: S1 (2 vCPUs, 3 GiB RAM), S2 (4 vCPUs, 8 GiB RAM), S3 (8 vCPUs, 16 GiB RAM) or I6 (64 vCPUs, 216 GiB RAM, Isolated). Defaults to S1. Changing this forces a new Azure Container Registry Agent Pool to be created."
  default     = null
}

variable "container_registry_agent_pool_virtual_network_subnet_id" {
  description = "(Optional) The ID of the Virtual Network Subnet Resource where the agent machines will be running. Changing this forces a new Azure Container Registry Agent Pool to be created."
  default     = null
}

variable "container_registry_agent_pool_timeouts" {
  description = "Set timeouts for container registry agent pool"
  default     = {}
}

#-----------------------------------------------------------
# Azure container registry task
#-----------------------------------------------------------
variable "enable_container_registry_task" {
  description = "Enable container registry task usage"
  default     = false
}

variable "container_registry_task_name" {
  description = "The name which should be used for this Container Registry Task. Changing this forces a new Container Registry Task to be created."
  default     = ""
}

variable "container_registry_task_container_registry_id" {
  description = "The ID of the Container Registry that this Container Registry Task resides in. Changing this forces a new Container Registry Task to be created."
  default     = ""
}

variable "container_registry_task_agent_pool_name" {
  description = "(Optional) The name of the dedicated Container Registry Agent Pool for this Container Registry Task."
  default     = null
}

variable "container_registry_task_enabled" {
  description = "(Optional) Should this Container Registry Task be enabled? Defaults to true."
  default     = null
}

variable "container_registry_task_is_system_task" {
  description = "(Optional) Whether this Container Registry Task is a system task. Changing this forces a new Container Registry Task to be created. Defaults to false"
  default     = null
}

variable "container_registry_task_log_template" {
  description = "(Optional) The template that describes the run log artifact."
  default     = null
}

variable "container_registry_task_timeout_in_seconds" {
  description = "(Optional) The timeout of this Container Registry Task in seconds. The valid range lies from 300 to 28800. Defaults to 3600."
  default     = null
}

variable "container_registry_task_agent_setting" {
  description = "(Optional) A agent_setting block"
  default     = {}
}

variable "container_registry_task_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "container_registry_task_platform" {
  description = "(Optional) A platform block"
  default     = {}
}

variable "container_registry_task_docker_step" {
  description = "(Optional) A docker_step block"
  default     = {}
}

variable "container_registry_task_encoded_step" {
  description = "(Optional) A encoded_step block"
  default     = {}
}

variable "container_registry_task_file_step" {
  description = "(Optional) A file_step block"
  default     = {}
}

variable "container_registry_task_base_image_trigger" {
  description = "(Optional) A base_image_trigger block"
  default     = {}
}

variable "container_registry_task_source_trigger" {
  description = "(Optional) One or more source_trigger blocks"
  default     = {}
}

variable "container_registry_task_timer_trigger" {
  description = "(Optional) One or more timer_trigger blocks"
  default     = []
}

variable "container_registry_task_registry_credential" {
  description = "(Optional) One registry_credential block"
  default     = {}
}

variable "container_registry_task_timeouts" {
  description = "Set timeouts for container registry task"
  default     = {}
}

#-----------------------------------------------------------
# Azure container registry token
#-----------------------------------------------------------
variable "enable_container_registry_token" {
  description = "Enable container registry token usage"
  default     = false
}

variable "container_registry_token_name" {
  description = "Specifies the name of the token. Changing this forces a new resource to be created."
  default     = ""
}

variable "container_registry_token_container_registry_name" {
  description = "The name of the Container Registry. Changing this forces a new resource to be created."
  default     = ""
}

variable "container_registry_token_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Container Registry token. Changing this forces a new resource to be created."
  default     = null
}

variable "container_registry_token_scope_map_id" {
  description = "The ID of the Container Registry Scope Map associated with the token."
  default     = ""
}

variable "container_registry_token_timeouts" {
  description = "Set timeouts for container registry token"
  default     = {}
}