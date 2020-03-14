output "aws_eks_endpoint" {
    description = ""
    value       = "${aws_eks_cluster.eks_cluster.endpoint}"
}

output "aws_eks_kubeconfig-certificate-authority-data" {
    description = ""
    value       = "${aws_eks_cluster.eks_cluster.certificate_authority.0.data}"
}
