# Work with CONTAINER via terraform

A terraform module for making CONTAINER.


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

module "container" {
  source = "../../modules/container"

  enable_container_group              = true
  container_group_name                = "test-1"
  container_group_location            = module.base_resource_group.resource_group_location
  container_group_resource_group_name = module.base_resource_group.resource_group_name
  container_group_os_type             = "Linux"
  container_group_ip_address_type     = "public"
  container_group_dns_name_label      = "aci-label"

  container_group_container = [
    {
      name   = "hello-world"
      image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
      cpu    = "0.5"
      memory = "1.5"

      ports = [
        {
          port     = 443
          protocol = "TCP"
        }
      ]
    }
  ]

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_container_group` - Enable container group usage (`default = False`)
- `container_group_name` - Specifies the name of the Container Group. Changing this forces a new resource to be created. (`default = ""`)
- `container_group_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `container_group_resource_group_name` - (Required) The name of the resource group in which to create the Container Group. Changing this forces a new resource to be created. (`default = null`)
- `container_group_os_type` - (Required) The OS for the container group. Allowed values are Linux and Windows. Changing this forces a new resource to be created. (`default = null`)
- `container_group_container` - (Required) The definition of a container that is part of the group as documented in the container block. Changing this forces a new resource to be created. (`default = []`)
- `container_group_dns_name_label` - (Optional) The DNS label/name for the container groups IP. Changing this forces a new resource to be created. (`default = null`)
- `container_group_ip_address_type` - (Optional) Specifies the IP address type of the container. Public, Private or None. Changing this forces a new resource to be created. If set to Private, network_profile_id also needs to be set. (`default = null`)
- `container_group_key_vault_key_id` - (Optional) The Key Vault key URI for CMK encryption. Changing this forces a new resource to be created. (`default = null`)
- `container_group_network_profile_id` - (Optional) Network profile ID for deploying to virtual network. (`default = null`)
- `container_group_restart_policy` - (Optional) Restart policy for the container group. Allowed values are Always, Never, OnFailure. Defaults to Always. Changing this forces a new resource to be created. (`default = null`)
- `container_group_image_registry_credential` - (Optional) A image_registry_credential block as documented. Changing this forces a new resource to be created. (`default = {}`)
- `container_group_identity` - (Optional) An identity block (`default = {}`)
- `container_group_init_container` - (Optional) The definition of an init container that is part of the group as documented in the init_container block. Changing this forces a new resource to be created. (`default = []`)
- `container_group_dns_config` - (Optional) A dns_config block (`default = {}`)
- `container_group_diagnostics` - (Optional) A diagnostics block (`default = {}`)
- `container_group_exposed_port` - (Optional) Zero or more exposed_port blocks as defined. Changing this forces a new resource to be created. (`default = []`)
- `container_group_timeouts` - Set timeouts for container group (`default = {}`)
- `enable_container_registry` - Enable container registry usage (`default = False`)
- `container_registry_name` - Specifies the name of the Container Registry. Changing this forces a new resource to be created. (`default = ""`)
- `container_registry_resource_group_name` -  (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created. (`default = null`)
- `container_registry_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `container_registry_sku` - (Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium. (`default = null`)
- `container_registry_admin_enabled` - (Optional) Specifies whether the admin user is enabled. Defaults to false. (`default = null`)
- `container_registry_public_network_access_enabled` - (Optional) Whether public network access is allowed for the container registry. Defaults to true. (`default = null`)
- `container_registry_quarantine_policy_enabled` - (Optional) Boolean value that indicates whether quarantine policy is enabled. Defaults to false (`default = null`)
- `container_registry_zone_redundancy_enabled` - Optional) Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to false. (`default = null`)
- `container_registry_export_policy_enabled` - (Optional) Boolean value that indicates whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false. (`default = null`)
- `container_registry_anonymous_pull_enabled` - (Optional) Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to false. This is only supported on resources with the Standard or Premium SKU. (`default = null`)
- `container_registry_data_endpoint_enabled` - Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU. (`default = null`)
- `container_registry_network_rule_bypass_option` - (Optional) Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are None and AzureServices. Defaults to AzureServices. (`default = null`)
- `container_registry_georeplications` - (Optional) A georeplications block (`default = []`)
- `container_registry_network_rule_set` - (Optional) A network_rule_set block (`default = []`)
- `container_registry_retention_policy` - (Optional) A retention_policy block (`default = {}`)
- `container_registry_trust_policy` - (Optional) A trust_policy block (`default = {}`)
- `container_registry_identity` - An identity block (`default = {}`)
- `container_registry_encryption` - (Optional) An encryption block (`default = {}`)
- `container_registry_timeouts` - Set timeouts for container registry (`default = {}`)
- `enable_container_registry_webhook` - Enable container registry webhook usage (`default = False`)
- `container_registry_webhook_name` - Specifies the name of the Container Registry Webhook. Changing this forces a new resource to be created. (`default = ""`)
- `container_registry_webhook_resource_group_name` - (Required) The name of the resource group in which to create the Container Registry Webhook. Changing this forces a new resource to be created. (`default = null`)
- `container_registry_webhook_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `container_registry_webhook_registry_name` - The Name of Container registry this Webhook belongs to. Changing this forces a new resource to be created. (`default = ""`)
- `container_registry_webhook_service_uri` - (Required) Specifies the service URI for the Webhook to post notifications. (`default = null`)
- `container_registry_webhook_actions` - (Required) A list of actions that trigger the Webhook to post notifications. At least one action needs to be specified. Valid values are: push, delete, quarantine, chart_push, chart_delete (`default = null`)
- `container_registry_webhook_status` - (Optional) Specifies if this Webhook triggers notifications or not. Valid values: enabled and disabled. Default is enabled (`default = null`)
- `container_registry_webhook_scope` - (Optional) Specifies the scope of repositories that can trigger an event. For example, foo:* means events for all tags under repository foo. foo:bar means events for 'foo:bar' only. foo is equivalent to foo:latest. Empty means all events (`default = null`)
- `container_registry_webhook_custom_headers` - (Optional) Custom headers that will be added to the webhook notifications request. (`default = null`)
- `container_registry_webhook_timeouts` - Set timeouts for container registry webhook (`default = {}`)
- `enable_container_registry_scope_map` - Enable container registry scope map usage (`default = False`)
- `container_registry_scope_map_name` - Specifies the name of the scope map. Changing this forces a new resource to be created. (`default = ""`)
- `container_registry_scope_map_container_registry_name` - The name of the Container Registry. Changing this forces a new resource to be created. (`default = ""`)
- `container_registry_scope_map_resource_group_name` - (Required) The name of the resource group in which to create the Container Registry token. Changing this forces a new resource to be created. (`default = null`)
- `container_registry_scope_map_actions` - (Required) A list of actions to attach to the scope map (e.g. repo/content/read, repo2/content/delete). (`default = null`)
- `container_registry_scope_map_timeouts` - Set timeouts for container registry scope map (`default = {}`)
- `enable_container_registry_agent_pool` - Enable container registry agent pool usage (`default = False`)
- `container_registry_agent_pool_name` - The name which should be used for this Azure Container Registry Agent Pool. Changing this forces a new Azure Container Registry Agent Pool to be created. (`default = ""`)
- `container_registry_agent_pool_resource_group_name` - (Required) The name of the Resource Group where the Azure Container Registry Agent Pool should exist. Changing this forces a new Azure Container Registry Agent Pool to be created. (`default = null`)
- `container_registry_agent_pool_location` - (Required) The Azure Region where the Azure Container Registry Agent Pool should exist. Changing this forces a new Azure Container Registry Agent Pool to be created. (`default = null`)
- `container_registry_agent_pool_container_registry_name` - (Required) Name of Azure Container Registry to create an Agent Pool for. Changing this forces a new Azure Container Registry Agent Pool to be created. (`default = ""`)
- `container_registry_agent_pool_instance_count` - (Optional) VMSS instance count. Defaults to 1. (`default = null`)
- `container_registry_agent_pool_tier` - (Optional) Sets the VM your agent pool will run on. Valid values are: S1 (2 vCPUs, 3 GiB RAM), S2 (4 vCPUs, 8 GiB RAM), S3 (8 vCPUs, 16 GiB RAM) or I6 (64 vCPUs, 216 GiB RAM, Isolated). Defaults to S1. Changing this forces a new Azure Container Registry Agent Pool to be created. (`default = null`)
- `container_registry_agent_pool_virtual_network_subnet_id` - (Optional) The ID of the Virtual Network Subnet Resource where the agent machines will be running. Changing this forces a new Azure Container Registry Agent Pool to be created. (`default = null`)
- `container_registry_agent_pool_timeouts` - Set timeouts for container registry agent pool (`default = {}`)
- `enable_container_registry_task` - Enable container registry task usage (`default = False`)
- `container_registry_task_name` - The name which should be used for this Container Registry Task. Changing this forces a new Container Registry Task to be created. (`default = ""`)
- `container_registry_task_container_registry_id` - The ID of the Container Registry that this Container Registry Task resides in. Changing this forces a new Container Registry Task to be created. (`default = ""`)
- `container_registry_task_agent_pool_name` - (Optional) The name of the dedicated Container Registry Agent Pool for this Container Registry Task. (`default = null`)
- `container_registry_task_enabled` - (Optional) Should this Container Registry Task be enabled? Defaults to true. (`default = null`)
- `container_registry_task_is_system_task` - (Optional) Whether this Container Registry Task is a system task. Changing this forces a new Container Registry Task to be created. Defaults to false (`default = null`)
- `container_registry_task_log_template` - (Optional) The template that describes the run log artifact. (`default = null`)
- `container_registry_task_timeout_in_seconds` - (Optional) The timeout of this Container Registry Task in seconds. The valid range lies from 300 to 28800. Defaults to 3600. (`default = null`)
- `container_registry_task_agent_setting` - (Optional) A agent_setting block (`default = {}`)
- `container_registry_task_identity` - (Optional) An identity block (`default = {}`)
- `container_registry_task_platform` - (Optional) A platform block (`default = {}`)
- `container_registry_task_docker_step` - (Optional) A docker_step block (`default = {}`)
- `container_registry_task_encoded_step` - (Optional) A encoded_step block (`default = {}`)
- `container_registry_task_file_step` - (Optional) A file_step block (`default = {}`)
- `container_registry_task_base_image_trigger` - (Optional) A base_image_trigger block (`default = {}`)
- `container_registry_task_source_trigger` - (Optional) One or more source_trigger blocks (`default = {}`)
- `container_registry_task_timer_trigger` - (Optional) One or more timer_trigger blocks (`default = []`)
- `container_registry_task_registry_credential` - (Optional) One registry_credential block (`default = {}`)
- `container_registry_task_timeouts` - Set timeouts for container registry task (`default = {}`)
- `enable_container_registry_token` - Enable container registry token usage (`default = False`)
- `container_registry_token_name` - Specifies the name of the token. Changing this forces a new resource to be created. (`default = ""`)
- `container_registry_token_container_registry_name` - The name of the Container Registry. Changing this forces a new resource to be created. (`default = ""`)
- `container_registry_token_resource_group_name` - (Required) The name of the resource group in which to create the Container Registry token. Changing this forces a new resource to be created. (`default = null`)
- `container_registry_token_scope_map_id` - The ID of the Container Registry Scope Map associated with the token. (`default = ""`)
- `container_registry_token_timeouts` - Set timeouts for container registry token (`default = {}`)

## Module Output Variables
----------------------
- `container_group_id` - The ID of the Container Group.
- `container_group_identity` - An identity block
- `container_group_ip_address` - The IP address allocated to the container group.
- `container_group_fqdn` - The FQDN of the container group derived from dns_name_label.
- `container_registry_id` - The ID of the Container Registry.
- `container_registry_name` - The name of the Container Registry.
- `container_registry_login_server` - The URL that can be used to log into the container registry.
- `container_registry_admin_username` - The Username associated with the Container Registry Admin account - if the admin account is enabled.
- `container_registry_admin_password` - The Password associated with the Container Registry Admin account - if the admin account is enabled.
- `container_registry_identity` - An identity block as defined
- `container_registry_webhook_id` - The ID of the Container Registry Webhook.
- `container_registry_scope_map_id` - The ID of the Container Registry scope map.
- `container_registry_agent_pool_id` - The ID of the Container Registry scope map.
- `container_registry_task_id` - The ID of the Container Registry Task.
- `container_registry_task_identity` - An identity block
- `container_registry_token_id` - The ID of the Container Registry token.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
