#---------------------------------------------------
# AWS elasticache parameter group
#---------------------------------------------------
resource "aws_elasticache_parameter_group" "elasticache_parameter_group" {
  count = var.enable_elasticache_parameter_group ? 1 : 0

  name        = var.elasticache_parameter_group_name != "" ? var.elasticache_parameter_group_name : "${lower(var.name)}-${var.elasticache_replication_group_engine != "" ? var.elasticache_replication_group_engine : var.default_engine}-parameter-group-${lower(var.environment)}"
  description = var.elasticache_parameter_group_description != "" ? var.elasticache_parameter_group_description : "Elasticache parameter group which managed by me"
  family      = var.elasticache_parameter_group_family != "" ? var.elasticache_parameter_group_family : var.default_parameter_group_family[var.default_engine]

  dynamic "parameter" {
    iterator = parameter
    for_each = var.elasticache_parameter_group_parameter

    content {
      name  = lookup(parameter.value, "name", null)
      value = lookup(parameter.value, "value", null)
    }
  }

  tags = merge(
    {
      Name = var.elasticache_parameter_group_name != "" ? var.elasticache_parameter_group_name : "${lower(var.name)}-${var.elasticache_replication_group_engine != "" ? var.elasticache_replication_group_engine : var.default_engine}-parameter-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
