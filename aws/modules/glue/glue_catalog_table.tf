#---------------------------------------------------
# AWS Glue catalog table
#---------------------------------------------------
resource "aws_glue_catalog_table" "glue_catalog_table" {
    count               = var.enable_glue_catalog_table ? 1 : 0

    name                = var.glue_catalog_table_name != "" ? lower(var.glue_catalog_table_name) : "${lower(var.name)}-glue-catalog-table-${lower(var.environment)}"
    database_name       = var.glue_catalog_table_database_name != "" && !var.enable_glue_catalog_database ? var.glue_catalog_table_database_name : element(concat(aws_glue_catalog_database.glue_catalog_database.*.name, [""]), 0)

    description         = var.glue_catalog_table_description
    catalog_id          = var.glue_catalog_table_catalog_id
    owner               = var.glue_catalog_table_owner
    retention           = var.glue_catalog_table_retention
    view_original_text  = var.glue_catalog_table_view_original_text
    view_expanded_text  = var.glue_catalog_table_view_expanded_text
    table_type          = var.glue_catalog_table_table_type != null ? upper(var.glue_catalog_table_table_type) : var.glue_catalog_table_table_type
    parameters          = var.glue_catalog_table_parameters

    dynamic "partition_keys" {
        iterator = partition_keys
        for_each = var.glue_catalog_table_partition_keys
        content {
            name    = lookup(partition_keys.value, "name", null)
        }
    }

    storage_descriptor {
        location                        = var.storage_descriptor_location
        input_format                    = var.storage_descriptor_input_format
        output_format                   = var.storage_descriptor_output_format
        compressed                      = var.storage_descriptor_compressed
        number_of_buckets               = var.storage_descriptor_number_of_buckets
        bucket_columns                  = var.storage_descriptor_bucket_columns
        parameters                      = var.storage_descriptor_parameters
        stored_as_sub_directories       = var.storage_descriptor_stored_as_sub_directories

        dynamic "columns" {
            iterator = columns
            for_each = var.storage_descriptor_columns
            content {
                name     = lookup(columns.value, "columns_name", null)
                type     = lookup(columns.value, "columns_type", null)
                comment  = lookup(columns.value, "columns_comment", null)
            }
        }

        dynamic "ser_de_info" {
            iterator = ser_de_info
            for_each = var.storage_descriptor_ser_de_info
            content {
                name                    = lookup(ser_de_info.value, "ser_de_info_name", null)
                parameters              = lookup(ser_de_info.value, "ser_de_info_parameters", null)
                serialization_library   = lookup(ser_de_info.value, "ser_de_info_serialization_library", null)
            }
        }

        dynamic "sort_columns" {
            iterator = sort_columns
            for_each = var.storage_descriptor_sort_columns
            content {
                column      = lookup(sort_columns.value, "sort_columns_column", null)
                sort_order  = lookup(sort_columns.value, "sort_columns_sort_order", null)
            }
        }

        dynamic "skewed_info" {
            iterator = skewed_info
            for_each = var.storage_descriptor_skewed_info
            content {
                skewed_column_names                 = lookup(skewed_info.value, "skewed_info_skewed_column_names", null)
                skewed_column_value_location_maps   = lookup(skewed_info.value, "skewed_info_skewed_column_value_location_maps", null)
                skewed_column_values                = lookup(skewed_info.value, "skewed_info_skewed_column_values", null)
            }
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_glue_catalog_database.glue_catalog_database
    ]
}
