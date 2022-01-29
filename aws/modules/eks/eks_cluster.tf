#---------------------------------------------------
# AWS EKS cluster
#---------------------------------------------------
resource "aws_eks_cluster" "eks_cluster" {
  count = var.enable_eks_cluster ? 1 : 0

  name     = var.eks_cluster_name != "" ? lower(var.eks_cluster_name) : "${lower(var.name)}-eks-${lower(var.environment)}"
  role_arn = var.eks_cluster_role_arn

  dynamic "vpc_config" {
    iterator = vpc_config
    for_each = var.eks_cluster_vpc_config

    content {
      subnet_ids = lookup(vpc_config.value, "subnet_ids", null)

      public_access_cidrs     = lookup(vpc_config.value, "public_access_cidrs", null)
      endpoint_private_access = lookup(vpc_config.value, "endpoint_private_access", null)
      endpoint_public_access  = lookup(vpc_config.value, "endpoint_public_access", null)
      security_group_ids      = lookup(vpc_config.value, "security_group_ids", null)
    }
  }

  enabled_cluster_log_types = var.eks_cluster_enabled_cluster_log_types
  version                   = var.eks_cluster_version

  dynamic "encryption_config" {
    iterator = encryption_config
    for_each = var.eks_cluster_encryption_config

    content {
      resources = lookup(encryption_config.value, "resources", null)

      dynamic "provider" {
        iterator = provider
        for_each = length(keys(lookup(encryption_config.value, "provider", {}))) > 0 ? [lookup(encryption_config.value, "provider", {})] : []

        content {
          key_arn = lookup(provider.value, "key_arn", null)
        }
      }
    }
  }

  // Blocks of type "kubernetes_network_config" are not expected here.
  // dynamic "kubernetes_network_config" {
  //   iterator = kubernetes_network_config
  //   for_each = var.eks_cluster_kubernetes_network_config
  //   content {
  //     service_ipv4_cidr = lookup(kubernetes_network_config.value, "service_ipv4_cidr", null)
  //   }
  // }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.eks_cluster_timeouts)) > 0 ? [var.eks_cluster_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.eks_cluster_name != "" ? lower(var.eks_cluster_name) : "${lower(var.name)}-eks-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
