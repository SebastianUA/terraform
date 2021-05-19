#---------------------------------------------------
# AWS Glue user defined function
#---------------------------------------------------
resource "aws_glue_user_defined_function" "glue_user_defined_function" {
  count = var.enable_glue_user_defined_function ? 1 : 0

  name          = var.glue_user_defined_function_name != "" ? lower(var.glue_user_defined_function_name) : "${lower(var.name)}-glue-user-defined-fun-${lower(var.environment)}"
  database_name = var.glue_user_defined_function_database_name != "" ? var.glue_user_defined_function_database_name : (var.enable_glue_catalog_database ? aws_glue_catalog_database.glue_catalog_database.0.name : null)
  class_name    = var.glue_user_defined_function_class_name
  owner_name    = var.glue_user_defined_function_owner_name
  owner_type    = var.glue_user_defined_function_owner_type

  catalog_id = var.glue_user_defined_function_catalog_id != "" ? var.glue_user_defined_function_catalog_id : (var.enable_glue_catalog_database ? aws_glue_catalog_database.glue_catalog_database.0.catalog_id : null)

  dynamic "resource_uris" {
    iterator = resource_uris
    for_each = var.glue_user_defined_function_resource_uris

    content {
      resource_type = lookup(resource_uris.value, "resource_type", null)
      uri           = lookup(resource_uris.value, "uri", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glue_catalog_database.glue_catalog_database
  ]
}
