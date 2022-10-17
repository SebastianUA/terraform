#---------------------------------------------------
# AWS Glue partition index
#---------------------------------------------------
resource "aws_glue_partition_index" "glue_partition_index" {
  count = var.enable_glue_partition_index ? 1 : 0

  table_name    = var.glue_partition_index_table_name != "" ? var.glue_partition_index_table_name : (var.enable_glue_catalog_table ? aws_glue_catalog_table.glue_catalog_table[count.index].name : null)
  database_name = var.glue_partition_index_database_name != "" ? var.glue_partition_index_database_name : (var.enable_glue_catalog_database ? aws_glue_catalog_database.glue_catalog_database[count.index].name : null)

  catalog_id = var.glue_partition_index_catalog_id

  dynamic "partition_index" {
    iterator = partition_index
    for_each = var.glue_partition_index_partition_index

    content {
      index_name = lookup(partition_index.value, "index_name", null)
      keys       = lookup(partition_index.value, "keys", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.glue_partition_index_timeouts)) > 0 ? [var.glue_partition_index_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glue_catalog_table.glue_catalog_table,
    aws_glue_catalog_database.glue_catalog_database
  ]
}