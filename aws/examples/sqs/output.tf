output "my_sqs_queue_arn" {
  description = "The URL for the created Amazon SQS queue."
  value       = module.sqs.sqs_queue_arn
}
