#---------------------------------------------------
# AWS elasticache global replication group
#---------------------------------------------------
resource "aws_elasticache_global_replication_group" "elasticache_global_replication_group" {
  count = var.elasticache_global_replication_group ? 1 : 0

  global_replication_group_id_suffix = var.elasticache_global_replication_group_global_replication_group_id_suffix
  primary_replication_group_id       = var.elasticache_global_replication_group_primary_replication_group_id != null ? var.elasticache_global_replication_group_primary_replication_group_id : (var.elasticache_replication_group ? aws_elasticache_replication_group.elasticache_replication_group[count.index].id : null)

  global_replication_group_description = var.elasticache_global_replication_group_global_replication_group_description

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elasticache_replication_group.elasticache_replication_group
  ]
}