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
# Azure virtual desktop workspace
#-----------------------------------------------------------
variable "enable_virtual_desktop_workspace" {
  description = "Enable virtual desktop workspace usage"
  default     = false
}

variable "virtual_desktop_workspace_name" {
  description = "The name of the Virtual Desktop Workspace. Changing the name forces a new resource to be created."
  default     = ""
}

variable "virtual_desktop_workspace_location" {
  description = "(Required) The location/region where the Virtual Desktop Workspace is located. Changing the location/region forces a new resource to be created."
  default     = null
}

variable "virtual_desktop_workspace_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Virtual Desktop Workspace. Changing the resource group name forces a new resource to be created."
  default     = null
}

variable "virtual_desktop_workspace_friendly_name" {
  description = "(Optional) A friendly name for the Virtual Desktop Workspace."
  default     = null
}

variable "virtual_desktop_workspace_description" {
  description = "(Optional) A description for the Virtual Desktop Workspace."
  default     = null
}

variable "virtual_desktop_workspace_timeouts" {
  description = "Set timeouts for virtual desktop workspace"
  default     = {}
}

#-----------------------------------------------------------
# Azure virtual desktop workspace application group association
#-----------------------------------------------------------
variable "enable_virtual_desktop_workspace_application_group_association" {
  description = "Enable virtual desktop workspace application group association usage"
  default     = false
}

variable "virtual_desktop_workspace_application_group_association_workspace_id" {
  description = "The resource ID for the Virtual Desktop Workspace."
  default     = ""
}

variable "virtual_desktop_workspace_application_group_association_application_group_id" {
  description = "The resource ID for the Virtual Desktop Application Group."
  default     = null
}

variable "virtual_desktop_workspace_application_group_association_timeouts" {
  description = "Set timeouts for virtual desktop workspace application group association"
  default     = {}
}

#-----------------------------------------------------------
# Azure virtual desktop scaling plan
#-----------------------------------------------------------
variable "enable_virtual_desktop_scaling_plan" {
  description = "Enable virtual desktop scaling plan usage"
  default     = false
}

variable "virtual_desktop_scaling_plan_name" {
  description = "The name which should be used for this Virtual Desktop Scaling Plan . Changing this forces a new Virtual Desktop Scaling Plan to be created."
  default     = ""
}

variable "virtual_desktop_scaling_plan_location" {
  description = "(Required) The Azure Region where the Virtual Desktop Scaling Plan"
  default     = null
}

variable "virtual_desktop_scaling_plan_resource_group_name" {
  description = "(Required) The name of the Resource Group where the Virtual Desktop Scaling Plan should exist. Changing this forces a new Virtual Desktop Scaling Plan to be created."
  default     = null
}

variable "virtual_desktop_scaling_plan_time_zone" {
  description = "(Required) Specifies the Time Zone which should be used by the Scaling Plan for time based events, the possible values are defined here."
  default     = null
}

variable "virtual_desktop_scaling_plan_schedule" {
  description = "(Required) One or more schedule blocks"
  default     = []
}

variable "virtual_desktop_scaling_plan_description" {
  description = "(Optional) A description of the Scaling Plan."
  default     = null
}

variable "virtual_desktop_scaling_plan_exclusion_tag" {
  description = "(Optional) The name of the tag associated with the VMs you want to exclude from autoscaling."
  default     = null
}

variable "virtual_desktop_scaling_plan_friendly_name" {
  description = "(Optional) Friendly name of the Scaling Plan."
  default     = null
}

variable "virtual_desktop_scaling_plan_host_pool" {
  description = "(Optional) One or more host_pool blocks"
  default     = []
}

variable "virtual_desktop_workspace_timeouts" {
  description = "Set timeouts for virtual desktop workspace"
  default     = {}
}

#-----------------------------------------------------------
# Azure virtual desktop host pool
#-----------------------------------------------------------
variable "enable_virtual_desktop_host_pool" {
  description = "Enable virtual desktop host pool usage"
  default     = false
}

variable "virtual_desktop_host_pool_name" {
  description = "The name of the Virtual Desktop Host Pool. Changing the name forces a new resource to be created."
  default     = ""
}

variable "virtual_desktop_host_pool_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Virtual Desktop Host Pool. Changing the resource group name forces a new resource to be created."
  default     = null
}

variable "virtual_desktop_host_pool_location" {
  description = "(Required) The location/region where the Virtual Desktop Host Pool is located. Changing the location/region forces a new resource to be created."
  default     = null
}

variable "virtual_desktop_host_pool_type" {
  description = "(Required) The type of the Virtual Desktop Host Pool. Valid options are Personal or Pooled. Changing the type forces a new resource to be created."
  default     = null
}

variable "virtual_desktop_host_pool_load_balancer_type" {
  description = "(Optional) BreadthFirst load balancing distributes new user sessions across all available session hosts in the host pool. DepthFirst load balancing distributes new user sessions to an available session host with the highest number of connections but has not reached its maximum session limit threshold. Persistent should be used if the host pool type is Personal"
  default     = null
}

variable "virtual_desktop_host_pool_friendly_name" {
  description = "(Optional) A friendly name for the Virtual Desktop Host Pool."
  default     = null
}

variable "virtual_desktop_host_pool_validate_environment" {
  description = "(Optional) Allows you to test service changes before they are deployed to production. Defaults to false"
  default     = null
}

variable "virtual_desktop_host_pool_description" {
  description = "(Optional) A description for the Virtual Desktop Host Pool."
  default     = null
}

