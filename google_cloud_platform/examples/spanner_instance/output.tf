#-------------------------------------------------------------------
# instance
#-------------------------------------------------------------------
output "spanner_instance_name" {
    description = "Name of spanner_instance"
    value       = "${module.spanner_instance.google_spanner_instance_name}"
}

output "spanner_instance_state" {
    description = "The current state of the instance."
    value       = "${module.spanner_instance.google_spanner_instance_state}"
}

output "spanner_instance_id" {
    description = "ID"
    value       = "${module.spanner_instance.google_spanner_instance_id}"
}

#-------------------------------------------------------------------
# IAM
#-------------------------------------------------------------------
output "spanner_instance_iam_policy_etag" {
    description = "etag"
    value       = "${module.spanner_instance.google_spanner_instance_iam_policy_etag}"
}

output "spanner_instance_iam_binding_etag" {
    description = "etag"
    value       = "${module.spanner_instance.google_spanner_instance_iam_binding_etag}"
}

output "spanner_instance_iam_member_etag" {
    description = "etag"
    value       = "${module.spanner_instance.google_spanner_instance_iam_member_etag}"
}
#-------------------------------------------------------------------
# DB
#-------------------------------------------------------------------
output "spanner_database_name" {
    description = "Name"
    value       = "${module.spanner_instance.google_spanner_database_name}"
}

output "spanner_database_state" {
    description = "state"
    value       = "${module.spanner_instance.google_spanner_database_state}"
}
#-------------------------------------------------------------------
# DM IAM
#-------------------------------------------------------------------
output "spanner_database_iam_policy_etag" {
    description = "Etag"
    value       = "${module.spanner_instance.google_spanner_database_iam_policy_etag}"
}

output "spanner_database_iam_binding_etag" {
    description = "Etag"
    value       = "${module.spanner_instance.google_spanner_database_iam_binding_etag}"
}

output "spanner_database_iam_member_etag" {
    description = "Etag"
    value       = "${module.spanner_instance.google_spanner_database_iam_member_etag}"
}

