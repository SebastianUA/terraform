#---------------------------------------------------
# AWS kinesis stream
#---------------------------------------------------
resource "aws_kinesis_stream" "kinesis_stream" {
  count = var.enable_kinesis_stream ? 1 : 0

  name = var.kinesis_stream_name != "" ? var.kinesis_stream_name : "${lower(var.name)}-kinesis-stream-${lower(var.environment)}"

  shard_count               = var.kinesis_stream_shard_count
  retention_period          = var.kinesis_stream_retention_period
  shard_level_metrics       = var.kinesis_stream_shard_level_metrics
  enforce_consumer_deletion = var.kinesis_stream_enforce_consumer_deletion
  encryption_type           = var.kinesis_stream_encryption_type
  kms_key_id                = var.kinesis_stream_kms_key_id

  dynamic "stream_mode_details" {
    iterator = stream_mode_details
    for_each = [var.kinesis_stream_stream_mode_details]

    content {
      stream_mode = lookup(stream_mode_details.value, "stream_mode", {})
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = [var.kinesis_stream_timeouts]

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.kinesis_stream_name != "" ? var.kinesis_stream_name : "${lower(var.name)}-kinesis-stream-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}