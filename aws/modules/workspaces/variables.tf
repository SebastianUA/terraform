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

variable "workspaces_directory_self_service_permissions" {
  description = "(Optional) The permissions to enable or disable self-service capabilities."
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
