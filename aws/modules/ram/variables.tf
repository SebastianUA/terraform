#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "Set region"
  default     = "us-east-1"
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
# AWS ram resource share
#---------------------------------------------------
variable "enable_ram_resource_share" {
  description = "Enable ram resource share usage"
  default     = false
}

variable "ram_resource_share_name" {
  description = "The name of the resource share."
  default     = ""
}

variable "ram_resource_share_allow_external_principals" {
  description = "(Optional) Indicates whether principals outside your organization can be associated with a resource share."
  default     = null
}

#---------------------------------------------------
# AWS ram resource association
#---------------------------------------------------
variable "enable_ram_resource_association" {
  description = "Enable ram resource association usage"
  default     = false
}

variable "ram_resource_association_resource_arn" {
  description = "(Required) Amazon Resource Name (ARN) of the resource to associate with the RAM Resource Share."
  default     = null
}

variable "ram_resource_association_resource_share_arn" {
  description = "Amazon Resource Name (ARN) of the RAM Resource Share."
  default     = ""
}

#---------------------------------------------------
# AWS ram principal association
#---------------------------------------------------
variable "enable_ram_principal_association" {
  description = "Enable ram principal association usage"
  default     = false
}

variable "ram_principal_association_principal" {
  description = "(Required) The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN."
  default     = null
}

variable "ram_principal_association_resource_share_arn" {
  description = "The Amazon Resource Name (ARN) of the resource share."
  default     = null
}

#---------------------------------------------------
# AWS ram resource share accepter
#---------------------------------------------------
variable "enable_ram_resource_share_accepter" {
  description = "Enable ram resource share accepter usage"
  default     = false
}

variable "ram_resource_share_accepter_share_arn" {
  description = "The ARN of the resource share."
  default     = ""
}
