#---------------------------------------------------
# Create AWS MQ broker
#---------------------------------------------------
resource "aws_mq_broker" "mq_broker" {
    count                           = var.enable_mq_broker ? 1 : 0
  
    broker_name                     = var.broker_name != "" ? var.broker_name : "${lower(var.name)}-mq-broker-${lower(var.environment)}"
    engine_type                     = var.engine_type
    engine_version                  = var.engine_version
    host_instance_type              = var.host_instance_type
    security_groups                 = var.security_group_ids
    subnet_ids                      = var.subnet_ids
    
    apply_immediately               = var.apply_immediately
    auto_minor_version_upgrade      = var.auto_minor_version_upgrade
    deployment_mode                 = var.deployment_mode
    publicly_accessible             = var.publicly_accessible

    dynamic "configuration" {
        for_each = var.configuration
        content {
            id          = lookup(encryption_options.value, "id", element(concat(aws_mq_configuration.mq_configuration.*.id, [""]), 0))
            revision    = lookup(encryption_options.value, "revision", element(concat(aws_mq_configuration.mq_configuration.*.latest_revision, [""]), 0))
        }
    }

    dynamic "encryption_options" {
        for_each = var.encryption_options
        content {
            kms_key_id          = lookup(encryption_options.value, "kms_key_id", null)
            use_aws_owned_key   = lookup(encryption_options.value, "use_aws_owned_key", null)
        }
    }

    dynamic "maintenance_window_start_time" {
        for_each = var.maintenance_window_start_time
        content {
            day_of_week = lookup(maintenance_window_start_time.value, "day_of_week", null)
            time_of_day = lookup(maintenance_window_start_time.value, "time_of_day", null)
            time_zone   = lookup(maintenance_window_start_time.value, "time_zone", null)
        }
    }

    dynamic "logs" {
        for_each = var.logs
        content {
            general = lookup(logs.value, "general", null)
            audit   = lookup(logs.value, "audit", null)
        }
    }

    dynamic "user" {
        for_each = var.user
        content {
            console_access  = lookup(user.value, "console_access", null)
            groups          = lookup(user.value, "groups", null)
            username        = lookup(user.value, "username", null)
            password        = lookup(user.value, "password", null)
        }
    }

    tags = merge(
        {
            "Name"          = var.broker_name != "" ? var.broker_name : "${lower(var.name)}-mq-broker-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_mq_configuration.mq_configuration
    ]
}