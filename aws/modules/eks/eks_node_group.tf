#---------------------------------------------------
# AWS EKS node group
#---------------------------------------------------
resource "aws_eks_node_group" "eks_node_group" {
  count = var.enable_eks_node_group ? 1 : 0

  cluster_name    = var.eks_node_group_cluster_name != "" ? var.eks_node_group_cluster_name : (var.enable_eks_cluster ? element(aws_eks_cluster.eks_cluster.*.name, 0) : null)
  node_group_name = var.eks_node_group_node_group_name != "" ? lower(var.eks_node_group_node_group_name) : "${lower(var.name)}-node-group-${lower(var.environment)}"
  node_role_arn   = var.eks_node_group_node_role_arn
  subnet_ids      = var.eks_node_group_subnet_ids

  dynamic "scaling_config" {
    iterator = scaling_config
    for_each = var.eks_node_group_scaling_config

    content {
      max_size     = lookup(scaling_config.value, "max_size", null)
      desired_size = lookup(scaling_config.value, "desired_size", null)
      min_size     = lookup(scaling_config.value, "min_size", null)
    }
  }

  ami_type = var.eks_node_group_ami_type
  // capacity_type        = var.eks_node_group_capacity_type
  disk_size            = var.eks_node_group_disk_size
  force_update_version = var.eks_node_group_force_update_version
  instance_types       = var.eks_node_group_instance_types
  labels               = var.eks_node_group_labels
  release_version      = var.eks_node_group_release_version
  version              = var.eks_node_group_version

  dynamic "remote_access" {
    iterator = remote_access
    for_each = var.eks_node_group_remote_access

    content {
      ec2_ssh_key               = lookup(remote_access.value, "ec2_ssh_key", null)
      source_security_group_ids = lookup(remote_access.value, "source_security_group_ids", null)
    }
  }

  dynamic "launch_template" {
    iterator = launch_template
    for_each = var.eks_node_group_launch_template

    content {
      id      = lookup(launch_template.value, "id", null)
      name    = lookup(launch_template.value, "name", null)
      version = lookup(launch_template.value, "version", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.eks_node_group_timeouts)) > 0 ? [var.eks_node_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.eks_node_group_node_group_name != "" ? lower(var.eks_node_group_node_group_name) : "${lower(var.name)}-node-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}
