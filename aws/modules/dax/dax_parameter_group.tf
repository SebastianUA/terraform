#---------------------------------------------------
# AWS dax parameter group
#---------------------------------------------------
resource "aws_dax_parameter_group" "dax_parameter_group" {
    count           = var.enable_dax_parameter_group ? 1 : 0

    name            = var.dax_parameter_group_name != "" ? lower(var.dax_parameter_group_name) : "${lower(var.name)}-dax-param-group-${lower(var.environment)}"

    description     = var.dax_parameter_group_description

    dynamic "parameters" {
        iterator = parameters
        for_each = var.dax_parameter_group_parameters
        content {
            name  = lookup(parameters.value, "name", null)
            value = lookup(parameters.value, "value", null)
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}
