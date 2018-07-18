#-------------------------------------------------------------------
# instance
#-------------------------------------------------------------------
output "google_spanner_instance_name" {
    description = "Name of spanner_instance"
    value       = "${google_spanner_instance.spanner_instance.name}"
}

output "google_spanner_instance_state" {
    description = "The current state of the instance."
    value       = "${google_spanner_instance.spanner_instance.state}"
}

output "google_spanner_instance_id" {
    description = "ID"
    value       = "${google_spanner_instance.spanner_instance.id}"
}
#-------------------------------------------------------------------
# IAM
#-------------------------------------------------------------------
output "google_spanner_instance_iam_policy_etag" {
    description = "etag"
    value       = "${google_spanner_instance_iam_policy.spanner_instance_iam_policy.*.etag}"
}

output "google_spanner_instance_iam_binding_etag" {
    description = "etag"
    value       = "${google_spanner_instance_iam_binding.spanner_instance_iam_binding.*.etag}"
}

output "google_spanner_instance_iam_member_etag" {
    description = "etag"
    value       = "${google_spanner_instance_iam_member.spanner_instance_iam_member.*.etag}"
}
#-------------------------------------------------------------------
# DB
#-------------------------------------------------------------------
output "google_spanner_database_name" {
    description = "Name"
    value       = "${google_spanner_database.spanner_database.*.name}"
}

output "google_spanner_database_state" {
    description = "state" 
    value       = "${google_spanner_database.spanner_database.*.state}"
}
#-------------------------------------------------------------------
# DM IAM
#-------------------------------------------------------------------
output "google_spanner_database_iam_policy_etag" {
    description = "Etag"
    value       = "${google_spanner_database_iam_policy.spanner_database_iam_policy.*.etag}"
}

output "google_spanner_database_iam_binding_etag" {
    description = "Etag"
    value       = "${google_spanner_database_iam_binding.spanner_database_iam_binding.*.etag}"
}

output "google_spanner_database_iam_member_etag" {
    description = "Etag"
    value       = "${google_spanner_database_iam_member.spanner_database_iam_member.*.etag}"
}
