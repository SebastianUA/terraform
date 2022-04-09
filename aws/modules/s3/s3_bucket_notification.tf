#---------------------------------------------------
# S3 bucket notification
#---------------------------------------------------
resource "aws_s3_bucket_notification" "s3_bucket_notification" {
  count = var.enable_s3_bucket_notification ? 1 : 0

  bucket = var.s3_bucket_notification_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_notification_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  eventbridge = var.s3_bucket_notification_eventbridge

  dynamic "topic" {
    iterator = topic
    for_each = var.s3_bucket_notification_topic

    content {
      topic_arn = lookup(topic.value, "topic_arn", null)
      events    = lookup(topic.value, "events", null)

      id            = lookup(topic.value, "id", null)
      filter_suffix = lookup(topic.value, "filter_suffix", null)
      filter_prefix = lookup(topic.value, "filter_prefix", null)
    }
  }

  dynamic "queue" {
    iterator = queue
    for_each = var.s3_bucket_notification_queue

    content {
      queue_arn = lookup(queue.value, "queue_arn", null)
      events    = lookup(queue.value, "events", null)

      id            = lookup(queue.value, "id", null)
      filter_suffix = lookup(queue.value, "filter_suffix", null)
      filter_prefix = lookup(queue.value, "filter_prefix", null)
    }
  }

  dynamic "lambda_function" {
    iterator = lambda_function
    for_each = var.s3_bucket_notification_lambda_function

    content {
      lambda_function_arn = lookup(lambda_function.value, "lambda_function_arn", null)
      events              = lookup(lambda_function.value, "events", null)

      id            = lookup(lambda_function.value, "id", null)
      filter_suffix = lookup(lambda_function.value, "filter_suffix", null)
      filter_prefix = lookup(lambda_function.value, "filter_prefix", null)
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