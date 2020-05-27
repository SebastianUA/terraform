#---------------------------------------------------
# AWS Glue connection
#---------------------------------------------------
resource "aws_glue_connection" "glue_connection" {
    count                   = var.enable_glue_connection ? 1 : 0

    name                    = var.glue_connection_name != "" ? lower(var.glue_connection_name) : "${lower(var.name)}-glue-connection-${lower(var.environment)}"
    connection_properties   = var.glue_connection_connection_properties

    description             = var.glue_connection_description
    catalog_id              = var.glue_connection_catalog_id
    connection_type         = upper(var.glue_connection_connection_type)
    match_criteria          = var.glue_connection_match_criteria

    dynamic "physical_connection_requirements" {
        iterator = physical_connection_requirements
        for_each = var.glue_connection_physical_connection_requirements
        content {
            availability_zone      = lookup(physical_connection_requirements.value, "availability_zone", null)
            security_group_id_list = lookup(physical_connection_requirements.value, "security_group_id_list", null)
            subnet_id              = lookup(physical_connection_requirements.value, "subnet_id", null)
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = []
}
