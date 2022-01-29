#---------------------------------------------------
# AWS EKS fargate profile
#---------------------------------------------------
resource "aws_eks_fargate_profile" "eks_fargate_profile" {
  count = var.enable_eks_fargate_profile ? 1 : 0

  fargate_profile_name   = var.eks_fargate_profile_name != "" ? lower(var.eks_fargate_profile_name) : "${lower(var.name)}-fargate-profile-${lower(var.environment)}"
  cluster_name           = var.eks_fargate_profile_cluster_name != "" ? var.eks_fargate_profile_cluster_name : element(aws_eks_cluster.eks_cluster.*.name, 0)
  pod_execution_role_arn = var.eks_fargate_profile_pod_execution_role_arn
  subnet_ids             = var.eks_fargate_profile_subnet_ids

  dynamic "selector" {
    iterator = selector
    for_each = var.eks_fargate_profile_selector

    content {
      namespace = lookup(selector.value, "namespace", null)

      labels = lookup(selector.value, "labels", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.eks_fargate_profile_timeouts)) > 0 ? [var.eks_fargate_profile_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.eks_fargate_profile_name != "" ? lower(var.eks_fargate_profile_name) : "${lower(var.name)}-fargate-profile-${lower(var.environment)}"
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
