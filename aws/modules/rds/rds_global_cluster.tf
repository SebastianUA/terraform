#---------------------------------------------------
# AWS RDS global cluster
#---------------------------------------------------
resource "aws_rds_global_cluster" "rds_global_cluster" {
  count = var.enable_rds_global_cluster ? 1 : 0

  global_cluster_identifier = var.rds_global_cluster_global_cluster_identifier != "" ? var.rds_global_cluster_global_cluster_identifier : "${lower(var.name)}-global-cluster-${lower(var.environment)}"

  database_name       = var.rds_global_cluster_database_name
  deletion_protection = var.rds_global_cluster_deletion_protection
  engine              = var.rds_global_cluster_engine
  engine_version      = var.rds_global_cluster_engine_version
  storage_encrypted   = var.rds_global_cluster_storage_encrypted

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
