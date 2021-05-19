#---------------------------------------------------
# AWS config delivery channel
#---------------------------------------------------
resource "aws_config_delivery_channel" "config_delivery_channel" {
  count = var.enable_config_delivery_channel ? 1 : 0

  name           = var.config_delivery_channel_name != "" ? lower(var.config_delivery_channel_name) : "${lower(var.name)}-config-delivery-channel-${lower(var.environment)}"
  s3_bucket_name = var.config_delivery_channel_s3_bucket_name

  s3_key_prefix = var.config_delivery_channel_s3_key_prefix != null ? var.config_delivery_channel_s3_key_prefix : null
  sns_topic_arn = var.config_delivery_channel_sns_topic_arn != null ? var.config_delivery_channel_sns_topic_arn : null

  dynamic "snapshot_delivery_properties" {
    iterator = snapshot_delivery_properties
    for_each = var.config_delivery_channel_snapshot_delivery_properties

    content {
      delivery_frequency = lookup(snapshot_delivery_properties.value, "delivery_frequency", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
