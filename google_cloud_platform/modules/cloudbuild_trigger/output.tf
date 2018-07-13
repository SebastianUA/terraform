output "cloudbuild_trigger_id" {
    description = "ID"
    value       = "${google_cloudbuild_trigger.cloudbuild_trigger.*.id}"
}

output "cloudbuild_trigger_filename_id" {
    description = "ID"
    value       = "${google_cloudbuild_trigger.cloudbuild_trigger_filename.*.id}"
}

