#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS Workspaces directory
#---------------------------------------------------
variable "enable_workspaces_directory" {
  description = "Enable workspaces directory usage"
  default     = false
}

variable "workspaces_directory_directory_ids" {
  description = "(Required) The list of directories identifier for registration in WorkSpaces service."
  default     = null
}

variable "workspaces_directory_subnet_ids" {
  description = "(Optional) The identifiers of the subnets where the directory resides."
  default     = null
}

variable "workspaces_directory_ip_group_ids" {
  description = "The identifiers of the IP access control groups associated with the directory."
  default     = null
}

variable "workspaces_directory_self_service_permissions" {
  description = "(Optional) The permissions to enable or disable self-service capabilities."
  default     = []
}

variable "workspaces_directory_workspace_access_properties" {
  description = "(Optional) Specifies which devices and operating systems users can use to access their WorkSpaces."
  default     = []
}

variable "workspaces_directory_workspace_creation_properties" {
  description = "(Optional) Default properties that are used for creating WorkSpaces."
  default     = []
}

variable "workspaces_directory_name" {
  description = "Name for workplaces directory. Uses for tags."
  default     = ""
}

#---------------------------------------------------
# AWS Workspaces ip group
#---------------------------------------------------
variable "enable_workspaces_ip_group" {
  description = "Enable workspaces ip group usage"
  default     = false
}

variable "workspaces_ip_group_name" {
  description = "The name of the IP group."
  default     = ""
}

variable "workspaces_ip_group_description" {
  description = "(Optional) The description of the IP group."
  default     = null
}

variable "workspaces_ip_group_rules" {
  description = "(Optional) One or more pairs specifying the IP group rule (in CIDR format) from which web requests originate."
  default     = []
}

#---------------------------------------------------
# AWS Workspaces workspace
#---------------------------------------------------
variable "enable_workspaces_workspace" {
  description = "Enable workspaces workspace usage"
  default     = false
}

variable "workspaces_workspace_name" {
  description = "Set name for workplace"
  default     = ""
}

variable "workspaces_workspace_directory_id" {
  description = "The ID of the directory for the WorkSpace."
  default     = ""
}

variable "workspaces_workspace_bundle_id" {
  description = "(Required) The ID of the bundle for the WorkSpace."
  default     = null
}

variable "workspaces_workspace_user_name" {
  description = "(Required) The user name of the user for the WorkSpace. This user name must exist in the directory for the WorkSpace."
  default     = null
}

variable "workspaces_workspace_root_volume_encryption_enabled" {
  description = "(Optional) Indicates whether the data stored on the root volume is encrypted."
  default     = null
}

variable "workspaces_workspace_user_volume_encryption_enabled" {
  description = "(Optional) Indicates whether the data stored on the user volume is encrypted."
  default     = null
}

variable "workspaces_workspace_volume_encryption_key" {
  description = "(Optional) The symmetric AWS KMS customer master key (CMK) used to encrypt data stored on your WorkSpace. Amazon WorkSpaces does not support asymmetric CMKs."
  default     = null
}

variable "workspaces_workspace_workspace_properties" {
  description = "(Optional) The WorkSpace properties"
  default     = []
}

variable "workspaces_workspace_timeouts" {
  description = "Set timeouts for workspaces workspace"
  default     = {}
}
