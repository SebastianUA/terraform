output "google_compute_snapshot_name" {
    description = "Name of google compute snapshot"
    value       = "${google_compute_snapshot.compute_snapshot.*.name}"
}

output "google_compute_snapshot_label_fingerprint" {
    description = "The unique fingerprint of the labels."
    value       = "${google_compute_snapshot.compute_snapshot.*.label_fingerprint}"
}

output "google_compute_snapshot_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_snapshot.compute_snapshot.*.self_link}"
}

output "google_compute_snapshot_source_disk_link" {
    description = "The URI of the source disk."
    value       = "${google_compute_snapshot.compute_snapshot.*.source_disk_link}"
}

