output "name" {
    description = "Name for google compute disk"
    value       = "${google_compute_disk.compute_disk.*.name}"
}

output "self_link" {
    description = "Self link for google compute disk"
    value       = "${google_compute_disk.compute_disk.*.self_link}"
}
