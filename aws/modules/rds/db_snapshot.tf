#---------------------------------------------------
# AWS DB snapshot
#---------------------------------------------------
resource "aws_db_snapshot" "db_snapshot" {
  count = var.enable_db_snapshot ? 1 : 0

  db_instance_identifier = var.db_snapshot_db_instance_identifier != "" ? var.db_snapshot_db_instance_identifier : element(concat(aws_db_instance.db_instance.*.id, [""]), 0)
  db_snapshot_identifier = var.db_snapshot_db_snapshot_identifier != "" ? lower(var.db_snapshot_db_snapshot_identifier) : "${lower(var.name)}-db-snapshot-${lower(var.environment)}"

  tags = merge(
    {
      Name = var.db_snapshot_db_snapshot_identifier != "" ? lower(var.db_snapshot_db_snapshot_identifier) : "${lower(var.name)}-db-snapshot-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_db_instance.db_instance
  ]
}
