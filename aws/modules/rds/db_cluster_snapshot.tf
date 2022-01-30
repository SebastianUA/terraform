#---------------------------------------------------
# AWS DB cluster snapshot
#---------------------------------------------------
resource "aws_db_cluster_snapshot" "db_cluster_snapshot" {
  count = var.enable_db_cluster_snapshot ? 1 : 0

  db_cluster_identifier          = var.db_cluster_snapshot_db_cluster_identifier != "" ? lower(var.db_cluster_snapshot_db_cluster_identifier) : element(concat(aws_rds_cluster.rds_cluster.*.id, [""]), 0)
  db_cluster_snapshot_identifier = var.db_cluster_snapshot_identifier != "" ? lower(var.db_cluster_snapshot_identifier) : "${lower(var.name)}-db-cluster-snapshot-${lower(var.environment)}"

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.db_cluster_snapshot_timeouts)) > 0 ? [var.db_cluster_snapshot_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
    }
  }

  tags = merge(
    {
      Name = var.db_cluster_snapshot_identifier != "" ? lower(var.db_cluster_snapshot_identifier) : "${lower(var.name)}-db-cluster-snapshot-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_rds_cluster.rds_cluster
  ]
}
