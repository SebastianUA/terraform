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

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
