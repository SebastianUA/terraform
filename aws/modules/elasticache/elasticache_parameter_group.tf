#---------------------------------------------------
# Create AWS elasticache parameter group
#---------------------------------------------------
resource "aws_elasticache_parameter_group" "elasticache_parameter_group" {
    count       = length(var.parameters_for_parameter_group) !=0 && var.create_custom_elasticache_parameter_group ? 1 : 0
                            
    name        = "${lower(var.name)}-${var.engine}-parameter-group-${lower(var.environment)}"
    description = "Elasticache parameter group which managed by ${var.orchestration}"
    family      = "${var.elasticache_parameter_group_family[var.engine]}"

    parameter = var.parameters_for_parameter_group

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
    
    depends_on = []
}