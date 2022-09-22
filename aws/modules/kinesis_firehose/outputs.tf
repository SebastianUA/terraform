#---------------------------------------------------
# AWS kinesis firehose delivery stream
#---------------------------------------------------
output "kinesis_firehose_delivery_stream_id" {
  description = "The ID specifying the Stream"
  value       = element(concat(aws_kinesis_firehose_delivery_stream.kinesis_firehose_delivery_stream.*.id, [""]), 0)
}

output "kinesis_firehose_delivery_stream_arn" {
  description = "The Amazon Resource Name (ARN) specifying the Stream"
  value       = element(concat(aws_kinesis_firehose_delivery_stream.kinesis_firehose_delivery_stream.*.id, [""]), 0)
}
