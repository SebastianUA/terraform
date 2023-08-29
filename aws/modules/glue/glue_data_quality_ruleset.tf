#---------------------------------------------------
# AWS Glue data quality ruleset
#---------------------------------------------------
resource "aws_glue_data_quality_ruleset" "glue_data_quality_ruleset" {
  count = var.enable_glue_data_quality_ruleset ? 1 : 0

  name = var.glue_data_quality_ruleset_name != "" ? lower(var.glue_data_quality_ruleset_name) : "${lower(var.name)}-data-quality-ruleset-${lower(var.environment)}"

  description = var.glue_data_quality_ruleset_description
  ruleset     = var.glue_data_quality_ruleset_ruleset

  dynamic "target_table" {
    iterator = target_table
    for_each = length(keys(var.glue_trigger_target_table)) > 0 ? [var.glue_trigger_target_table] : []

    content {
      database_name = lookup(target_table.value, "database_name", null)
      table_name    = lookup(target_table.value, "table_name", null)

      catalog_id = lookup(target_table.value, "catalog_id", null)
    }
  }

  tags = merge(
    {
      Name = var.glue_data_quality_ruleset_name != "" ? lower(var.glue_data_quality_ruleset_name) : "${lower(var.name)}-data-quality-ruleset-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
