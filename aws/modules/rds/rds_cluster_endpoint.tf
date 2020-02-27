#---------------------------------------------------
# Create AWS RDS cluster endpoint
#---------------------------------------------------
resource "aws_rds_cluster_endpoint" "rds_cluster_endpoint" {
    count                           = var.enable_rds_cluster_endpoint ? 1 : 0

    cluster_identifier              = var.cluster_identifier != "" ? lower(var.cluster_identifier) : element(concat(aws_rds_cluster.rds_cluster.*.id, [""]), 0)
    cluster_endpoint_identifier     = var.cluster_endpoint_identifier
    custom_endpoint_type            = upper(var.custom_endpoint_type)

    excluded_members                = var.excluded_members
    static_members                  = var.static_members

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                      = [
        aws_rds_cluster.rds_cluster
    ]
}
