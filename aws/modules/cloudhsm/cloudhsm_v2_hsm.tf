#---------------------------------------------------
# AWS cloudhsm v2 hsm
#---------------------------------------------------
resource "aws_cloudhsm_v2_hsm" "cloudhsm_v2_hsm" {
  count = var.enable_cloudhsm_v2_hsm ? 1 : 0

  subnet_id  = var.cloudhsm_v2_hsm_subnet_id
  cluster_id = var.cloudhsm_v2_hsm_cluster_id != "" && ! var.enable_cloudhsm_v2_cluster ? var.cloudhsm_v2_hsm_cluster_id : element(concat(aws_cloudhsm_v2_cluster.cloudhsm_v2_cluster.*.cluster_id, [""]), 0)

  availability_zone = var.cloudhsm_v2_hsm_availability_zone != null ? var.cloudhsm_v2_hsm_availability_zone : null
  ip_address        = var.cloudhsm_v2_hsm_ip_address != null ? var.cloudhsm_v2_hsm_ip_address : null

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cloudhsm_v2_cluster.cloudhsm_v2_cluster
  ]

}
