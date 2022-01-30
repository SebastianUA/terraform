#---------------------------------------------------
# AWS SQS queue policy
#---------------------------------------------------
resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  count = var.enable_sqs_queue_policy ? 1 : 0

  queue_url = var.sqs_queue_policy_queue_url != "" ? var.sqs_queue_policy_queue_url : element(concat(aws_sqs_queue.sqs_queue.*.id, [""]), 0)
  policy    = data.template_file.sqs_queue_policy.rendered

  depends_on = [
    aws_sqs_queue.sqs_queue,
    data.template_file.sqs_queue_policy
  ]
}

data "template_file" "sqs_queue_policy" {
  template = var.sqs_queue_policy
}
