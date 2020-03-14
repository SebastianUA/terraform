#---------------------------------------------------
# SNS topic
#---------------------------------------------------
output "sns_topic_id" {
    description = "The ARN of the SNS topic"
    value       = element(concat(aws_sns_topic.sns_topic.*.id, [""]), 0)
}

output "sns_topic_arn" {
    description = "The ARN of the SNS topic, as a more obvious property (clone of id)"
    value       = element(concat(aws_sns_topic.sns_topic.*.arn, [""]), 0)
}

#---------------------------------------------------
# SNS topic policies
#---------------------------------------------------
output "sns_topic_policy_id" {
    description = "Get SNS topic policy ID"
    value       = element(concat(aws_sns_topic_subscription.sns_topic_subscription.*.id, [""]), 0)
}

#---------------------------------------------------
# SNS topic subscription
#---------------------------------------------------
output "sns_topic_subscription_id" {
    description = "The ARN of the subscription"
    value       = element(concat(aws_sns_topic_subscription.sns_topic_subscription.*.id, [""]), 0)
}

output "sns_topic_subscription_arn" {
    description = "The ARN of the subscription stored as a more user-friendly property"
    value       = element(concat(aws_sns_topic_subscription.sns_topic_subscription.*.arn, [""]), 0)
}

output "sns_topic_subscription_topic_arn" {
    description = "The ARN of the topic the subscription belongs to"
    value       = element(concat(aws_sns_topic_subscription.sns_topic_subscription.*.topic_arn, [""]), 0)
}

output "sns_topic_subscription_protocol" {
    description = "The protocol being used"
    value       = element(concat(aws_sns_topic_subscription.sns_topic_subscription.*.protocol, [""]), 0)
}

output "sns_topic_subscription_endpoint" {
    description = "The full endpoint to send data to (SQS ARN, HTTP(S) URL, Application ARN, SMS number, etc.)"
    value       = element(concat(aws_sns_topic_subscription.sns_topic_subscription.*.endpoint, [""]), 0)
}
