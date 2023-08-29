#---------------------------------------------------
# AWS Glue catalog table
#---------------------------------------------------
resource "aws_glue_catalog_table" "glue_catalog_table" {
  count = var.enable_glue_catalog_table ? 1 : 0

  name          = var.glue_catalog_table_name != "" ? lower(var.glue_catalog_table_name) : "${lower(var.name)}-glue-catalog-table-${lower(var.environment)}"
  database_name = var.glue_catalog_table_database_name != "" && !var.enable_glue_catalog_database ? var.glue_catalog_table_database_name : element(concat(aws_glue_catalog_database.glue_catalog_database.*.name, [""]), 0)

  description        = var.glue_catalog_table_description
  catalog_id         = var.glue_catalog_table_catalog_id
  owner              = var.glue_catalog_table_owner
  retention          = var.glue_catalog_table_retention
  view_original_text = var.glue_catalog_table_view_original_text
  view_expanded_text = var.glue_catalog_table_view_expanded_text
  table_type         = var.glue_catalog_table_table_type != null ? upper(var.glue_catalog_table_table_type) : var.glue_catalog_table_table_type
  parameters         = var.glue_catalog_table_parameters

  dynamic "partition_index" {
    iterator = partition_index
    for_each = var.glue_catalog_table_partition_index

    content {
      index_name = lookup(partition_keys.value, "index_name", null)
      keys       = lookup(partition_keys.value, "keys", null)
    }
  }

  dynamic "target_table" {
    iterator = partition_index
    for_each = var.glue_catalog_table_target_table

    content {
      catalog_id    = lookup(var.partition_index, "catalog_id", null)
      database_name = lookup(var.partition_index, "database_name", null)
      name          = lookup(var.partition_index, "name", null)
    }
  }

  dynamic "partition_keys" {
    iterator = partition_keys
    for_each = var.glue_catalog_table_partition_keys

    content {
      name = lookup(partition_keys.value, "name", null)

      type    = lookup(partition_keys.value, "type", null)
      comment = lookup(partition_keys.value, "comment", null)
    }
  }

  dynamic "storage_descriptor" {
    iterator = storage_descriptor
    for_each = length(keys(var.glue_catalog_table_storage_descriptor)) > 0 ? [var.glue_catalog_table_storage_descriptor] : []

    content {
      location                  = lookup(storage_descriptor.value, "location", null)
      input_format              = lookup(storage_descriptor.value, "input_format", null)
      output_format             = lookup(storage_descriptor.value, "output_format", null)
      compressed                = lookup(storage_descriptor.value, "compressed", null)
      number_of_buckets         = lookup(storage_descriptor.value, "number_of_buckets", null)
      bucket_columns            = lookup(storage_descriptor.value, "bucket_columns", null)
      parameters                = lookup(storage_descriptor.value, "parameters", null)
      stored_as_sub_directories = lookup(storage_descriptor.value, "stored_as_sub_directories", null)

      dynamic "columns" {
        iterator = columns
        for_each = lookup(storage_descriptor.value, "columns", [])

        content {
          name    = lookup(columns.value, "columns_name", null)
          type    = lookup(columns.value, "columns_type", null)
          comment = lookup(columns.value, "columns_comment", null)
        }
      }

      dynamic "ser_de_info" {
        iterator = ser_de_info
        for_each = lookup(storage_descriptor.value, "ser_de_info", [])

        content {
          name                  = lookup(ser_de_info.value, "ser_de_info_name", null)
          parameters            = lookup(ser_de_info.value, "ser_de_info_parameters", null)
          serialization_library = lookup(ser_de_info.value, "ser_de_info_serialization_library", null)
        }
      }

      dynamic "sort_columns" {
        iterator = sort_columns
        for_each = lookup(storage_descriptor.value, "sort_columns", [])

        content {
          column     = lookup(sort_columns.value, "sort_columns_column", null)
          sort_order = lookup(sort_columns.value, "sort_columns_sort_order", null)
        }
      }

      dynamic "skewed_info" {
        iterator = skewed_info
        for_each = lookup(storage_descriptor.value, "skewed_info", [])

        content {
          skewed_column_names               = lookup(skewed_info.value, "skewed_info_skewed_column_names", null)
          skewed_column_value_location_maps = lookup(skewed_info.value, "skewed_info_skewed_column_value_location_maps", null)
          skewed_column_values              = lookup(skewed_info.value, "skewed_info_skewed_column_values", null)
        }
      }
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