#---------------------------------------------------
# AWS DB option group
#---------------------------------------------------
resource "aws_db_option_group" "db_option_group" {
  count = var.enable_db_option_group ? 1 : 0

  name                     = var.db_option_group_name != "" && var.db_option_group_name_prefix == "" ? lower(var.db_option_group_name) : null
  name_prefix              = var.db_option_group_name_prefix != "" && var.db_option_group_name == "" ? lower(var.db_option_group_name_prefix) : null
  option_group_description = var.db_option_group_option_group_description

  engine_name          = var.db_option_group_engine_name
  major_engine_version = var.db_option_group_major_engine_version

  dynamic "option" {
    iterator = option
    for_each = var.db_option_group_options

    content {
      option_name = lookup(timeouts.value, "option_name", null)

      port                           = lookup(timeouts.value, "port", null)
      version                        = lookup(timeouts.value, "version", null)
      db_security_group_memberships  = lookup(timeouts.value, "db_security_group_memberships", null)
      vpc_security_group_memberships = lookup(timeouts.value, "vpc_security_group_memberships", null)

      dynamic "option_settings" {
        iterator = option_settings
        for_each = length(keys(lookup(option.value, "option_settings", {}))) > 0 ? [lookup(option.value, "option_settings", {})] : []

        content {
          name  = lookup(option_settings.value, "name", null)
          value = lookup(option_settings.value, "value", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.db_option_group_timeouts)) > 0 ? [var.db_option_group_timeouts] : []

    content {
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
