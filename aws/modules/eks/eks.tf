#---------------------------------------------------
# AWS eks cluster
#---------------------------------------------------
resource "aws_eks_cluster" "eks_cluster" {
    count                       = "${var.eks_cluster ? 1 : 0}"

    name                        = "${var.eks_cluster_name !="" ? "${lower(var.eks_cluster_name)}" : "${lower(var.name)}-eks-${lower(var.environment)}" }"
    role_arn                    = "${var.eks_role_arn}"
    enabled_cluster_log_types   = "${var.eks_enabled_cluster_log_types}"
    version                     = "${var.eks_version}"

    vpc_config {
        subnet_ids              = ["${var.eks_vpc_config_subnet_ids}"]
        endpoint_private_access = "${var.eks_vpc_config_endpoint_private_access}"
        endpoint_public_access  = "${var.eks_vpc_config_endpoint_public_access}"
        security_group_ids      = ["${var.eks_vpc_config_security_group_ids}"]
    }

    timeouts {
        create = "${var.eks_timeouts_create}"
        update = "${var.eks_timeouts_update}"
        delete = "${var.eks_timeouts_delete}"
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = []
}
