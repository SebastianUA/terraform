output "pubsub_topic_name" {
    description = "Name of pubsub topic"
    value       = "${module.google_pubsub.pubsub_topic_name}"
}

output "pubsub_topic_id" {
    description = "ID"
    value       = "${module.google_pubsub.pubsub_topic_id}"
}

output "google_pubsub_topic_iam_policy_etag" {
    description = "Etag"
    value       = "${module.google_pubsub.google_pubsub_topic_iam_policy_etag}"
}

output "pubsub_topic_iam_binding_etag" {
    description = "Etag"
    value       = "${module.google_pubsub.pubsub_topic_iam_binding_etag}"
}

output "pubsub_topic_iam_member_etag" {
    description = "Etag"
    value       = "${module.google_pubsub.pubsub_topic_iam_member_etag}"
}

output "google_pubsub_subscription_default_path" {
    description = "Path of the subscription in the format projects/{project}/subscriptions/{sub}"
    value       = "${module.google_pubsub.google_pubsub_subscription_default_path}"
}

output "google_pubsub_subscription_default_name" {
    description = "Name"
    value       = "${module.google_pubsub.google_pubsub_subscription_default_name}"
}

output "google_pubsub_subscription_path" {
    description = "Path of the subscription in the format projects/{project}/subscriptions/{sub}"
    value       = "${module.google_pubsub.google_pubsub_subscription_path}"
}

output "google_pubsub_subscription_name" {
    description = "Name"
    value       = "${module.google_pubsub.google_pubsub_subscription_name}"
}

output "google_pubsub_subscription_iam_policy_etag" {
    description = "Etag"
    value       = "${module.google_pubsub.google_pubsub_subscription_iam_policy_etag}"
}

output "google_pubsub_subscription_iam_binding_etag" {
    description = "Etag"
    value       = "${module.google_pubsub.google_pubsub_subscription_iam_binding_etag}"
}

output "google_pubsub_subscription_iam_member_etag" {
    description = "Etag"
    value       = "${module.google_pubsub.google_pubsub_subscription_iam_member_etag}"
}
