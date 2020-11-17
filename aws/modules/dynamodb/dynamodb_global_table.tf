#---------------------------------------------------
# AWS dynamodb global table
#---------------------------------------------------
resource "aws_dynamodb_global_table" "dynamodb_global_table" {
  count = var.enable_dynamodb_global_table ? 1 : 0

  name = var.dynamodb_global_table_name != "" ? lower(var.dynamodb_global_table_name) : "${lower(var.name)}-dynamodb-global-table-${lower(var.environment)}"

  dynamic "replica" {
    iterator = replica
    for_each = var.dynamodb_global_table_replica
    content {
      region_name = lookup(replica.value, "region_name", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_dynamodb_table.dynamodb_table
  ]
}
