#---------------------------------------------------
# AWS dynamodb table
#---------------------------------------------------
output "dynamodb_table_id" {
  description = "The name of the table"
  value       = element(concat(aws_dynamodb_table.dynamodb_table.*.id, [""]), 0)
}

output "dynamodb_table_arn" {
  description = "The arn of the table"
  value       = element(concat(aws_dynamodb_table.dynamodb_table.*.arn, [""]), 0)
}

output "dynamodb_table_stream_arn" {
  description = "The ARN of the Table Stream. Only available when stream_enabled = true"
  value       = element(concat(aws_dynamodb_table.dynamodb_table.*.stream_arn, [""]), 0)
}

output "dynamodb_table_stream_label" {
  description = "A timestamp, in ISO 8601 format, for this stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when stream_enabled = true"
  value       = element(concat(aws_dynamodb_table.dynamodb_table.*.stream_label, [""]), 0)
}

#---------------------------------------------------
# AWS dynamodb table item
#---------------------------------------------------
output "aws_dynamodb_table_item_id" {
  description = "The ID of the table item"
  value       = element(concat(aws_dynamodb_table_item.dynamodb_table_item.*.id, [""]), 0)
}

output "aws_dynamodb_table_item_table_name" {
  description = "The name of the table to contain the item."
  value       = element(concat(aws_dynamodb_table_item.dynamodb_table_item.*.table_name, [""]), 0)
}

output "aws_dynamodb_table_item_hash_key" {
  description = "Hash key to use for lookups and identification of the item"
  value       = element(concat(aws_dynamodb_table_item.dynamodb_table_item.*.hash_key, [""]), 0)
}

output "aws_dynamodb_table_item_range_key" {
  description = "Range key to use for lookups and identification of the item. Required if there is range key defined in the table."
  value       = element(concat(aws_dynamodb_table_item.dynamodb_table_item.*.range_key, [""]), 0)
}

output "aws_dynamodb_table_item_item" {
  description = "JSON representation of a map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required; you can optionally provide other attribute name-value pairs for the item."
  value       = element(concat(aws_dynamodb_table_item.dynamodb_table_item.*.item, [""]), 0)
}

#---------------------------------------------------
# AWS dynamodb global table
#---------------------------------------------------
output "dynamodb_global_table_id" {
  description = "The name of the DynamoDB Global Table"
  value       = element(concat(aws_dynamodb_global_table.dynamodb_global_table.*.id, [""]), 0)
}

output "dynamodb_global_table_arn" {
  description = "The ARN of the DynamoDB Global Table"
  value       = element(concat(aws_dynamodb_global_table.dynamodb_global_table.*.arn, [""]), 0)
}
