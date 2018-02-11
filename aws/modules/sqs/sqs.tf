#---------------------------------------------------
# Create AWS SQS 
#---------------------------------------------------
resource "aws_sqs_queue" "sqs_queue" {                      
    name                        = "${var.enable_fifo_queue ? "${lower(var.name)}-sqs-${lower(var.environment)}.fifo" : "${lower(var.name)}-sqs-${lower(var.environment)}" }"
    delay_seconds               = "${var.delay_seconds}"
    max_message_size            = "${var.max_message_size}"
    message_retention_seconds   = "${var.message_retention_seconds}"
    receive_wait_time_seconds   = "${var.receive_wait_time_seconds}"
    visibility_timeout_seconds  = "${var.visibility_timeout_seconds}"

    redrive_policy            = "${length(var.sqs_dead_letter_queue_arn) > 0 ? data.template_file.redrive_policy.rendered : "" }"
    
    fifo_queue                  = "${var.enable_fifo_queue}"
    content_based_deduplication = "${var.content_based_deduplication}"
    
    kms_master_key_id                 = "${var.kms_master_key_id}"
    kms_data_key_reuse_period_seconds = "${var.kms_data_key_reuse_period_seconds}"
    

    tags {
        Name            = "${lower(var.name)}-sqs-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = ["data.template_file.redrive_policy"]
}

data "template_file" "redrive_policy" {
    template = "${file("${path.module}/policies/redrive_policy.json.tpl")}"

    vars {
        deadLetterTargetArn = "${var.sqs_dead_letter_queue_arn}"    
        maxReceiveCount     = "${var.maxReceiveCount}"
    }
}
#---------------------------------------------------
# Create AWS SQS queue policy
#---------------------------------------------------
resource "aws_sqs_queue_policy" "sqs_queue_policy" {
    queue_url   = "${aws_sqs_queue.sqs_queue.id}"
    policy      = "${data.template_file.sqs_queue_policy.rendered}"

    depends_on  = ["aws_sqs_queue.sqs_queue", "data.template_file.sqs_queue_policy"]
}

data "template_file" "sqs_queue_policy" {

    template = "${file("${path.module}/policies/sqs_queue_policy.json.tpl")}"

    vars {  
        sqs_arn  = "${aws_sqs_queue.sqs_queue.arn}"
    }

}
