#---------------------------------------------------
# AWS elasticache replication group
#---------------------------------------------------
resource "aws_elasticache_replication_group" "elasticache_replication_group" {
  count = var.elasticache_replication_group ? var.elasticache_replication_group_number_cluster_replicas : 0

  description          = var.elasticache_replication_group_description != "" ? var.elasticache_replication_group_description : "The ${var.elasticache_replication_group_engine != "" ? var.elasticache_replication_group_engine : var.default_engine} master with 2 replica shards which managed by me"
  replication_group_id = var.elasticache_replication_group_replication_group_id != "" ? var.elasticache_replication_group_replication_group_id : "${lower(var.name)}-${lower(var.elasticache_replication_group_engine != "" ? var.elasticache_replication_group_engine : var.default_engine)}-${lower(var.environment)}"

  num_cache_clusters = var.elasticache_replication_group_num_cache_clusters
  node_type          = var.elasticache_replication_group_node_type
  port               = var.elasticache_replication_group_port != null ? var.elasticache_replication_group_port : var.default_ports[var.default_engine]
  engine             = var.elasticache_replication_group_engine != "" ? var.elasticache_replication_group_engine : var.default_engine
  engine_version     = var.elasticache_replication_group_engine_version != null ? var.elasticache_replication_group_engine_version : var.default_engine_version[var.default_engine]

  automatic_failover_enabled = var.elasticache_replication_group_automatic_failover_enabled
  availability_zones         = var.elasticache_replication_group_availability_zones
  subnet_group_name          = var.elasticache_replication_group_subnet_group_name
  security_group_names       = var.elasticache_replication_group_security_group_names
  security_group_ids         = var.elasticache_replication_group_security_group_ids
  parameter_group_name       = var.elasticache_replication_group_parameter_group_name != null ? var.elasticache_cluster_parameter_group_name : (var.enable_elasticache_parameter_group ? element(concat(aws_elasticache_parameter_group.elasticache_parameter_group.*.name, [""]), 0) : null)
  at_rest_encryption_enabled = var.elasticache_replication_group_at_rest_encryption_enabled
  kms_key_id                 = var.elasticache_replication_group_kms_key_id
  transit_encryption_enabled = var.elasticache_replication_group_transit_encryption_enabled
  auth_token                 = var.elasticache_replication_group_auth_token

  auto_minor_version_upgrade = var.elasticache_replication_group_auto_minor_version_upgrade
  maintenance_window         = var.elasticache_replication_group_maintenance_window
  snapshot_window            = var.elasticache_replication_group_snapshot_window
  snapshot_retention_limit   = var.elasticache_replication_group_snapshot_retention_limit
  apply_immediately          = var.elasticache_replication_group_apply_immediately

  snapshot_arns          = var.elasticache_replication_group_snapshot_arns
  snapshot_name          = var.elasticache_replication_group_snapshot_name
  notification_topic_arn = var.elasticache_replication_group_notification_topic_arn

  replicas_per_node_group = var.elasticache_replication_group_replicas_per_node_group
  num_node_groups         = var.elasticache_replication_group_num_node_groups

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.elasticache_replication_group_timeouts)) > 0 ? [var.elasticache_replication_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.elasticache_replication_group_replication_group_id != "" ? var.elasticache_replication_group_replication_group_id : "${lower(var.name)}-${lower(var.elasticache_replication_group_engine != "" ? var.elasticache_replication_group_engine : var.default_engine)}-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elasticache_parameter_group.elasticache_parameter_group
  ]
}
