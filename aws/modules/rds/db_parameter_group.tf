#---------------------------------------------------
# AWS DB parameter group
#---------------------------------------------------
resource "aws_db_parameter_group" "db_parameter_group" {
  count = var.enable_db_parameter_group ? 1 : 0

  name        = var.db_parameter_group_name != "" ? lower(var.db_parameter_group_name) : null
  name_prefix = var.db_parameter_group_name_prefix != "" ? lower(var.db_parameter_group_name_prefix) : null
  description = var.db_parameter_group_description != "" ? lower(var.db_parameter_group_description) : null
  family      = var.db_parameter_group_family != "" ? var.db_parameter_group_family : lookup(var.db_group_family, var.db_instance_engine)

  dynamic "parameter" {
    iterator = parameter
    for_each = var.db_parameter_group_parameters

    content {
      name         = lookup(parameter.value, "name", null)
      value        = lookup(parameter.value, "value", null)
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(
    {
      Name = var.db_parameter_group_name != "" && var.db_parameter_group_name_prefix == "" ? lower(var.db_parameter_group_name) : lower(var.db_parameter_group_name_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []

}
