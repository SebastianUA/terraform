#---------------------------------------------------
# AWS RDS cluster instance
#---------------------------------------------------
resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  count = var.enable_rds_cluster_instance ? var.number_rds_cluster_instances : 0

  identifier         = var.rds_cluster_instance_identifier != "" && var.rds_cluster_instance_identifier_prefix == "" ? "${lower(var.rds_cluster_instance_identifier)}-${count.index + 1}" : null
  identifier_prefix  = var.rds_cluster_instance_identifier_prefix != "" && var.rds_cluster_instance_identifier == "" ? "${lower(var.rds_cluster_instance_identifier_prefix)}-${count.index + 1}" : null
  cluster_identifier = var.rds_cluster_instance_cluster_identifier != "" && !var.enable_rds_cluster ? lower(var.rds_cluster_instance_cluster_identifier) : element(concat(aws_rds_cluster.rds_cluster.*.id, [""]), 0)
  instance_class     = var.rds_cluster_instance_instance_class

  engine         = var.rds_cluster_instance_engine
  engine_version = var.rds_cluster_instance_engine_version

  publicly_accessible     = var.rds_cluster_instance_publicly_accessible
  db_subnet_group_name    = var.rds_cluster_instance_db_subnet_group_name != "" && !var.enable_db_subnet_group ? lower(var.rds_cluster_instance_db_subnet_group_name) : element(concat(aws_db_subnet_group.db_subnet_group.*.id, [""]), 0)
  db_parameter_group_name = var.rds_cluster_instance_db_parameter_group_name != "" && !var.enable_db_parameter_group ? var.rds_cluster_instance_db_parameter_group_name : element(concat(aws_rds_cluster_parameter_group.rds_cluster_parameter_group.*.id, [""]), 0)
  promotion_tier          = var.rds_cluster_instance_promotion_tier
  availability_zone       = var.rds_cluster_instance_availability_zone
  ca_cert_identifier      = var.rds_cluster_instance_ca_cert_identifier

  monitoring_role_arn = var.rds_cluster_instance_monitoring_role_arn
  monitoring_interval = var.rds_cluster_instance_monitoring_interval

  preferred_backup_window      = var.rds_cluster_instance_preferred_backup_window
  preferred_maintenance_window = var.rds_cluster_instance_preferred_maintenance_window
  apply_immediately            = var.rds_cluster_instance_apply_immediately
  auto_minor_version_upgrade   = var.rds_cluster_instance_auto_minor_version_upgrade

  performance_insights_enabled    = var.rds_cluster_instance_performance_insights_enabled
  performance_insights_kms_key_id = var.rds_cluster_instance_performance_insights_kms_key_id

  copy_tags_to_snapshot = var.rds_cluster_instance_copy_tags_to_snapshot

  dynamic "timeouts" {
    iterator = timeouts
    for_each = var.rds_cluster_instance_timeouts
    # var.length(keys(var.rds_cluster_instance_timeouts)) > 0 ? [var.rds_cluster_instance_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.rds_cluster_instance_identifier != "" && var.rds_cluster_instance_identifier_prefix == "" ? lower(var.rds_cluster_instance_identifier) : lower(var.rds_cluster_instance_identifier_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_rds_cluster.rds_cluster,
    aws_db_subnet_group.db_subnet_group,
    aws_rds_cluster_parameter_group.rds_cluster_parameter_group
  ]
}
