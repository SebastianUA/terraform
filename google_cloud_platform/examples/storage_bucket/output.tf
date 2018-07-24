output "storage_bucket_name" {
    description = "Name of google storage bucket"
    value       = "${module.storage_bucket.google_storage_bucket_name}"
}

output "storage_bucket_self_link" {
    description = "self_link"
    value       = "${module.storage_bucket.google_storage_bucket_self_link}"
}

output "storage_bucket_url" {
    description = "URL"
    value       = "${module.storage_bucket.google_storage_bucket_url}"
}

output "storage_bucket_acl_role_entity_id" {
    description = "ID for storage bucket acl"
    value       = "${module.storage_bucket_acl.google_storage_bucket_acl_role_entity_id}"
}

output "storage_bucket_acl_predefined_acl_id" {
    description = "ID for storage bucket acl"
    value       = "${module.storage_bucket_acl.google_storage_bucket_acl_predefined_acl_id}"
}

output "storage_bucket_iam_binding_etag" {
    description = "etag"
    value       = "${module.storage_bucket_iam_binding.google_storage_bucket_iam_binding_etag}"
}

output "storage_bucket_iam_binding_id" {
    description = "ID"
    value       = "${module.storage_bucket_iam_binding.google_storage_bucket_iam_binding_id}"
}

output "storage_bucket_iam_binding_role" {
    description = "Role"
    value       = "${module.storage_bucket_iam_binding.google_storage_bucket_iam_binding_role}"
}

output "storage_bucket_iam_member_id" {
    description = "ID"
    value       = "${module.storage_bucket_iam_member.google_storage_bucket_iam_member_id}"
}

output "storage_bucket_iam_member_role" {
    description = "Role"
    value       = "${module.storage_bucket_iam_member.google_storage_bucket_iam_member_role}"
}

output "storage_bucket_iam_member_etag" {
    description = "etag"
    value       = "${module.storage_bucket_iam_member.google_storage_bucket_iam_member_etag}"
}

output "storage_bucket_iam_policy_id" {
    description = "ID"
    value       = "${module.storage_bucket_iam_policy.google_storage_bucket_iam_policy_id}"
}

output "storage_bucket_iam_policy_etag" {
    description = "etag"
    value       = "${module.storage_bucket_iam_policy.google_storage_bucket_iam_policy_etag}"
}

output "storage_default_object_acl_id" {
    description = "ID"
    value       = "${module.storage_default_object_acl.google_storage_default_object_acl_id}"
}

output "storage_object_acl_id" {
    description = "ID"
    value       = "${module.storage_object_acl.google_storage_object_acl_id}"
}

output "storage_bucket_object_id" {
    description = "ID"
    value       = "${module.storage_bucket_object.google_storage_bucket_object_id}"
}

output "storage_bucket_object_name" {
    description = "Name"
    value       = "${module.storage_bucket_object.google_storage_bucket_object_name}"
}

output "storage_notification_self_link" {
    description = "self_link"
    value       = "${module.storage_notification.google_storage_notification_self_link}"
}
