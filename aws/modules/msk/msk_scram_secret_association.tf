#---------------------------------------------------
# AWS MSK scram secret association
#---------------------------------------------------
resource "aws_msk_scram_secret_association" "msk_scram_secret_association" {
  count = var.enable_msk_scram_secret_association ? 1 : 0

  cluster_arn     = var.msk_scram_secret_association_cluster_arn != "" ? var.msk_scram_secret_association_cluster_arn : (var.enable_msk_cluster ? element(aws_msk_cluster.msk_cluster.*.arn, 0) : null)
  secret_arn_list = var.msk_scram_secret_association_secret_arn_list

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_msk_cluster.msk_cluster
  ]
}
