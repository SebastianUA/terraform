#---------------------------------------------------
# AWS EKS cluster
#---------------------------------------------------
resource "aws_eks_cluster" "eks_cluster" {
  count = var.enable_eks_cluster && ! var.enable_eks_cluster_encryption ? 1 : 0

  name     = var.eks_cluster_name != "" ? lower(var.eks_cluster_name) : "${lower(var.name)}-eks-${lower(var.environment)}"
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.eks_vpc_config_subnet_ids

    public_access_cidrs     = var.eks_vpc_config_public_access_cidrs
    endpoint_private_access = var.eks_vpc_config_endpoint_private_access
    endpoint_public_access  = var.eks_vpc_config_endpoint_public_access
    security_group_ids      = var.eks_vpc_config_security_group_ids
  }

  enabled_cluster_log_types = var.eks_enabled_cluster_log_types
  version                   = var.eks_version

  dynamic "timeouts" {
    iterator = timeouts
    for_each = var.eks_cluster_timeouts
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

resource "aws_eks_cluster" "eks_cluster_encryption" {
  count = var.enable_eks_cluster_encryption && ! var.enable_eks_cluster ? 1 : 0

  name     = var.eks_cluster_name != "" ? lower(var.eks_cluster_name) : "${lower(var.name)}-eks-${lower(var.environment)}"
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.eks_vpc_config_subnet_ids

    public_access_cidrs     = var.eks_vpc_config_public_access_cidrs
    endpoint_private_access = var.eks_vpc_config_endpoint_private_access
    endpoint_public_access  = var.eks_vpc_config_endpoint_public_access
    security_group_ids      = var.eks_vpc_config_security_group_ids
  }

  enabled_cluster_log_types = var.eks_enabled_cluster_log_types
  version                   = var.eks_version

  encryption_config {
    provider {
      key_arn = var.encryption_config_provider_key_arn
    }
    resources = var.encryption_config_resources
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = var.eks_cluster_timeouts
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
