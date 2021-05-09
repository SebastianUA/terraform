#---------------------------------------------------
# AWS EMR instance group
#---------------------------------------------------
resource "aws_emr_instance_group" "emr_instance_group" {
  count = var.enable_emr_instance_group ? 1 : 0

  name          = var.emr_instance_group_name != "" ? var.emr_instance_group_name : "${lower(var.name)}-emr-instance-group-${lower(var.environment)}"
  cluster_id    = var.emr_instance_group_cluster_id != "" && !var.enable_emr_cluster ? var.emr_instance_group_cluster_id : element(concat(aws_emr_cluster.emr_cluster.*.id, [""]), 0)
  instance_type = var.emr_instance_group_instance_type

  instance_count      = var.emr_instance_group_instance_count
  bid_price           = var.emr_instance_group_bid_price
  ebs_optimized       = var.emr_instance_group_ebs_optimized
  autoscaling_policy  = var.emr_instance_group_autoscaling_policy
  configurations_json = var.emr_instance_group_configurations_json

  dynamic "ebs_config" {
    iterator = ebs_config
    for_each = var.emr_instance_group_ebs_config

    content {
      size = lookup(ebs_config.value, "size", null)
      type = lookup(ebs_config.value, "type", null)

      iops                 = lookup(ebs_config.value, "iops", null)
      volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
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
