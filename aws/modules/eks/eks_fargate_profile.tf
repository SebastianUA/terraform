#---------------------------------------------------
# AWS EKS fargate profile
#---------------------------------------------------
resource "aws_eks_fargate_profile" "eks_fargate_profile" {
    count                       = var.enable_eks_fargate_profile ? 1 : 0

    fargate_profile_name        = var.fargate_profile_name != "" ? lower(var.fargate_profile_name) : "${lower(var.name)}-fargate-profile-${lower(var.environment)}"
    cluster_name                = var.eks_fargate_profile_cluster_name != "" ? var.eks_fargate_profile_cluster_name : element(concat(aws_eks_cluster.eks_cluster.*.name, aws_eks_cluster.eks_cluster_encryption.*.name, [""], ), 0)
    pod_execution_role_arn      = var.eks_fargate_profile_pod_execution_role_arn
    subnet_ids                  = var.eks_fargate_profile_subnet_ids

    selector {
        namespace   = var.eks_fargate_profile_selector_namespace
        labels      = var.eks_fargate_profile_selector_labels
    }

    tags = merge(
        {
            "Name"          = var.fargate_profile_name != "" ? lower(var.fargate_profile_name) : "${lower(var.name)}-fargate-profile-${lower(var.environment)}"
        },
        var.tags
    )

    timeouts {
        create = var.eks_fargate_profile_create
        delete = var.eks_fargate_profile_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_eks_cluster.eks_cluster,
        aws_eks_cluster.eks_cluster_encryption
    ]
}
