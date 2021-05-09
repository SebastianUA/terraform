#---------------------------------------------------
# AWS EMR managed scaling policy
#---------------------------------------------------
resource "aws_emr_managed_scaling_policy" "emr_managed_scaling_policy" {
  count = var.enable_emr_managed_scaling_policy ? 1 : 0

  cluster_id = var.emr_managed_scaling_policy_cluster_id != "" ? var.emr_managed_scaling_policy_cluster_id : (var.enable_emr_cluster ? aws_emr_cluster.emr_cluster.0.id : null)

  dynamic "compute_limits" {
    iterator = compute_limits
    for_each = var.emr_managed_scaling_policy_compute_limits

    content {
      unit_type                       = lookup(compute_limits.value, "unit_type", null)
      minimum_capacity_units          = lookup(compute_limits.value, "minimum_capacity_units", null)
      maximum_capacity_units          = lookup(compute_limits.value, "maximum_capacity_units", null)
      maximum_ondemand_capacity_units = lookup(compute_limits.value, "maximum_ondemand_capacity_units", null)
      maximum_core_capacity_units     = lookup(compute_limits.value, "maximum_core_capacity_units", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_emr_cluster.emr_cluster
  ]
}