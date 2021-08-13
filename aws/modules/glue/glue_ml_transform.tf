#---------------------------------------------------
# AWS Glue ml transform
#---------------------------------------------------
resource "aws_glue_ml_transform" "glue_ml_transform" {
  count = var.enable_glue_ml_transform ? 1 : 0

  name     = var.glue_ml_transform_name != "" ? lower(var.glue_ml_transform_name) : "${lower(var.name)}-glue-ml-transform-${lower(var.environment)}"
  role_arn = var.glue_ml_transform_role_arn

  description  = var.glue_ml_transform_description
  glue_version = var.glue_ml_transform_glue_version
  max_capacity = var.glue_ml_transform_max_capacity
  max_retries  = var.glue_ml_transform_max_retries
  timeout      = var.glue_ml_transform_timeout
  worker_type  = var.glue_ml_transform_worker_type

  number_of_workers = var.glue_ml_transform_number_of_workers

  dynamic "input_record_tables" {
    iterator = input_record_tables
    for_each = var.glue_ml_transform_input_record_tables

    content {
      database_name = lookup(input_record_tables.value, "database_name", (var.enable_glue_catalog_table ? element(aws_glue_catalog_table.glue_catalog_table.*.database_name, 0) : null))
      table_name    = lookup(input_record_tables.value, "table_name", (var.enable_glue_catalog_table ? element(aws_glue_catalog_table.glue_catalog_table.*.name, 0) : null))

      catalog_id      = lookup(input_record_tables.value, "catalog_id", null)
      connection_name = lookup(input_record_tables.value, "connection_name", null)
    }
  }

  dynamic "parameters" {
    iterator = parameters
    for_each = var.glue_ml_transform_parameters

    content {
      transform_type = lookup(parameters.value, "transform_type", null)

      dynamic "find_matches_parameters" {
        iterator = find_matches_parameters
        for_each = lookup(parameters.value, "find_matches_parameters", [])

        content {
          primary_key_column_name    = lookup(find_matches_parameters.value, "primary_key_column_name", null)
          accuracy_cost_trade_off    = lookup(find_matches_parameters.value, "accuracy_cost_trade_off", null)
          enforce_provided_labels    = lookup(find_matches_parameters.value, "enforce_provided_labels", null)
          precision_recall_trade_off = lookup(find_matches_parameters.value, "precision_recall_trade_off", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.glue_ml_transform_name != "" ? lower(var.glue_ml_transform_name) : "${lower(var.name)}-glue-ml-transform-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glue_catalog_table.glue_catalog_table
  ]
}


