#---------------------------------------------------
# AWS cloudhsm v2 cluster
#---------------------------------------------------
resource "aws_cloudhsm_v2_cluster" "cloudhsm_v2_cluster" {
  count = var.enable_cloudhsm_v2_cluster ? 1 : 0

  hsm_type   = var.cloudhsm_v2_cluster_hsm_type
  subnet_ids = var.cloudhsm_v2_cluster_subnet_ids

  source_backup_identifier = var.cloudhsm_v2_cluster_source_backup_identifier != null ? var.cloudhsm_v2_cluster_source_backup_identifier : null

  tags = merge(
    {
      Name = var.cloudhsm_v2_cluster_name != "" ? lower(var.cloudhsm_v2_cluster_name) : "${lower(var.name)}-cloudhsm-v2-cluster-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
