# Work with VIRTUAL_DESKTOP via terraform

A terraform module for making VIRTUAL_DESKTOP.


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
      version = "=3.1.0"
    }
  }
}

provider "azurerm" {
  # The AzureRM Provider supports authenticating using via the Azure CLI, a Managed Identity
  # and a Service Principal. More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure

  # The features block allows changing the behaviour of the Azure Provider, more
  # information can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
  features {}

  // subscription_id = ""
  // tenant_id       = ""
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

module "virtual_desktop" {
  source = "../../modules/virtual_desktop"

  // virtual desktop workspace
  enable_virtual_desktop_workspace              = true
  virtual_desktop_workspace_name                = ""
  virtual_desktop_workspace_location            = module.base_resource_group.resource_group_location
  virtual_desktop_workspace_resource_group_name = module.base_resource_group.resource_group_name

  virtual_desktop_workspace_friendly_name = "FriendlyName"
  virtual_desktop_workspace_description   = "Test virt desctop workspace"

  // virtual desktop workspace application group association

  // virtual desktop scaling plan

  // virtual desktop host pool

  // virtual desktop host pool registration info

  // virtual desktop application group

  // virtual desktop application


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
- `enable_virtual_desktop_workspace` - Enable virtual desktop workspace usage (`default = False`)
- `virtual_desktop_workspace_name` - The name of the Virtual Desktop Workspace. Changing the name forces a new resource to be created. (`default = ""`)
- `virtual_desktop_workspace_location` - (Required) The location/region where the Virtual Desktop Workspace is located. Changing the location/region forces a new resource to be created. (`default = null`)
- `virtual_desktop_workspace_resource_group_name` - (Required) The name of the resource group in which to create the Virtual Desktop Workspace. Changing the resource group name forces a new resource to be created. (`default = null`)
- `virtual_desktop_workspace_friendly_name` - (Optional) A friendly name for the Virtual Desktop Workspace. (`default = null`)
- `virtual_desktop_workspace_description` - (Optional) A description for the Virtual Desktop Workspace. (`default = null`)
- `virtual_desktop_workspace_timeouts` - Set timeouts for virtual desktop workspace (`default = {}`)
- `enable_virtual_desktop_workspace_application_group_association` - Enable virtual desktop workspace application group association usage (`default = False`)
- `virtual_desktop_workspace_application_group_association_workspace_id` - The resource ID for the Virtual Desktop Workspace. (`default = ""`)
- `virtual_desktop_workspace_application_group_association_application_group_id` - The resource ID for the Virtual Desktop Application Group. (`default = null`)
- `virtual_desktop_workspace_application_group_association_timeouts` - Set timeouts for virtual desktop workspace application group association (`default = {}`)
- `enable_virtual_desktop_scaling_plan` - Enable virtual desktop scaling plan usage (`default = False`)
- `virtual_desktop_scaling_plan_name` - The name which should be used for this Virtual Desktop Scaling Plan . Changing this forces a new Virtual Desktop Scaling Plan to be created. (`default = ""`)
- `virtual_desktop_scaling_plan_location` - (Required) The Azure Region where the Virtual Desktop Scaling Plan (`default = null`)
- `virtual_desktop_scaling_plan_resource_group_name` - (Required) The name of the Resource Group where the Virtual Desktop Scaling Plan should exist. Changing this forces a new Virtual Desktop Scaling Plan to be created. (`default = null`)
- `virtual_desktop_scaling_plan_time_zone` - (Required) Specifies the Time Zone which should be used by the Scaling Plan for time based events, the possible values are defined here. (`default = null`)
- `virtual_desktop_scaling_plan_schedule` - (Required) One or more schedule blocks (`default = []`)
- `virtual_desktop_scaling_plan_description` - (Optional) A description of the Scaling Plan. (`default = null`)
- `virtual_desktop_scaling_plan_exclusion_tag` - (Optional) The name of the tag associated with the VMs you want to exclude from autoscaling. (`default = null`)
- `virtual_desktop_scaling_plan_friendly_name` - (Optional) Friendly name of the Scaling Plan. (`default = null`)
- `virtual_desktop_scaling_plan_host_pool` - (Optional) One or more host_pool blocks (`default = []`)
- `virtual_desktop_workspace_timeouts` - Set timeouts for virtual desktop workspace (`default = {}`)
- `enable_virtual_desktop_host_pool` - Enable virtual desktop host pool usage (`default = False`)
- `virtual_desktop_host_pool_name` - The name of the Virtual Desktop Host Pool. Changing the name forces a new resource to be created. (`default = ""`)
- `virtual_desktop_host_pool_resource_group_name` - (Required) The name of the resource group in which to create the Virtual Desktop Host Pool. Changing the resource group name forces a new resource to be created. (`default = null`)
- `virtual_desktop_host_pool_location` - (Required) The location/region where the Virtual Desktop Host Pool is located. Changing the location/region forces a new resource to be created. (`default = null`)
- `virtual_desktop_host_pool_type` - (Required) The type of the Virtual Desktop Host Pool. Valid options are Personal or Pooled. Changing the type forces a new resource to be created. (`default = null`)
- `virtual_desktop_host_pool_load_balancer_type` - (Optional) BreadthFirst load balancing distributes new user sessions across all available session hosts in the host pool. DepthFirst load balancing distributes new user sessions to an available session host with the highest number of connections but has not reached its maximum session limit threshold. Persistent should be used if the host pool type is Personal (`default = null`)
- `virtual_desktop_host_pool_friendly_name` - (Optional) A friendly name for the Virtual Desktop Host Pool. (`default = null`)
- `virtual_desktop_host_pool_validate_environment` - (Optional) Allows you to test service changes before they are deployed to production. Defaults to false (`default = null`)
- `virtual_desktop_host_pool_description` - (Optional) A description for the Virtual Desktop Host Pool. (`default = null`)
- `virtual_desktop_host_pool_start_vm_on_connect` - (Optional) Enables or disables the Start VM on Connection Feature. Defaults to false (`default = null`)
- `virtual_desktop_host_pool_custom_rdp_properties` - (Optional) A valid custom RDP properties string for the Virtual Desktop Host Pool, available properties can be found in this article. (`default = null`)
- `virtual_desktop_host_pool_maximum_sessions_allowed` - (Optional) A valid integer value from 0 to 999999 for the maximum number of users that have concurrent sessions on a session host. Should only be set if the type of your Virtual Desktop Host Pool is Pooled (`default = null`)
- `virtual_desktop_host_pool_personal_desktop_assignment_type` - (Optional) Automatic assignment – The service will select an available host and assign it to an user. Direct Assignment – Admin selects a specific host to assign to an user. (`default = null`)
- `virtual_desktop_host_pool_preferred_app_group_type` - (Optional) Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications. Default is None (`default = null`)
- `enable_virtual_desktop_host_pool_registration_info` - Enable virtual desktop host pool registration info usage (`default = False`)
- `virtual_desktop_host_pool_registration_info_hostpool_id` - The ID of the Virtual Desktop Host Pool to link the Registration Info to. Changing this forces a new Registration Info resource to be created. Only a single virtual_desktop_host_pool_registration_info resource should be associated with a given hostpool. Assigning multiple resources will produce inconsistent results. (`default = ""`)
- `virtual_desktop_host_pool_registration_info_expiration_date` - (Required) A valid RFC3339Time for the expiration of the token. (`default = null`)
- `enable_virtual_desktop_application` - Enable virtual desktop application usage (`default = False`)
- `virtual_desktop_application_name` - The name of the Virtual Desktop Application. Changing the name forces a new resource to be created. (`default = ""`)
- `virtual_desktop_application_application_group_id` - Resource ID for a Virtual Desktop Application Group to associate with the Virtual Desktop Application. Changing the ID forces a new resource to be created. (`default = ""`)
- `virtual_desktop_application_path` - (Required) The file path location of the app on the Virtual Desktop OS. (`default = null`)
- `virtual_desktop_application_command_line_argument_policy` - (Required) Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all. Possible values include: DoNotAllow, Allow, Require (`default = null`)
- `virtual_desktop_application_friendly_name` - (Optional) Option to set a friendly name for the Virtual Desktop Application. (`default = null`)
- `virtual_desktop_application_description` - (Optional) Option to set a description for the Virtual Desktop Application. (`default = null`)
- `virtual_desktop_application_command_line_arguments` - (Optional) Command Line Arguments for Virtual Desktop Application. (`default = null`)
- `virtual_desktop_application_show_in_portal` - (Optional) Specifies whether to show the RemoteApp program in the RD Web Access server. (`default = null`)
- `virtual_desktop_application_icon_path` - (Optional) Specifies the path for an icon which will be used for this Virtual Desktop Application. (`default = null`)
- `virtual_desktop_application_icon_index` - (Optional) The index of the icon you wish to use. (`default = null`)
- `virtual_desktop_application_timeouts` - Set timeouts for virtual desktop application (`default = {}`)
- `enable_virtual_desktop_application_group` - Enable virtual desktop application group usage (`default = False`)
- `virtual_desktop_application_group_name` - The name of the Virtual Desktop Application Group. Changing the name forces a new resource to be created. (`default = ""`)
- `virtual_desktop_application_group_resource_group_name` - The name of the resource group in which to create the Virtual Desktop Application Group. Changing the resource group name forces a new resource to be created. (`default = null`)
- `virtual_desktop_application_group_location` - (Required) The location/region where the Virtual Desktop Application Group is located. Changing the location/region forces a new resource to be created. (`default = null`)
- `virtual_desktop_application_group_type` - (Required) Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop application groups. (`default = null`)
- `virtual_desktop_application_group_host_pool_id` - Resource ID for a Virtual Desktop Host Pool to associate with the Virtual Desktop Application Group. (`default = ""`)
- `virtual_desktop_application_group_friendly_name` - (Optional) Option to set a friendly name for the Virtual Desktop Application Group. (`default = null`)
- `virtual_desktop_application_group_default_desktop_display_name` - (Optional) Option to set the display name for the default sessionDesktop desktop when type is set to Desktop (`default = null`)
- `virtual_desktop_application_group_description` - (Optional) Option to set a description for the Virtual Desktop Application Group. (`default = null`)
- `virtual_desktop_application_group_timeouts` - Set timeouts for virtual desktop application group (`default = {}`)

## Module Output Variables
----------------------
- `virtual_desktop_workspace_id` - The ID of the Virtual Desktop Workspace.
- `virtual_desktop_workspace_application_group_association_id` - The ID of the Virtual Desktop Workspace Application Group association.
- `virtual_desktop_scaling_plan_id` - The ID of the Virtual Desktop Scaling Plan.
- `virtual_desktop_host_pool_id` - The ID of the Virtual Desktop Host Pool.
- `virtual_desktop_host_pool_registration_info_id` - The ID of the Virtual Desktop Host Pool Registration Info resource.
- `virtual_desktop_host_pool_registration_info_token` - The registration token generated by the Virtual Desktop Host Pool for registration of session hosts.
- `virtual_desktop_application_id` - The ID of the Virtual Desktop Application.
- `virtual_desktop_application_group_id` - The ID of the Virtual Desktop Application Group.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