variable "virtual_desktop_host_pool_start_vm_on_connect" {
  description = "(Optional) Enables or disables the Start VM on Connection Feature. Defaults to false"
  default     = null
}

variable "virtual_desktop_host_pool_custom_rdp_properties" {
  description = "(Optional) A valid custom RDP properties string for the Virtual Desktop Host Pool, available properties can be found in this article."
  default     = null
}

variable "virtual_desktop_host_pool_maximum_sessions_allowed" {
  description = "(Optional) A valid integer value from 0 to 999999 for the maximum number of users that have concurrent sessions on a session host. Should only be set if the type of your Virtual Desktop Host Pool is Pooled"
  default     = null
}

variable "virtual_desktop_host_pool_personal_desktop_assignment_type" {
  description = "(Optional) Automatic assignment – The service will select an available host and assign it to an user. Direct Assignment – Admin selects a specific host to assign to an user."
  default     = null
}

variable "virtual_desktop_host_pool_preferred_app_group_type" {
  description = "(Optional) Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications. Default is None"
  default     = null
}

#-----------------------------------------------------------
# Azure virtual desktop host pool registration info
#-----------------------------------------------------------
variable "enable_virtual_desktop_host_pool_registration_info" {
  description = "Enable virtual desktop host pool registration info usage"
  default     = false
}

variable "virtual_desktop_host_pool_registration_info_hostpool_id" {
  description = "The ID of the Virtual Desktop Host Pool to link the Registration Info to. Changing this forces a new Registration Info resource to be created. Only a single virtual_desktop_host_pool_registration_info resource should be associated with a given hostpool. Assigning multiple resources will produce inconsistent results."
  default     = ""
}

variable "virtual_desktop_host_pool_registration_info_expiration_date" {
  description = "(Required) A valid RFC3339Time for the expiration of the token."
  default     = null
}

#-----------------------------------------------------------
# Azure virtual desktop application
#-----------------------------------------------------------
variable "enable_virtual_desktop_application" {
  description = "Enable virtual desktop application usage"
  default     = false
}

variable "virtual_desktop_application_name" {
  description = "The name of the Virtual Desktop Application. Changing the name forces a new resource to be created."
  default     = ""
}

variable "virtual_desktop_application_application_group_id" {
  description = "Resource ID for a Virtual Desktop Application Group to associate with the Virtual Desktop Application. Changing the ID forces a new resource to be created."
  default     = ""
}

variable "virtual_desktop_application_path" {
  description = "(Required) The file path location of the app on the Virtual Desktop OS."
  default     = null
}

variable "virtual_desktop_application_command_line_argument_policy" {
  description = "(Required) Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all. Possible values include: DoNotAllow, Allow, Require"
  default     = null
}

variable "virtual_desktop_application_friendly_name" {
  description = "(Optional) Option to set a friendly name for the Virtual Desktop Application."
  default     = null
}

variable "virtual_desktop_application_description" {
  description = "(Optional) Option to set a description for the Virtual Desktop Application."
  default     = null
}

variable "virtual_desktop_application_command_line_arguments" {
  description = "(Optional) Command Line Arguments for Virtual Desktop Application."
  default     = null
}

variable "virtual_desktop_application_show_in_portal" {
  description = "(Optional) Specifies whether to show the RemoteApp program in the RD Web Access server."
  default     = null
}

variable "virtual_desktop_application_icon_path" {
  description = "(Optional) Specifies the path for an icon which will be used for this Virtual Desktop Application."
  default     = null
}

variable "virtual_desktop_application_icon_index" {
  description = "(Optional) The index of the icon you wish to use."
  default     = null
}

variable "virtual_desktop_application_timeouts" {
  description = "Set timeouts for virtual desktop application"
  default     = {}
}

#-----------------------------------------------------------
# Azure virtual desktop application group
#-----------------------------------------------------------
variable "enable_virtual_desktop_application_group" {
  description = "Enable virtual desktop application group usage"
  default     = false
}

variable "virtual_desktop_application_group_name" {
  description = "The name of the Virtual Desktop Application Group. Changing the name forces a new resource to be created."
  default     = ""
}

variable "virtual_desktop_application_group_resource_group_name" {
  description = "The name of the resource group in which to create the Virtual Desktop Application Group. Changing the resource group name forces a new resource to be created."
  default     = null
}

variable "virtual_desktop_application_group_location" {
  description = "(Required) The location/region where the Virtual Desktop Application Group is located. Changing the location/region forces a new resource to be created."
  default     = null
}

variable "virtual_desktop_application_group_type" {
  description = "(Required) Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop application groups."
  default     = null
}

variable "virtual_desktop_application_group_host_pool_id" {
  description = "Resource ID for a Virtual Desktop Host Pool to associate with the Virtual Desktop Application Group."
  default     = ""
}

variable "virtual_desktop_application_group_friendly_name" {
  description = "(Optional) Option to set a friendly name for the Virtual Desktop Application Group."
  default     = null
}

variable "virtual_desktop_application_group_default_desktop_display_name" {
  description = "(Optional) Option to set the display name for the default sessionDesktop desktop when type is set to Desktop"
  default     = null
}

variable "virtual_desktop_application_group_description" {
  description = "(Optional) Option to set a description for the Virtual Desktop Application Group."
  default     = null
}

variable "virtual_desktop_application_group_timeouts" {
  description = "Set timeouts for virtual desktop application group"
  default     = {}
}