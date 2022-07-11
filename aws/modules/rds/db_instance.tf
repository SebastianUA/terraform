#---------------------------------------------------
# AWS RDS instance(s)
#---------------------------------------------------
resource "aws_db_instance" "db_instance" {
  count = var.enable_db_instance ? var.number_of_instances : 0

  identifier          = var.db_instance_identifier != "" && var.db_instance_identifier_prefix == "" ? lower(var.db_instance_identifier) : null
  identifier_prefix   = var.db_instance_identifier_prefix != "" && var.db_instance_identifier == "" ? lower(var.db_instance_identifier_prefix) : null
  iops                = var.db_instance_iops
  engine              = var.db_instance_engine
  engine_version      = var.db_instance_engine_version
  instance_class      = var.db_instance_instance_class
  replicate_source_db = var.db_instance_replicate_source_db

  db_name            = var.db_instance_db_name
  username           = var.db_instance_db_username
  password           = var.db_instance_db_password
  port               = var.db_instance_db_port != null ? var.db_instance_db_port : lookup(var.default_ports, var.db_instance_engine)
  character_set_name = var.db_instance_character_set_name
  timezone           = var.db_instance_timezone

  vpc_security_group_ids = var.db_instance_vpc_security_group_ids
  db_subnet_group_name   = var.db_instance_db_subnet_group_name != "" && !var.enable_db_subnet_group ? lower(var.db_instance_db_subnet_group_name) : element(concat(aws_db_subnet_group.db_subnet_group.*.id, [""]), 0)
  parameter_group_name   = var.db_instance_parameter_group_name != "" && !var.enable_db_parameter_group ? lower(var.db_instance_parameter_group_name) : element(concat(aws_db_parameter_group.db_parameter_group.*.id, [""]), 0)
  option_group_name      = var.db_instance_option_group_name != "" && !var.enable_db_option_group ? lower(var.db_instance_option_group_name) : element(concat(aws_db_option_group.db_option_group.*.id, [""]), 0)

  publicly_accessible = var.db_instance_publicly_accessible
  multi_az            = var.db_instance_multi_az
  availability_zone   = var.db_instance_availability_zone
  ca_cert_identifier  = var.db_instance_ca_cert_identifier

  allocated_storage     = var.db_instance_allocated_storage
  max_allocated_storage = var.db_instance_max_allocated_storage
  storage_type          = var.db_instance_storage_type
  storage_encrypted     = var.db_instance_storage_encrypted
  kms_key_id            = var.db_instance_kms_key_id

  backup_retention_period = var.db_instance_backup_retention_period
  backup_window           = var.db_instance_backup_window

  copy_tags_to_snapshot     = var.db_instance_copy_tags_to_snapshot
  skip_final_snapshot       = var.db_instance_skip_final_snapshot
  snapshot_identifier       = var.db_instance_snapshot_identifier != "" ? var.db_instance_snapshot_identifier : null
  final_snapshot_identifier = var.db_instance_final_snapshot_identifier != "" ? var.db_instance_final_snapshot_identifier : "${lower(var.name)}-db-instance-${lower(var.environment)}-${md5(timestamp())}"

  apply_immediately           = var.db_instance_apply_immediately
  deletion_protection         = var.db_instance_deletion_protection
  allow_major_version_upgrade = var.db_instance_allow_major_version_upgrade
  auto_minor_version_upgrade  = var.db_instance_auto_minor_version_upgrade
  maintenance_window          = var.db_instance_maintenance_window

  domain                              = var.db_instance_domain
  domain_iam_role_name                = var.db_instance_domain_iam_role_name
  iam_database_authentication_enabled = var.db_instance_iam_database_authentication_enabled != null ? var.db_instance_iam_database_authentication_enabled : null
  license_model                       = var.db_instance_license_model

  monitoring_interval             = var.db_instance_monitoring_interval
  monitoring_role_arn             = var.db_instance_monitoring_role_arn
  enabled_cloudwatch_logs_exports = var.db_instance_enabled_cloudwatch_logs_exports

  performance_insights_enabled          = var.db_instance_performance_insights_enabled
  performance_insights_kms_key_id       = var.db_instance_performance_insights_kms_key_id
  performance_insights_retention_period = var.db_instance_performance_insights_retention_period

  dynamic "s3_import" {
    iterator = s3_import
    for_each = var.db_instance_s3_import

    content {
      source_engine         = lookup(s3_import.value, "source_engine", null)
      source_engine_version = lookup(s3_import.value, "source_engine_version", null)
      bucket_name           = lookup(s3_import.value, "bucket_name", null)
      bucket_prefix         = lookup(s3_import.value, "bucket_prefix", null)
      ingestion_role        = lookup(s3_import.value, "ingestion_role", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.db_instance_timeouts)) > 0 ? [var.db_instance_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.db_instance_identifier != "" && var.db_instance_identifier_prefix == "" ? lower(var.db_instance_identifier) : lower(var.db_instance_identifier_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_db_subnet_group.db_subnet_group,
    aws_db_parameter_group.db_parameter_group,
    aws_db_option_group.db_option_group
  ]
}
