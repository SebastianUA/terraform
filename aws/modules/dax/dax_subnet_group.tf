#---------------------------------------------------
# AWS dax subnet group
#---------------------------------------------------
resource "aws_dax_subnet_group" "dax_subnet_group" {
    count           = var.enable_dax_subnet_group ? 1 : 0

    name            = var.dax_subnet_group_name != "" ? lower(var.dax_subnet_group_name) : "${lower(var.name)}-dax-subnet-group-${lower(var.environment)}"
    subnet_ids      = var.dax_subnet_group_subnet_ids

    description     = var.dax_subnet_group_description

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}
