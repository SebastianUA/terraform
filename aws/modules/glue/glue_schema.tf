#---------------------------------------------------
# AWS Glue schema
#---------------------------------------------------
resource "aws_glue_schema" "glue_schema" {
  count = var.enable_glue_schema ? 1 : 0

  schema_name       = var.glue_schema_name != "" ? lower(var.glue_schema_name) : "${lower(var.name)}-glue-schema-${lower(var.environment)}"
  registry_arn      = var.glue_schema_registry_arn != "" ? var.glue_schema_registry_arn : (var.enable_glue_registry ? aws_glue_registry.glue_registry.0.arn : null)
  data_format       = var.glue_schema_data_format
  compatibility     = var.glue_schema_compatibility
  schema_definition = var.glue_schema_schema_definition

  description = var.glue_schema_description

  tags = merge(
    {
      Name = var.glue_schema_name != "" ? lower(var.glue_schema_name) : "${lower(var.name)}-glue-schema-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glue_registry.glue_registry
  ]
}
