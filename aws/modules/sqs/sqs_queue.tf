#---------------------------------------------------
# Create AWS SQS
#---------------------------------------------------
resource "aws_sqs_queue" "sqs_queue" {
    count                               = var.enable_sqs_queue ? 1 : 0

    name                                = var.sqs_queue_name != "" && var.name_prefix == "" ? var.sqs_queue_name : null
    name_prefix                         = var.name_prefix !="" &&  var.sqs_queue_name == "" ? var.name_prefix : null
    delay_seconds                       = var.delay_seconds
    max_message_size                    = var.max_message_size
    message_retention_seconds           = var.message_retention_seconds
    receive_wait_time_seconds           = var.receive_wait_time_seconds
    visibility_timeout_seconds          = var.visibility_timeout_seconds

    policy                              = var.sqs_queue_policy
    redrive_policy                      = length(var.sqs_dead_letter_queue_arn) > 0 ? jsonencode({
        deadLetterTargetArn = var.sqs_dead_letter_queue_arn
        maxReceiveCount     = var.maxReceiveCount
    }) : null

    fifo_queue                          = var.fifo_queue
    content_based_deduplication         = var.content_based_deduplication

    kms_master_key_id                   = var.kms_master_key_id
    kms_data_key_reuse_period_seconds   = var.kms_data_key_reuse_period_seconds

    tags                                = merge(
        {
            "Name"  = var.sqs_queue_name != "" && var.name_prefix == "" ? var.sqs_queue_name : var.name_prefix
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                          = []
}
