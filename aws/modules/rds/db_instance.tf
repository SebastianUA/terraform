#---------------------------------------------------
# Create AWS RDS instance(s)
#---------------------------------------------------
resource "aws_db_instance" "db_instance" {
    count                                   = var.enable_db_instance ? var.number_of_instances : 0

    identifier                              = var.db_instance_identifier != "" && var.db_instance_identifier_prefix == "" ? lower(var.db_instance_identifier) : null
    identifier_prefix                       = var.db_instance_identifier_prefix != "" && var.db_instance_identifier == "" ? lower(var.db_instance_identifier_prefix) : null
    iops                                    = var.db_instance_iops
    engine                                  = var.engine
    engine_version                          = var.engine_version
    instance_class                          = var.instance_class
    replicate_source_db                     = var.db_instance_replicate_source_db

    name                                    = var.db_instance_db_name
    username                                = var.db_instance_db_username
    password                                = var.db_instance_db_password
    port                                    = var.db_instance_db_port != null ? var.db_instance_db_port : lookup(var.default_ports, var.engine)
    character_set_name                      = var.db_instance_character_set_name
    timezone                                = var.db_instance_timezone

    vpc_security_group_ids                  = var.vpc_security_group_ids
    db_subnet_group_name                    = var.db_subnet_group_name != "" && !var.enable_db_subnet_group ? lower(var.db_subnet_group_name) : element(concat(aws_db_subnet_group.db_subnet_group.*.id, [""]), 0)
    parameter_group_name                    = var.db_parameter_group_name != "" && !var.enable_db_parameter_group ? lower(var.db_parameter_group_name) : element(concat(aws_db_parameter_group.db_parameter_group.*.id, [""]), 0)
    option_group_name                       = var.db_instance_option_group_name != "" && !var.enable_db_option_group ? lower(var.db_instance_option_group_name) : element(concat(aws_db_option_group.db_option_group.*.id, [""]), 0)

    publicly_accessible                     = var.publicly_accessible
    multi_az                                = var.db_instance_multi_az
    availability_zone                       = var.availability_zone
    ca_cert_identifier                      = var.ca_cert_identifier

    allocated_storage                       = var.db_instance_allocated_storage
    max_allocated_storage                   = var.db_instance_max_allocated_storage
    storage_type                            = var.db_instance_storage_type
    storage_encrypted                       = var.storage_encrypted
    kms_key_id                              = var.kms_key_id

    backup_retention_period                 = var.backup_retention_period
    backup_window                           = var.backup_window

    copy_tags_to_snapshot                   = var.copy_tags_to_snapshot
    skip_final_snapshot                     = var.skip_final_snapshot
    snapshot_identifier                     = var.snapshot_identifier != "" ? var.snapshot_identifier : null
    final_snapshot_identifier               = var.final_snapshot_identifier != "" ? var.final_snapshot_identifier : "${lower(var.name)}-db-instance-${lower(var.environment)}-${md5(timestamp())}"

    apply_immediately                       = var.apply_immediately
    deletion_protection                     = var.deletion_protection
    allow_major_version_upgrade             = var.db_instance_allow_major_version_upgrade
    auto_minor_version_upgrade              = var.auto_minor_version_upgrade
    maintenance_window                      = var.db_instance_maintenance_window

    domain                                  = var.db_instance_domain
    domain_iam_role_name                    = var.db_instance_domain_iam_role_name
    iam_database_authentication_enabled     = var.iam_database_authentication_enabled != null ? var.iam_database_authentication_enabled : null
    license_model                           = var.db_instance_license_model

    monitoring_interval                     = var.monitoring_interval
    monitoring_role_arn                     = var.monitoring_role_arn
    enabled_cloudwatch_logs_exports         = var.enabled_cloudwatch_logs_exports

    performance_insights_enabled            = var.performance_insights_enabled
    performance_insights_kms_key_id         = var.performance_insights_kms_key_id
    performance_insights_retention_period   = var.db_instance_performance_insights_retention_period

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

    tags                                    = merge(
        {
            "Name"          = var.db_instance_identifier != "" && var.db_instance_identifier_prefix == "" ? lower(var.db_instance_identifier) : lower(var.db_instance_identifier_prefix)
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

    depends_on                              = [
        aws_db_subnet_group.db_subnet_group,
        aws_db_parameter_group.db_parameter_group,
        aws_db_option_group.db_option_group
    ]
}
