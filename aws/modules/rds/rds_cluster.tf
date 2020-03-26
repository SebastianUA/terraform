#---------------------------------------------------
# Create AWS RDS cluster
#---------------------------------------------------
resource "aws_rds_cluster" "rds_cluster" {
    count                               = var.enable_rds_cluster ? 1 : 0

    cluster_identifier                  = var.cluster_identifier != "" ? lower(var.cluster_identifier) : null
    cluster_identifier_prefix           = var.cluster_identifier_prefix != "" ? lower(var.cluster_identifier_prefix) : null
    global_cluster_identifier           = var.global_cluster_identifier != "" ? var.global_cluster_identifier : element(concat(aws_rds_global_cluster.rds_global_cluster.*.id, [""]), 0)
    engine                              = var.engine
    engine_version                      = var.engine_version
    engine_mode                         = var.engine_mode
    source_region                       = var.source_region != "" ? var.source_region : var.region

    db_subnet_group_name                = var.db_subnet_group_name != "" && !var.enable_db_subnet_group ? var.db_subnet_group_name : element(aws_db_subnet_group.db_subnet_group.*.id, 0)
    db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name != "" && !var.enable_rds_cluster_parameter_group ? var.db_cluster_parameter_group_name : element(concat(aws_rds_cluster_parameter_group.rds_cluster_parameter_group.*.id, [""]), 0)
    vpc_security_group_ids              = var.vpc_security_group_ids
    availability_zones                  = split(",", (lookup(var.availability_zones, var.region)))
    port                                = var.rds_cluster_port != null ? var.rds_cluster_port : lookup(var.default_ports, var.engine)

    iam_roles                           = var.iam_roles
    iam_database_authentication_enabled = var.iam_database_authentication_enabled != null ? var.iam_database_authentication_enabled : null

    database_name                       = var.database_name
    master_username                     = var.master_username
    master_password                     = var.master_password

    backtrack_window                    = var.backtrack_window
    backup_retention_period             = var.backup_retention_period
    preferred_backup_window             = var.backup_window

    storage_encrypted                   = var.storage_encrypted
    kms_key_id                          = var.kms_key_id

    apply_immediately                   = var.apply_immediately
    deletion_protection                 = var.deletion_protection
    replication_source_identifier       = var.replication_source_identifier
    enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports

    snapshot_identifier                 = var.snapshot_identifier != "" ? var.snapshot_identifier : null
    final_snapshot_identifier           = var.final_snapshot_identifier != "" ? var.final_snapshot_identifier : "${lower(var.name)}-cluster-${lower(var.environment)}-${md5(timestamp())}"
    copy_tags_to_snapshot               = var.copy_tags_to_snapshot
    skip_final_snapshot                 = var.skip_final_snapshot
    enable_http_endpoint                = var.enable_http_endpoint

    dynamic "scaling_configuration" {
        # for_each = var.engine_mode == "serverless" ? var.scaling_configuration : 0
        # for_each = var.engine_mode == "serverless" ? var.scaling_configuration : null
        for_each = var.scaling_configuration
        content {
            auto_pause                  = lookup(scaling_configuration.value, "auto_pause",  null)
            max_capacity                = lookup(scaling_configuration.value, "max_capacity",  null)
            min_capacity                = lookup(scaling_configuration.value, "min_capacity",  null)
            seconds_until_auto_pause    = lookup(scaling_configuration.value, "seconds_until_auto_pause",  null)
            timeout_action              = lookup(scaling_configuration.value, "timeout_action",  null)
        }
    }

    dynamic "s3_import" {
        #for_each = var.engine_mode == "serverless" ? var.s3_import : 0
        for_each = var.s3_import
        content {
            source_engine         = lookup(scaling_configuration.value, "source_engine",  null)
            source_engine_version = lookup(scaling_configuration.value, "source_engine_version",  null)
            bucket_name           = lookup(scaling_configuration.value, "bucket_name",  null)
            bucket_prefix         = lookup(scaling_configuration.value, "bucket_prefix",  null)
            ingestion_role        = lookup(scaling_configuration.value, "ingestion_role",  null)
        }
    }

    tags                                = merge(
        {
            "Name"  = var.cluster_identifier != "" ? lower(var.cluster_identifier) : "${lower(var.name)}-cluster-${lower(var.environment)}"
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

    depends_on                          = [
        aws_rds_global_cluster.rds_global_cluster,
        aws_db_subnet_group.db_subnet_group,
        aws_rds_cluster_parameter_group.rds_cluster_parameter_group
    ]
}
