#---------------------------------------------------
# AWS RDS cluster endpoint
#---------------------------------------------------
resource "aws_rds_cluster_endpoint" "rds_cluster_endpoint" {
  count = var.enable_rds_cluster_endpoint ? 1 : 0

  cluster_identifier          = var.rds_cluster_endpoint_cluster_identifier != "" ? lower(var.rds_cluster_endpoint_cluster_identifier) : element(concat(aws_rds_cluster.rds_cluster.*.id, [""]), 0)
  cluster_endpoint_identifier = var.rds_cluster_endpoint_cluster_endpoint_identifier
  custom_endpoint_type        = upper(var.rds_cluster_endpoint_custom_endpoint_type)

  excluded_members = var.rds_cluster_endpoint_excluded_members
  static_members   = var.rds_cluster_endpoint_static_members

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_rds_cluster.rds_cluster
  ]
}
