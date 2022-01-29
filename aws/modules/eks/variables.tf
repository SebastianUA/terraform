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

variable "eks_cluster_name" {
  description = "Custom name of the cluster."
  default     = ""
}

variable "eks_cluster_role_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf."
  default     = ""
}

variable "eks_cluster_enabled_cluster_log_types" {
  description = "(Optional) A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging"
  default     = []
}

variable "eks_cluster_version" {
  description = "(Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
  default     = null
}

variable "eks_cluster_vpc_config" {
  description = "(Required) Nested argument for the VPC associated with your cluster. Amazon EKS VPC resources have specific requirements to work properly with Kubernetes. For more information, see Cluster VPC Considerations and Cluster Security Group Considerations in the Amazon EKS User Guide."
  default     = []
}

variable "eks_cluster_encryption_config" {
  description = "(Optional) Configuration block with encryption configuration for the cluster. Only available on Kubernetes 1.13 and above clusters created after March 6, 2020."
  default     = []
}

// variable "eks_cluster_kubernetes_network_config" {
//   description = "(Optional) Configuration block with kubernetes network configuration for the cluster. If removed, Terraform will only perform drift detection if a configuration value is provided."
//   default     = []
// }

variable "eks_cluster_timeouts" {
  description = "Set timeouts for EKS cluster"
  default     = {}
}

#---------------------------------------------------
# AWS EKS fargate profile
#---------------------------------------------------
variable "enable_eks_fargate_profile" {
  description = "Enable EKS fargate profile usage"
  default     = false
}

variable "eks_fargate_profile_name" {
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

variable "eks_fargate_profile_selector" {
  description = "(Required) Configuration block(s) for selecting Kubernetes Pods to execute with this EKS Fargate Profile. "
  default     = []
}

variable "eks_fargate_profile_timeouts" {
  description = "Set timeouts for EKS fargate profile"
  default     = {}
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

variable "eks_node_group_scaling_config" {
  description = ""
  default = [
    {
      max_size     = 1
      desired_size = 1
      min_size     = 1
    }
  ]
}

variable "eks_node_group_ami_type" {
  description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU. Terraform will only perform drift detection if a configuration value is provided."
  default     = "AL2_x86_64"
}

// variable "eks_node_group_capacity_type" {
//   description = "(Optional) Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT. Terraform will only perform drift detection if a configuration value is provided."
//   default     = null
// }

variable "eks_node_group_disk_size" {
  description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided."
  default     = 20
}

variable "eks_node_group_force_update_version" {
  description = "(Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
  default     = null
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

variable "eks_node_group_launch_template" {
  description = "(Optional) Configuration block with Launch Template settings."
  default     = []
}

variable "eks_node_group_timeouts" {
  description = "Set timeouts for EKS node group"
  default     = {}
}
