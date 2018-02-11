output "sqs_arn" {
  value = "${aws_sqs_queue.sqs_queue.arn}"
}

output "sqs_id" {
  value = "${aws_sqs_queue.sqs_queue.id}"
}
