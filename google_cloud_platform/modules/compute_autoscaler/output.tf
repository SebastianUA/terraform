output "name" {
    description = "Name of compute autoscaler"
    value       = "${google_compute_autoscaler.compute_autoscaler.*.name}"
}

output "self_link" {
    description = "self_link of compute autoscaler"
    value       = "${google_compute_autoscaler.compute_autoscaler.*.self_link}"
}
