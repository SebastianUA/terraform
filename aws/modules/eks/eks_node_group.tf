#---------------------------------------------------
# AWS EKS node group
#---------------------------------------------------
resource "aws_eks_node_group" "eks_node_group" {
  count = var.enable_eks_node_group ? 1 : 0

  node_group_name = var.eks_node_group_node_group_name != "" ? lower(var.eks_node_group_node_group_name) : "${lower(var.name)}-node-group-${lower(var.environment)}"
  cluster_name    = var.eks_node_group_cluster_name != "" ? var.eks_node_group_cluster_name : element(concat(aws_eks_cluster.eks_cluster.*.name, aws_eks_cluster.eks_cluster_encryption.*.name, [""], ), 0)
  node_role_arn   = var.eks_node_group_node_role_arn
  subnet_ids      = var.eks_node_group_subnet_ids

  scaling_config {
    desired_size = var.eks_node_group_scaling_config_desired_size
    max_size     = var.eks_node_group_scaling_config_max_size
    min_size     = var.eks_node_group_scaling_config_min_size
  }

  ami_type        = var.eks_node_group_ami_type
  disk_size       = var.eks_node_group_disk_size
  instance_types  = var.eks_node_group_instance_types
  labels          = var.eks_node_group_labels
  release_version = var.eks_node_group_release_version
  version         = var.eks_node_group_version

  dynamic "remote_access" {
    for_each = var.eks_node_group_remote_access
    content {
      ec2_ssh_key               = lookup(eks_node_group_remote_access.value, "ec2_ssh_key", null)
      source_security_group_ids = lookup(eks_node_group_remote_access.value, "source_security_group_ids", null)
    }
  }

  tags = merge(
    {
      "Name" = var.eks_node_group_node_group_name != "" ? lower(var.eks_node_group_node_group_name) : "${lower(var.name)}-node-group-${lower(var.environment)}"
    },
    var.tags
  )

  timeouts {
    create = var.eks_fargate_profile_create
    delete = var.eks_fargate_profile_delete
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_cluster.eks_cluster_encryption
  ]
}
