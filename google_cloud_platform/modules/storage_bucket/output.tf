output "google_storage_bucket_name" {
    description = "Name of google storage bucket"
    value       = "${google_storage_bucket.storage_bucket.*.name}"
}

output "google_storage_bucket_self_link" {
    description = "self_link"
    value       = "${google_storage_bucket.storage_bucket.*.self_link}"
}

output "google_storage_bucket_url" {
    description = "URL"
    value       = "${google_storage_bucket.storage_bucket.*.url}"
}

output "google_storage_bucket_acl_role_entity_id" {
    description = "ID for storage bucket acl"
    value       = "${google_storage_bucket_acl.storage_bucket_acl_role_entity.*.id}"
}               
 
output "google_storage_bucket_acl_predefined_acl_id" {
    description = "ID for storage bucket acl"
    value       = "${google_storage_bucket_acl.storage_bucket_acl_predefined_acl.*.id}"
}

output "google_storage_bucket_iam_binding_etag" {
    description = "etag"
    value       = "${google_storage_bucket_iam_binding.storage_bucket_iam_binding.*.etag}"
}

output "google_storage_bucket_iam_binding_id" {
    description = "ID"
    value       = "${google_storage_bucket_iam_binding.storage_bucket_iam_binding.*.id}"
}

output "google_storage_bucket_iam_binding_role" {
    description = "Role"
    value       = "${google_storage_bucket_iam_binding.storage_bucket_iam_binding.*.role}"
}

output "google_storage_bucket_iam_member_id" {
    description = "ID"                                  
    value       = "${google_storage_bucket_iam_member.storage_bucket_iam_member.*.id}"
}

output "google_storage_bucket_iam_member_role" {
    description = "Role"
    value       = "${google_storage_bucket_iam_member.storage_bucket_iam_member.*.role}"
}

output "google_storage_bucket_iam_member_etag" {
    description = "etag"
    value       = "${google_storage_bucket_iam_member.storage_bucket_iam_member.*.etag}"
}

output "google_storage_bucket_iam_policy_id" {
    description = "ID"                                      
    value       = "${google_storage_bucket_iam_policy.storage_bucket_iam_policy.*.id}"
}

output "google_storage_bucket_iam_policy_etag" {
    description = "etag"
    value       = "${google_storage_bucket_iam_policy.storage_bucket_iam_policy.*.etag}"
}

output "google_storage_default_object_acl_id" {
    description = "ID"
    value       = "${google_storage_default_object_acl.storage_default_object_acl.*.id}"
}

output "google_storage_object_acl_id" {
    description = "ID"
    value       = "${google_storage_object_acl.storage_object_acl.*.id}"
}

output "google_storage_bucket_object_id" {
    description = "ID"                                  
    value       = "${google_storage_bucket_object.storage_bucket_object.*.id}"
}

output "google_storage_bucket_object_name" {
    description = "Name"
    value       = "${google_storage_bucket_object.storage_bucket_object.*.name}"
}

output "google_storage_notification_self_link" {
    description = "self_link"                       
    value       = "${google_storage_notification.storage_notification.*.self_link}"
}
