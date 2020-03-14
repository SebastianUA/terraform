output "compute_snapshot_name" {
    description = "Name of google compute snapshot"
    value       = "${module.compute_snapshot.google_compute_snapshot_name}"
}

output "compute_snapshot_label_fingerprint" {
    description = "The unique fingerprint of the labels."
    value       = "${module.compute_snapshot.google_compute_snapshot_label_fingerprint}"
}

output "compute_snapshot_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_snapshot.google_compute_snapshot_self_link}"
}

output "compute_snapshot_source_disk_link" {
    description = "The URI of the source disk."
    value       = "${module.compute_snapshot.google_compute_snapshot_source_disk_link}"
}
