#---------------------------------------------------
# AWS Glue partition
#---------------------------------------------------
resource "aws_glue_partition" "glue_partition" {
  count = var.enable_glue_partition ? 1 : 0

  database_name    = var.glue_partition_database_name != "" ? var.glue_partition_database_name : (var.enable_glue_catalog_database ? aws_glue_catalog_database.glue_catalog_database[0].name : null)
  table_name       = var.glue_partition_table_name != "" ? var.glue_partition_table_name : (var.enable_glue_catalog_table ? aws_glue_catalog_table.glue_catalog_table[0].name : null)
  partition_values = var.glue_partition_partition_values

  catalog_id = var.glue_partition_catalog_id
  parameters = var.glue_partition_parameters

  storage_descriptor {
    location                  = lookup(var.glue_partition_storage_descriptor, "location", null)
    input_format              = lookup(var.glue_partition_storage_descriptor, "input_format", null)
    output_format             = lookup(var.glue_partition_storage_descriptor, "output_format", null)
    compressed                = lookup(var.glue_partition_storage_descriptor, "compressed", null)
    number_of_buckets         = lookup(var.glue_partition_storage_descriptor, "number_of_buckets", null)
    bucket_columns            = lookup(var.glue_partition_storage_descriptor, "bucket_columns", null)
    parameters                = lookup(var.glue_partition_storage_descriptor, "parameters", null)
    stored_as_sub_directories = lookup(var.glue_partition_storage_descriptor, "stored_as_sub_directories", null)

    dynamic "columns" {
      iterator = columns
      for_each = lookup(var.glue_partition_storage_descriptor, "columns", [])

      content {
        name = lookup(columns.value, "name", null)

        type    = lookup(columns.value, "type", null)
        comment = lookup(columns.value, "comment", null)
      }
    }

    dynamic "ser_de_info" {
      iterator = ser_de_info
      for_each = lookup(var.glue_partition_storage_descriptor, "ser_de_info", [])

      content {
        name = lookup(ser_de_info.value, "name", null)

        parameters            = lookup(ser_de_info.value, "parameters", null)
        serialization_library = lookup(ser_de_info.value, "serialization_library", null)
      }
    }

    dynamic "sort_columns" {
      iterator = sort_columns
      for_each = lookup(var.glue_partition_storage_descriptor, "sort_columns", [])

      content {
        column     = lookup(sort_columns.value, "column", null)
        sort_order = lookup(sort_columns.value, "sort_order", null)
      }
    }

    dynamic "skewed_info" {
      iterator = skewed_info
      for_each = lookup(var.glue_partition_storage_descriptor, "skewed_info", [])

      content {
        skewed_column_names               = lookup(skewed_info.value, "skewed_column_names", null)
        skewed_column_value_location_maps = lookup(skewed_info.value, "skewed_column_value_location_maps", null)
        skewed_column_values              = lookup(skewed_info.value, "skewed_column_values", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glue_catalog_database.glue_catalog_database,
    aws_glue_catalog_table.glue_catalog_table
  ]
}
