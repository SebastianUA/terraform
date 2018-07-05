output "name" {
    description = "Name of google compute image"
    value       = "${google_compute_image.compute_image.*.name}"
}

output "self_link" {
    description = ""
    value       = "${google_compute_image.compute_image.*.self_link}"
}

output "label_fingerprint" {
    description = ""
    value       = "${google_compute_image.compute_image.*.label_fingerprint}"
}
