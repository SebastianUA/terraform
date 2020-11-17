#---------------------------------------------------
# AWS EKS cluster
#---------------------------------------------------
output "aws_eks_id" {
  description = "The name of the cluster."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.id, aws_eks_cluster.eks_cluster_encryption.*.id, [""], ), 0)
}

output "aws_eks_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.arn, aws_eks_cluster.eks_cluster_encryption.*.arn, [""], ), 0)
}

output "aws_eks_endpoint" {
  description = "The endpoint for your Kubernetes API server."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.endpoint, aws_eks_cluster.eks_cluster_encryption.*.endpoint, [""], ), 0)
}

output "aws_eks_platform_version" {
  description = "The platform version for the cluster."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.platform_version, aws_eks_cluster.eks_cluster_encryption.*.platform_version, [""], ), 0)
}

output "aws_eks_status" {
  description = "TThe status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.status, aws_eks_cluster.eks_cluster_encryption.*.status, [""], ), 0)
}

output "aws_eks_version" {
  description = "The Kubernetes server version for the cluster."
  value       = element(concat(aws_eks_cluster.eks_cluster.*.version, aws_eks_cluster.eks_cluster_encryption.*.version, [""], ), 0)
}

#---------------------------------------------------
# AWS EKS fargate profile
#---------------------------------------------------
output "eks_fargate_profile_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profile."
  value       = element(concat(aws_eks_fargate_profile.eks_fargate_profile.*.arn, [""], ), 0)
}

output "eks_fargate_profile_id" {
  description = "EKS Cluster name and EKS Fargate Profile name separated by a colon (:)."
  value       = element(concat(aws_eks_fargate_profile.eks_fargate_profile.*.id, [""], ), 0)
}

output "eks_fargate_profile_status" {
  description = "Status of the EKS Fargate Profile."
  value       = element(concat(aws_eks_fargate_profile.eks_fargate_profile.*.status, [""], ), 0)
}

#---------------------------------------------------
# AWS EKS node group
#---------------------------------------------------
output "eks_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group."
  value       = element(concat(aws_eks_node_group.eks_node_group.*.arn, [""], ), 0)
}

output "eks_node_group_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon (:)."
  value       = element(concat(aws_eks_node_group.eks_node_group.*.id, [""], ), 0)
}

output "eks_node_group_status" {
  description = "Status of the EKS Node Group."
  value       = element(concat(aws_eks_node_group.eks_node_group.*.status, [""], ), 0)
}
