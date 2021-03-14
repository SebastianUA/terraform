#---------------------------------------------------
# AWS dynamodb table item
#---------------------------------------------------
resource "aws_dynamodb_table_item" "dynamodb_table_item" {
  count = var.enable_dynamodb_table_item ? 1 : 0

  table_name = var.dynamodb_table_item_table_name != "" && ! var.enable_dynamodb_table ? var.dynamodb_table_item_table_name : element(concat(aws_dynamodb_table.dynamodb_table.*.name, [""]), 0)
  hash_key   = var.dynamodb_table_item_hash_key != "" && ! var.enable_dynamodb_table ? var.dynamodb_table_item_hash_key : element(concat(aws_dynamodb_table.dynamodb_table.*.hash_key, [""]), 0)
  item       = var.dynamodb_table_item_item

  range_key = var.dynamodb_table_item_range_key

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_dynamodb_table.dynamodb_table
  ]
}
