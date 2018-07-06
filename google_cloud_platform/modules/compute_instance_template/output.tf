output "name" {
    description = "Name of compute instance template"
    value       = "${google_compute_instance_template.compute_instance_template.*.name}"
}

output "self_link" {
    description = "self_link"
    value       = "${google_compute_instance_template.compute_instance_template.*.self_link}"
}
