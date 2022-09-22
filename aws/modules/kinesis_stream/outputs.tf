#---------------------------------------------------
# AWS kinesis stream
#---------------------------------------------------
output "kinesis_stream_id" {
  description = "The unique Stream id"
  value       = element(concat(aws_kinesis_stream.kinesis_stream.*.id, [""]), 0)
}

output "kinesis_stream_name" {
  description = "The unique Stream name"
  value       = element(concat(aws_kinesis_stream.kinesis_stream.*.name, [""]), 0)
}

output "kinesis_stream_shard_count" {
  description = "The count of Shards for this Stream"
  value       = element(concat(aws_kinesis_stream.kinesis_stream.*.shard_count, [""]), 0)
}

output "kinesis_stream_arn" {
  description = "The Amazon Resource Name (ARN) specifying the Stream (same as id)"
  value       = element(concat(aws_kinesis_stream.kinesis_stream.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS kinesis stream consumer
#---------------------------------------------------
output "kinesis_stream_consumer_id" {
  description = "Amazon Resource Name (ARN) of the stream consumer."
  value       = element(concat(aws_kinesis_stream_consumer.kinesis_stream_consumer.*.id, [""]), 0)
}

output "kinesis_stream_consumer_arn" {
  description = "Amazon Resource Name (ARN) of the stream consumer."
  value       = element(concat(aws_kinesis_stream_consumer.kinesis_stream_consumer.*.arn, [""]), 0)
}

output "kinesis_stream_consumer_creation_timestamp" {
  description = "Approximate timestamp in RFC3339 format of when the stream consumer was created."
  value       = element(concat(aws_kinesis_stream_consumer.kinesis_stream_consumer.*.creation_timestamp, [""]), 0)
}