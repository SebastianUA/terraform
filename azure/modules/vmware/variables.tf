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
# Azure vmware private cloud
#-----------------------------------------------------------
variable "enable_vmware_private_cloud" {
  description = "Enable vmware private cloud usage"
  default     = false
}

variable "vmware_private_cloud_name" {
  description = "The name which should be used for this VMware Private Cloud. Changing this forces a new VMware Private Cloud to be created."
  default     = ""
}

variable "vmware_private_cloud_resource_group_name" {
  description = "(Required) The name of the Resource Group where the VMware Private Cloud should exist. Changing this forces a new VMware Private Cloud to be created."
  default     = null
}

variable "vmware_private_cloud_location" {
  description = "(Required) The Azure Region where the VMware Private Cloud should exist. Changing this forces a new VMware Private Cloud to be created."
  default     = null
}

variable "vmware_private_cloud_network_subnet_cidr" {
  description = "(Required) The subnet which should be unique across virtual network in your subscription as well as on-premise. Changing this forces a new VMware Private Cloud to be created."
  default     = null
}

variable "vmware_private_cloud_sku_name" {
  description = "(Required) The Name of the SKU used for this Private Cloud. Possible values are av20, av36 and av36t. Changing this forces a new VMware Private Cloud to be created."
  default     = null
}

variable "vmware_private_cloud_management_cluster" {
  description = "(Required) A management_cluster block"
  default     = {}
}

variable "vmware_private_cloud_internet_connection_enabled" {
  description = "(Optional) Is the Private Cluster connected to the internet? This field can not updated with management_cluster.0.size together. ~> NOTE : internet_connection_enabled and management_cluster.0.size cannot be updated at the same time"
  default     = null
}

variable "vmware_private_cloud_nsxt_password" {
  description = "(Optional) The password of the NSX-T Manager. Changing this forces a new VMware Private Cloud to be created."
  default     = null
}

variable "vmware_private_cloud_vcenter_password" {
  description = "(Optional) The password of the vCenter admin. Changing this forces a new VMware Private Cloud to be created."
  default     = null
}

variable "vmware_private_cloud_timeouts" {
  description = "Set timeouts for vmware private cloud"
  default     = {}
}

#-----------------------------------------------------------
# Azure vmware cluster
#-----------------------------------------------------------
variable "enable_vmware_cluster" {
  description = "Enable vmware cluster usage"
  default     = false
}

variable "vmware_cluster_name" {
  description = "The name which should be used for this VMware Cluster. Changing this forces a new VMware Cluster to be created."
  default     = ""
}

variable "vmware_cluster_vmware_cloud_id" {
  description = "The ID of the VMware Private Cloud in which to create this VMware Cluster. Changing this forces a new VMware Cluster to be created."
  default     = ""
}

variable "vmware_cluster_cluster_node_count" {
  description = "(Required) The count of the VMware Cluster nodes."
  default     = 1
}

variable "vmware_cluster_sku_name" {
  description = "(Required) The cluster SKU to use. Possible values are av20, av36, and av36t. Changing this forces a new VMware Cluster to be created."
  default     = null
}

variable "vmware_cluster_timeouts" {
  description = "Set timeouts for vmware cluster"
  default     = {}
}

#-----------------------------------------------------------
# Azure vmware express route authorization
#-----------------------------------------------------------
variable "enable_vmware_express_route_authorization" {
  description = "Enable vmware express route authorization usage"
  default     = false
}

variable "vmware_express_route_authorization_name" {
  description = "The name which should be used for this Express Route VMware Authorization. Changing this forces a new VMware Authorization to be created."
  default     = ""
}

variable "vmware_express_route_authorization_private_cloud_id" {
  description = "The ID of the VMware Private Cloud in which to create this Express Route VMware Authorization. Changing this forces a new VMware Authorization to be created."
  default     = ""
}

variable "vmware_express_route_authorization_timeouts" {
  description = "Set timeouts for vmware express route authorization"
  default     = {}
}