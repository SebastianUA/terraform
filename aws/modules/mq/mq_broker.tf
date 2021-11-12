#---------------------------------------------------
# AWS MQ broker
#---------------------------------------------------
resource "aws_mq_broker" "mq_broker" {
  count = var.enable_mq_broker ? 1 : 0

  broker_name        = var.broker_name != "" ? var.broker_name : "${lower(var.name)}-mq-broker-${lower(var.environment)}"
  engine_type        = var.mq_broker_engine_type
  engine_version     = var.mq_broker_engine_version != "" ? var.mq_broker_engine_version : lookup(var.mq_brokers, var.mq_broker_engine_type)
  host_instance_type = var.mq_broker_host_instance_type
  security_groups    = var.mq_broker_security_group_ids
  subnet_ids         = var.mq_broker_subnet_ids

  apply_immediately          = var.mq_broker_apply_immediately
  auto_minor_version_upgrade = var.mq_broker_auto_minor_version_upgrade
  deployment_mode            = var.mq_broker_deployment_mode
  publicly_accessible        = var.mq_broker_publicly_accessible

  dynamic "configuration" {
    iterator = configuration
    for_each = var.enable_mq_configuration ? [1] : []

    content {
      id       = element(concat(aws_mq_configuration.mq_configuration.*.id, [""]), 0)
      revision = element(concat(aws_mq_configuration.mq_configuration.*.latest_revision, [""]), 0)
    }
  }

  dynamic "configuration" {
    iterator = configuration
    for_each = !var.enable_mq_configuration && length(keys(var.mq_broker_configuration)) > 0 ? [var.mq_broker_configuration] : []

    content {
      id       = lookup(configuration.value, "id", null)
      revision = lookup(configuration.value, "revision", null)
    }
  }

  dynamic "encryption_options" {
    iterator = encryption_options
    for_each = length(keys(var.mq_broker_encryption_options)) > 0 ? [var.mq_broker_encryption_options] : []

    content {
      kms_key_id        = lookup(encryption_options.value, "kms_key_id", null)
      use_aws_owned_key = lookup(encryption_options.value, "use_aws_owned_key", null)
    }
  }

  dynamic "maintenance_window_start_time" {
    iterator = maintenance_window_start_time
    for_each = length(keys(var.mq_broker_maintenance_window_start_time)) > 0 ? [var.mq_broker_maintenance_window_start_time] : []

    content {
      day_of_week = lookup(maintenance_window_start_time.value, "day_of_week", null)
      time_of_day = lookup(maintenance_window_start_time.value, "time_of_day", null)
      time_zone   = lookup(maintenance_window_start_time.value, "time_zone", null)
    }
  }

  dynamic "logs" {
    iterator = logs
    for_each = length(keys(var.mq_broker_logs)) > 0 ? [var.mq_broker_logs] : []

    content {
      general = lookup(logs.value, "general", null)
      audit   = lookup(logs.value, "audit", null)
    }
  }

  dynamic "user" {
    iterator = user
    for_each = var.mq_broker_users

    content {
      console_access = lookup(user.value, "console_access", null)
      groups         = lookup(user.value, "groups", null)
      username       = lookup(user.value, "username", null)
      password       = lookup(user.value, "password", null)
    }
  }

  tags = merge(
    {
      Name = var.broker_name != "" ? var.broker_name : "${lower(var.name)}-mq-broker-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_mq_configuration.mq_configuration
  ]
}
