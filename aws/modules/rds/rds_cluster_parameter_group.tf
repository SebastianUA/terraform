#---------------------------------------------------
# AWS RDS cluster parameter group
#---------------------------------------------------
resource "aws_rds_cluster_parameter_group" "rds_cluster_parameter_group" {
  count = var.enable_rds_cluster_parameter_group ? 1 : 0

  name        = var.rds_cluster_parameter_group_name != "" ? lower(var.rds_cluster_parameter_group_name) : null
  name_prefix = var.rds_cluster_parameter_group_name_prefix != "" ? lower(var.rds_cluster_parameter_group_name_prefix) : null
  description = var.rds_cluster_parameter_group_description
  family      = var.rds_cluster_parameter_group_family != "" ? var.rds_cluster_parameter_group_family : lookup(var.db_group_family, var.rds_cluster_engine)

  dynamic "parameter" {
    iterator = parameter
    for_each = var.rds_cluster_parameter_group_parameters

    content {
      name         = lookup(parameter.value, "name", null)
      value        = lookup(parameter.value, "value", null)
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(
    {
      Name = var.rds_cluster_parameter_group_name != "" && var.rds_cluster_parameter_group_name_prefix == "" ? lower(var.rds_cluster_parameter_group_name) : lower(var.rds_cluster_parameter_group_name_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
