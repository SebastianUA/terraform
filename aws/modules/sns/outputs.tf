output "sns_topic_id" {
    value = "${aws_sns_topic.sns_topic.id}"
}

output "sns_topic_arn" {
    value = "${aws_sns_topic.sns_topic.arn}"
}

output "sns_topic_policy_id" {
    value = "${aws_sns_topic_subscription.sns_topic_subscription.id}"    
}

