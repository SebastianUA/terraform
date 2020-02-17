#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}    

variable "tags" {
  description   = "Add additional tags"
  default       = {}
}

#---------------------------------------------------
# AWS cloudhsm v2 cluster
#---------------------------------------------------
variable "enable_cloudhsm_v2_cluster" {
  description = "Enable cloudhsm v2 cluster usage"
  default     = false
}

variable "cloudhsm_v2_cluster_hsm_type" {
  description = "(Required) The type of HSM module in the cluster. Currently, only hsm1.medium is supported."
  default     = "hsm1.medium"
}

variable "cloudhsm_v2_cluster_subnet_ids" {
  description = "(Required) The IDs of subnets in which cluster will operate."
  default     = []
}

variable "cloudhsm_v2_cluster_source_backup_identifier" {
  description = "(Optional) The id of Cloud HSM v2 cluster backup to be restored."
  default     = null
}

variable "cloudhsm_v2_cluster_name" {
  description = "Name for cloudhsm v2 cluster"
  default     = ""
}

#---------------------------------------------------
# AWS cloudhsm v2 hsm
#---------------------------------------------------
variable "enable_cloudhsm_v2_hsm" {
  description = "Enable cloudhsm v2 hsm usage"
  default     = false
}

variable "cloudhsm_v2_hsm_subnet_id" {
  description = "(Optional) The ID of subnet in which HSM module will be located."
  default     = ""
}

variable "cloudhsm_v2_hsm_cluster_id" {
  description = "(Required) The ID of Cloud HSM v2 cluster to which HSM will be added."
  default     = ""
}

variable "cloudhsm_v2_hsm_availability_zone" {
  description = "(Optional) The IDs of AZ in which HSM module will be located. Do not use together with subnet_id."
  default     = null
}

variable "cloudhsm_v2_hsm_ip_address" {
  description = "(Optional) The IP address of HSM module. Must be within the CIDR of selected subnet."
  default     = null
}