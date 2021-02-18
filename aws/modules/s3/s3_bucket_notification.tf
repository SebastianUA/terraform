#---------------------------------------------------
# Create S3 bucket notification
#---------------------------------------------------
resource "aws_s3_bucket_notification" "s3_bucket_notification" {
  count = var.enable_s3_bucket_notification ? 1 : 0

  bucket = var.s3_bucket_notification_bucket != "" && ! var.enable_s3_bucket ? var.s3_bucket_notification_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  dynamic "topic" {
    for_each = var.s3_bucket_notification_topic
    content {
      id            = lookup(s3_bucket_notification_topic.value, "id", null)
      topic_arn     = lookup(s3_bucket_notification_topic.value, "topic_arn", null)
      events        = lookup(s3_bucket_notification_topic.value, "events", null)
      filter_suffix = lookup(s3_bucket_notification_topic.value, "filter_suffix", null)
      filter_prefix = lookup(s3_bucket_notification_topic.value, "filter_prefix", null)
    }
  }

  dynamic "queue" {
    for_each = var.s3_bucket_notification_queue
    content {
      id            = lookup(s3_bucket_notification_queue.value, "id", null)
      queue_arn     = lookup(s3_bucket_notification_queue.value, "queue_arn", null)
      events        = lookup(s3_bucket_notification_queue.value, "events", null)
      filter_suffix = lookup(s3_bucket_notification_queue.value, "filter_suffix", null)
      filter_prefix = lookup(s3_bucket_notification_queue.value, "filter_prefix", null)
    }
  }

  dynamic "lambda_function" {
    for_each = var.s3_bucket_notification_lambda_function
    content {
      id                  = lookup(s3_bucket_notification_lambda_function.value, "id", null)
      lambda_function_arn = lookup(s3_bucket_notification_lambda_function.value, "lambda_function_arn", null)
      events              = lookup(s3_bucket_notification_lambda_function.value, "events", null)
      filter_suffix       = lookup(s3_bucket_notification_lambda_function.value, "filter_suffix", null)
      filter_prefix       = lookup(s3_bucket_notification_lambda_function.value, "filter_prefix", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification
