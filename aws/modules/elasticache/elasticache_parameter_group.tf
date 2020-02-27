#---------------------------------------------------
# Create AWS elasticache parameter group
#---------------------------------------------------
resource "aws_elasticache_parameter_group" "elasticache_parameter_group" {
    count           = var.enable_elasticache_parameter_group ? 1 : 0

    name            = var.elasticache_parameter_group_name != "" ? var.elasticache_parameter_group_name : "${lower(var.name)}-${var.engine}-parameter-group-${lower(var.environment)}"
    description     = var.elasticache_parameter_group_description != "" ? var.elasticache_parameter_group_description : "Elasticache parameter group which managed by ${var.orchestration}"
    family          = var.elasticache_parameter_group_family[var.engine]

    dynamic "parameter" {
        for_each = var.parameter
        content {
            name     = lookup(parameter.value, "name", null)
            value    = lookup(parameter.value, "value", null)
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = []
}
