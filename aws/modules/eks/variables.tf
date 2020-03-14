#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-EKS"
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

#-----------------------------------------------------------
# AWS EKS
#-----------------------------------------------------------
variable "eks_cluster" {
    description = "Enable creating AWS EKS cluster"
    default     = "false"
}

variable "eks_cluster_name" {
    description = "Custom name of the cluster."
    default     = ""
}

variable "eks_role_arn" {
    description = "(Required) The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf."
    default     = ""
}

variable "eks_enabled_cluster_log_types" {
    description = "(Optional) A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging"
    type        = "list"
    default     = []
}

variable "eks_version" {
    description = "(Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
    default     = ""
}

variable "eks_vpc_config_subnet_ids" {
    description = "(Required) List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
    type        = "list"
    default     = []
}

variable "eks_vpc_config_endpoint_private_access" {
    description = "(Optional) Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false."
    default     = "false"
}

variable "eks_vpc_config_endpoint_public_access" {
    description = "(Optional) Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true."
    default     = "true"
}

variable "eks_vpc_config_security_group_ids" {
    description = "(Optional) List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
    type        = "list"
    default     = []
}

variable "eks_timeouts_create" {
    description = "(Default 30 minutes) How long to wait for the EKS Cluster to be created."
    default     = "30m"
}

variable "eks_timeouts_update" {
    description = "(Default 60 minutes) How long to wait for the EKS Cluster to be updated. Note that the update timeout is used separately for both version and vpc_config update timeouts."
    default     = "60m"
}

variable "eks_timeouts_delete" {
    description = "(Default 15 minutes) How long to wait for the EKS Cluster to be deleted."
    default     = "15m"
}
