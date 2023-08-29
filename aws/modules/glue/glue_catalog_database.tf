#---------------------------------------------------
# AWS Glue catalog database
#---------------------------------------------------
resource "aws_glue_catalog_database" "glue_catalog_database" {
  count = var.enable_glue_catalog_database ? 1 : 0

  name = var.glue_catalog_database_name != "" ? lower(var.glue_catalog_database_name) : "${lower(var.name)}-glue-catalog-db-${lower(var.environment)}"

  description  = var.glue_catalog_database_description
  catalog_id   = var.glue_catalog_database_catalog_id
  location_uri = var.glue_catalog_database_location_uri
  parameters   = var.glue_catalog_database_parameters

  dynamic "create_table_default_permission" {
    iterator = create_table_default_permission
    for_each = length(keys(var.glue_catalog_database_create_table_default_permission)) > 0 ? [var.glue_catalog_database_create_table_default_permission] : []

    content {
      permissions = lookup(create_table_default_permission.value, "permissions", null)


      dynamic "principal" {
        iterator = principal
        for_each = length(keys(lookup(create_table_default_permission.value, "principal", {}))) > 0 ? [lookup(create_table_default_permission.value, "principal", {})] : []

        content {
          data_lake_principal_identifier = lookup(principal.value, "data_lake_principal_identifier", null)
        }
      }
    }
  }

  dynamic "target_database" {
    iterator = target_database
    for_each = length(keys(var.glue_catalog_database_target_database)) > 0 ? [var.glue_catalog_database_target_database] : []

    content {
      catalog_id    = lookup(target_database.value, "catalog_id", null)
      database_name = lookup(target_database.value, "database_name", null)

      region = lookup(target_database.value, "region", null)
    }
  }

  tags = merge(
    {
      Name = var.glue_catalog_database_name != "" ? lower(var.glue_catalog_database_name) : "${lower(var.name)}-glue-catalog-db-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
