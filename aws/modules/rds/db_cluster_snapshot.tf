#---------------------------------------------------
# Create AWS DB cluster snapshot
#---------------------------------------------------
resource "aws_db_cluster_snapshot" "db_cluster_snapshot" {
    count                           = var.enable_db_cluster_snapshot ? 1 : 0

    db_cluster_identifier           = var.db_cluster_identifier != "" ? lower(var.db_cluster_identifier) : element(concat(aws_rds_cluster.rds_cluster.*.id, [""]), 0)
    db_cluster_snapshot_identifier  = var.db_cluster_snapshot_identifier != "" ? lower(var.db_cluster_snapshot_identifier) : "${lower(var.name)}-db-cluster-snapshot-${lower(var.environment)}"

    tags                            = merge(
        {
            "Name"  = var.db_cluster_snapshot_identifier != "" ? lower(var.db_cluster_snapshot_identifier) : "${lower(var.name)}-db-cluster-snapshot-${lower(var.environment)}"
        },
        var.tags
    )

    timeouts {
        create  = var.timeouts_create
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                      = [
        aws_rds_cluster.rds_cluster
    ]
}
