#---------------------------------------------------
# AWS elasticache cluster
#---------------------------------------------------
resource "aws_elasticache_cluster" "elasticache_cluster" {
  count = var.enable_elasticache_cluster ? 1 : 0

  cluster_id           = var.elasticache_cluster_name != "" ? var.elasticache_cluster_name : "${lower(var.name)}-${lower(var.elasticache_cluster_engine != "" ? var.elasticache_cluster_engine : var.default_engine)}-${lower(var.environment)}"
  engine               = var.elasticache_cluster_engine != "" ? var.elasticache_cluster_engine : var.default_engine
  node_type            = var.elasticache_cluster_node_type
  num_cache_nodes      = var.elasticache_cluster_num_cache_nodes
  parameter_group_name = var.elasticache_cluster_parameter_group_name != null ? var.elasticache_cluster_parameter_group_name : (var.enable_elasticache_parameter_group ? aws_elasticache_parameter_group.elasticache_parameter_group[count.index].name : null)

  replication_group_id = var.elasticache_cluster_replication_group_id != null ? var.elasticache_cluster_replication_group_id : (var.elasticache_replication_group ? aws_elasticache_replication_group.elasticache_replication_group[count.index].id : null)
  engine_version       = var.elasticache_cluster_engine_version != null ? var.elasticache_cluster_engine_version : var.default_engine_version[var.default_engine]
  port                 = var.elasticache_cluster_port != null ? var.elasticache_cluster_port : var.default_ports[var.default_engine]

  subnet_group_name    = var.elasticache_cluster_subnet_group_name != null ? var.elasticache_cluster_subnet_group_name : (var.enable_elasticache_subnet_group ? aws_elasticache_subnet_group.elasticache_subnet_group[count.index].id : null)
  security_group_names = var.elasticache_cluster_security_group_names
  security_group_ids   = var.elasticache_cluster_security_group_ids
  apply_immediately    = var.elasticache_cluster_apply_immediately

  maintenance_window       = var.elasticache_cluster_maintenance_window
  snapshot_window          = var.elasticache_cluster_snapshot_window
  snapshot_retention_limit = var.elasticache_cluster_snapshot_retention_limit
  snapshot_arns            = var.elasticache_cluster_snapshot_arns
  snapshot_name            = var.elasticache_cluster_snapshot_name
  notification_topic_arn   = var.elasticache_cluster_notification_topic_arn

  availability_zone            = var.elasticache_cluster_availability_zone
  az_mode                      = var.elasticache_cluster_az_mode
  preferred_availability_zones = var.elasticache_cluster_preferred_availability_zones
  final_snapshot_identifier    = var.elasticache_cluster_final_snapshot_identifier

  tags = merge(
    {
      Name = var.elasticache_cluster_name != "" ? var.elasticache_cluster_name : "${lower(var.name)}-${lower(var.elasticache_cluster_engine != "" ? var.elasticache_cluster_engine : var.default_engine)}-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elasticache_subnet_group.elasticache_subnet_group,
    aws_elasticache_security_group.elasticache_security_group,
    aws_elasticache_parameter_group.elasticache_parameter_group
  ]
}
