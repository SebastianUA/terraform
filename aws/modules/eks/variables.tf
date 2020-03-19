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

variable "tags" {
    description = "A list of tag blocks."
    type        = map(string)
    default     = {}
}

#-----------------------------------------------------------
# AWS EKS cluster
#-----------------------------------------------------------
variable "enable_eks_cluster" {
    description = "Enable creating AWS EKS cluster"
    default     = false
}

variable "enable_eks_cluster_encryption" {
    description   = "Enable creating AWS EKS cluster with encryption config"
    default       = false
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
    default     = []
}

variable "eks_version" {
    description = "(Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
    default     = null
}

variable "eks_vpc_config_subnet_ids" {
    description = "(Required) List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
    default     = []
}

variable "eks_vpc_config_endpoint_private_access" {
    description = "(Optional) Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false."
    default     = false
}

variable "eks_vpc_config_endpoint_public_access" {
    description = "(Optional) Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true."
    default     = true
}

variable "eks_vpc_config_security_group_ids" {
    description = "(Optional) List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
    default     = null
}

variable "eks_vpc_config_public_access_cidrs" {
    description = "(Optional) List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. Terraform will only perform drift detection of its value when present in a configuration."
    default     = ["0.0.0.0/0"]
}

variable "encryption_config_provider_key_arn" {
    description = "(Required) Amazon Resource Name (ARN) of the Key Management Service (KMS) customer master key (CMK). The CMK must be symmetric, created in the same region as the cluster, and if the CMK was created in a different account, the user must have access to the CMK. For more information, see Allowing Users in Other Accounts to Use a CMK in the AWS Key Management Service Developer Guide."
    default     = ""
}

variable "encryption_config_resources" {
    description = "(Required) List of strings with resources to be encrypted. Valid values: secrets"
    default     = ["secrets"]
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

#---------------------------------------------------
# AWS EKS fargate profile
#---------------------------------------------------
variable "enable_eks_fargate_profile" {
    description = "Enable EKS fargate profile usage"
    default     = false
}

variable "fargate_profile_name" {
    description = "Name of the EKS Fargate Profile."
    default     = ""
}

variable "eks_fargate_profile_cluster_name" {
    description = "Name of the EKS Cluster."
    default     = ""
}

variable "eks_fargate_profile_pod_execution_role_arn" {
    description = "(Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Fargate Profile."
    default     = ""
}

variable "eks_fargate_profile_subnet_ids" {
    description = "(Required) Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
    default     = []
}

variable "eks_fargate_profile_selector_namespace" {
    description = "(Required) Kubernetes namespace for selection."
    default     = ""
}

variable "eks_fargate_profile_selector_labels" {
    description = "(Optional) Key-value mapping of Kubernetes labels for selection."
    type        = map(string)
    default     = {}
}

variable "eks_fargate_profile_create" {
    description = "(Default 10 minutes) How long to wait for the EKS Fargate Profile to be created."
    default     = "10m"
}

variable "eks_fargate_profile_delete" {
    description = "(Default 10 minutes) How long to wait for the EKS Fargate Profile to be deleted."
    default     = "10m"
}

#---------------------------------------------------
# AWS EKS node group
#---------------------------------------------------
variable "enable_eks_node_group" {
    description = "Enable EKS node group usage"
    default     = false
}

variable "eks_node_group_node_group_name" {
    description = "Name of the EKS Node Group."
    default     = ""
}

variable "eks_node_group_cluster_name" {
    description = "Name of the EKS Cluster."
    default     = ""
}

variable "eks_node_group_node_role_arn" {
    description = "(Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group."
    default     = ""
}

variable "eks_node_group_subnet_ids" {
    description = "(Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
    default     = []
}

variable "eks_node_group_scaling_config_desired_size" {
    description = "(Required) Desired number of worker nodes."
    default     = 1
}

variable "eks_node_group_scaling_config_max_size" {
    description = "(Required) Maximum number of worker nodes."
    default     = 1
}

variable "eks_node_group_scaling_config_min_size" {
    description = "(Required) Minimum number of worker nodes."
    default     = 1
}

variable "eks_node_group_ami_type" {
    description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU. Terraform will only perform drift detection if a configuration value is provided."
    default     = "AL2_x86_64"
}

variable "eks_node_group_disk_size" {
    description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided."
    default     = 20
}

variable "eks_node_group_instance_types" {
    description = "(Optional) Set of instance types associated with the EKS Node Group. Defaults to ['t3.medium']. Terraform will only perform drift detection if a configuration value is provided. Currently, the EKS API only accepts a single value in the set."
    default     = ["t3.medium"]
}

variable "eks_node_group_labels" {
    description = "(Optional) Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed."
    type        = map(string)
    default     = {}
}

variable "eks_node_group_release_version" {
    description = "(Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version."
    default     = null
}

variable "eks_node_group_version" {
    description = "(Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided."
    default     = null
}

variable "eks_node_group_remote_access" {
    description = "(Optional) Configuration block with remote access settings."
    default     = []
}
