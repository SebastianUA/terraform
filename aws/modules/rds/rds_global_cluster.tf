#---------------------------------------------------
# Create AWS RDS global cluster
#---------------------------------------------------
resource "aws_rds_global_cluster" "rds_global_cluster" {
    count                       = var.enable_rds_global_cluster ? 1 : 0

    global_cluster_identifier   = var.global_cluster_identifier != "" ? var.global_cluster_identifier : "${lower(var.name)}-global-cluster-${lower(var.environment)}"
    database_name               = var.database_name
    deletion_protection         = var.deletion_protection
    engine                      = var.engine
    engine_version              = var.engine_version
    storage_encrypted           = var.storage_encrypted

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = []
}
