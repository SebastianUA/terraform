output "pubsub_topic_name" {
    description = "Name of pubsub topic"
    value       = "${google_pubsub_topic.pubsub_topic.*.name}"
}

output "pubsub_topic_id" {
    description = "ID"
    value       = "${google_pubsub_topic.pubsub_topic.*.id}"
}

output "google_pubsub_topic_iam_policy_etag" {
    description = "Etag"
    value       = "${google_pubsub_topic_iam_policy.pubsub_topic_iam_policy.*.etag}"
}

output "pubsub_topic_iam_binding_etag" {
    description = "Etag"
    value       = "${google_pubsub_topic_iam_binding.pubsub_topic_iam_binding.*.etag}"
}

output "pubsub_topic_iam_member_etag" {
    description = "Etag"
    value       = "${google_pubsub_topic_iam_member.pubsub_topic_iam_member.*.etag}"
}

output "google_pubsub_subscription_default_path" {
    description = "Path of the subscription in the format projects/{project}/subscriptions/{sub}"
    value       = "${google_pubsub_subscription.pubsub_subscription_default.*.path}"
}

output "google_pubsub_subscription_default_name" {
    description = "Name"
    value       = "${google_pubsub_subscription.pubsub_subscription_default.*.name}"
}

output "google_pubsub_subscription_path" {
    description = "Path of the subscription in the format projects/{project}/subscriptions/{sub}"
    value       = "${google_pubsub_subscription.pubsub_subscription.*.path}"
}

output "google_pubsub_subscription_name" {
    description = "Name"
    value       = "${google_pubsub_subscription.pubsub_subscription.*.name}"
}

output "google_pubsub_subscription_iam_policy_etag" {
    description = "Etag"                                    
    value       = "${google_pubsub_subscription_iam_policy.pubsub_subscription_iam_policy.*.etag}"
}

output "google_pubsub_subscription_iam_binding_etag" {
    description = "Etag"
    value       = "${google_pubsub_subscription_iam_binding.pubsub_subscription_iam_binding.*.etag}"
}

output "google_pubsub_subscription_iam_member_etag" {
    description = "Etag"
    value       = "${google_pubsub_subscription_iam_member.pubsub_subscription_iam_member.*.etag}"
}
