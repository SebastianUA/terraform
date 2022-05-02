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
# Azure disk pool
#-----------------------------------------------------------
variable "enable_disk_pool" {
  description = "Enable disk pool usage"
  default     = false
}

variable "disk_pool_name" {
  description = "The name of the Disk Pool. Changing this forces a new Disk Pool to be created."
  default     = ""
}

variable "disk_pool_resource_group_name" {
  description = "(Required) The name of the Resource Group where the Disk Pool should exist. Changing this forces a new Disk Pool to be created."
  default     = null
}

variable "disk_pool_location" {
  description = "(Required) The Azure Region where the Disk Pool should exist. Changing this forces a new Disk Pool to be created."
  default     = null
}

variable "disk_pool_sku_name" {
  description = "(Required) The SKU of the Disk Pool. Possible values are Basic_B1, Standard_S1 and Premium_P1. Changing this forces a new Disk Pool to be created."
  default     = null
}

variable "disk_pool_subnet_id" {
  description = "(Required) The ID of the Subnet where the Disk Pool should be created. Changing this forces a new Disk Pool to be created."
  default     = null
}

variable "disk_pool_zones" {
  description = "(Required) Specifies a list of Availability Zones in which this Disk Pool should be located. Changing this forces a new Disk Pool to be created."
  default     = null
}

variable "disk_pool_timeouts" {
  description = "Set timeouts disk pool"
  default     = {}
}

#-----------------------------------------------------------
# Azure disk pool managed disk attachment
#-----------------------------------------------------------
variable "enable_disk_pool_managed_disk_attachment" {
  description = "Enable disk pool managed disk attachment usage"
  default     = false
}

variable "disk_pool_managed_disk_attachment_disk_pool_id" {
  description = "The ID of the Disk Pool. Changing this forces a new Disk Pool Managed Disk Attachment to be created."
  default     = ""
}

variable "disk_pool_managed_disk_attachment_managed_disk_id" {
  description = "(Required) The ID of the Managed Disk. Changing this forces a new Disks Pool Managed Disk Attachment to be created."
  default     = null
}

variable "disk_pool_managed_disk_attachment_timeouts" {
  description = "Set timeouts for disk pool managed disk attachment"
  default     = {}
}

#-----------------------------------------------------------
# Azure disk pool iscsi target
#-----------------------------------------------------------
variable "enable_disk_pool_iscsi_target" {
  description = "Enable disk pool iscsi target usage"
  default     = false
}

variable "disk_pool_iscsi_target_name" {
  description = "(Required) The name of the iSCSI Target. The name can only contain lowercase letters, numbers, periods, or hyphens, and length should between [5-223]. Changing this forces a new iSCSI Target to be created."
  default     = ""
}

variable "disk_pool_iscsi_target_acl_mode" {
  description = "(Required) Mode for Target connectivity. The only supported value is Dynamic for now. Changing this forces a new iSCSI Target to be created."
  default     = null
}

variable "disk_pool_iscsi_target_disks_pool_id" {
  description = "The ID of the Disk Pool. Changing this forces a new iSCSI Target to be created."
  default     = ""
}

variable "disk_pool_iscsi_target_target_iqn" {
  description = "(Optional) ISCSI Target IQN (iSCSI Qualified Name); example: iqn.2005-03.org.iscsi:server. IQN should follow the format iqn.yyyy-mm.<abc>.<pqr>[:xyz]; supported characters include alphanumeric characters in lower case, hyphen, dot and colon, and the length should between 4 and 223. Changing this forces a new iSCSI Target to be created."
  default     = null
}

variable "disk_pool_iscsi_target_timeouts" {
  description = "Set timeouts for disk pool iscsi target"
  default     = {}
}

#-----------------------------------------------------------
# Azure disk pool iscsi target lun
#-----------------------------------------------------------
variable "enable_disk_pool_iscsi_target_lun" {
  description = "Enable disk pool iscsi target lun usage"
  default     = false
}

variable "disk_pool_iscsi_target_lun_name" {
  description = "User defined name for iSCSI LUN. Supported characters include uppercase letters, lowercase letters, numbers, periods, underscores or hyphens. Name should end with an alphanumeric character. The length must be between 1 and 90. Changing this forces a new iSCSI Target LUN to be created."
  default     = ""
}

variable "disk_pool_iscsi_target_lun_iscsi_target_id" {
  description = "The ID of the iSCSI Target. Changing this forces a new iSCSI Target LUN to be created."
  default     = ""
}

variable "disk_pool_iscsi_target_lun_disk_pool_managed_disk_attachment_id" {
  description = "The ID of the azurerm_disk_pool_managed_disk_attachment. Changing this forces a new iSCSI Target LUN to be created."
  default     = ""
}

variable "disk_pool_iscsi_target_lun_timeouts" {
  description = "Set timeouts for disk pool iscsi target lun"
  default     = {}
}