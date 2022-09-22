#---------------------------------------------------
# AWS kinesis stream consumer
#---------------------------------------------------
resource "aws_kinesis_stream_consumer" "kinesis_stream_consumer" {
  count = var.enable_kinesis_stream_consumer ? 1 : 0

  name       = var.kinesis_stream_consumer_name != "" ? var.kinesis_stream_consumer_name : "${lower(var.name)}-kinesis-stream-consumer-${lower(var.environment)}-${count.index + 1}"
  stream_arn = var.kinesis_stream_consumer_stream_arn != "" ? var.kinesis_stream_consumer_stream_arn : (var.enable_kinesis_stream ? aws_kinesis_stream.kinesis_stream[0].arn : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_kinesis_stream.kinesis_stream
  ]
}