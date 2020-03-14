#---------------------------------------------------
# Create AWS DB option group
#---------------------------------------------------
resource "aws_db_option_group" "db_option_group" {
    count                       = var.enable_db_option_group ? 1 : 0

    name                        = var.db_option_group_name != "" && var.db_option_group_name_prefix == "" ? lower(var.db_option_group_name) : null
    name_prefix                 = var.db_option_group_name_prefix != "" && var.db_option_group_name == "" ? lower(var.db_option_group_name_prefix) : null
    option_group_description    = var.option_group_description

    engine_name                 = var.db_option_group_engine_name != "" ? lower(var.db_option_group_engine_name) : "${lower(var.name)}-db-option-group-${lower(var.environment)}"
    major_engine_version        = var.db_option_group_major_engine_version

    option {
        option_name = "Timezone"

        option_settings {
            name  = "TIME_ZONE"
            value = "UTC"
        }
    }

    option {
        option_name = "SQLSERVER_BACKUP_RESTORE"

        option_settings {
            name  = "IAM_ROLE_ARN"
            value = "IAM_ROLE_ARN_HERE"
        }
    }

    option {
        option_name = "TDE"
    }

    timeouts {
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = []
}
