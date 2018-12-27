output "google_compute_security_policy_name" {
    description = "Name"
    value       = "${google_compute_security_policy.compute_security_policy.*.name}"
}

output "google_compute_security_policy_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_security_policy.compute_security_policy.*.self_link}"
}

output "google_compute_security_policy_custom_name" {
    description = "Name"
    value       = "${google_compute_security_policy.compute_security_policy_custom.*.name}"
}

output "google_compute_security_policy_custom_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_security_policy.compute_security_policy_custom.*.self_link}"
}

