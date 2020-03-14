#---------------------------------------------------
# Create AWS RDS cluster instance
#---------------------------------------------------
resource "aws_rds_cluster_instance" "rds_cluster_instance" {
    count                           = var.enable_rds_cluster_instance ? var.number_of_instances : 0

    identifier                      = var.rds_cluster_instance_identifier != "" && var.rds_cluster_instance_identifier_prefix == "" ? lower(var.rds_cluster_instance_identifier) : null
    identifier_prefix               = var.rds_cluster_instance_identifier_prefix != "" && var.rds_cluster_instance_identifier == "" ? lower(var.rds_cluster_instance_identifier_prefix) : null
    cluster_identifier              = var.cluster_identifier != "" ? lower(var.cluster_identifier) : element(concat(aws_rds_cluster.rds_cluster.*.id, [""]), 0)
    instance_class                  = var.instance_class

    publicly_accessible             = var.publicly_accessible
    db_subnet_group_name            = var.db_subnet_group_name != "" && !var.enable_db_subnet_group ? lower(var.db_subnet_group_name) : element(concat(aws_db_subnet_group.db_subnet_group.*.id, [""]), 0)
    db_parameter_group_name         = var.db_parameter_group_name != "" ? lower(var.db_parameter_group_name) : element(concat(aws_db_parameter_group.db_parameter_group.*.id, [""]), 0)
    promotion_tier                  = var.promotion_tier
    availability_zone               = var.availability_zone
    ca_cert_identifier              = var.ca_cert_identifier

    monitoring_role_arn             = var.monitoring_role_arn
    monitoring_interval             = var.monitoring_interval

    preferred_backup_window         = var.preferred_backup_window
    preferred_maintenance_window    = var.preferred_maintenance_window
    apply_immediately               = var.apply_immediately
    auto_minor_version_upgrade      = var.auto_minor_version_upgrade

    performance_insights_enabled    = var.performance_insights_enabled
    performance_insights_kms_key_id = var.performance_insights_kms_key_id

    copy_tags_to_snapshot           = var.copy_tags_to_snapshot

    tags                            = merge(
        {
            "Name"          = var.rds_cluster_instance_identifier != "" && var.rds_cluster_instance_identifier_prefix == "" ? lower(var.rds_cluster_instance_identifier): lower(var.rds_cluster_instance_identifier_prefix)
        },
        var.tags
    )

    timeouts {
        create  = var.timeouts_create
        update  = var.timeouts_update
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_rds_cluster.rds_cluster,
        aws_db_subnet_group.db_subnet_group,
        aws_db_parameter_group.db_parameter_group
    ]
}
