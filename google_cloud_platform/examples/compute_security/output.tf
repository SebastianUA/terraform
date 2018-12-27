output "compute_security_policy_name" {
    description = "Name"
    value       = "${module.compute_security.google_compute_security_policy_name}"
}

output "compute_security_policy_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_security.google_compute_security_policy_self_link}"
}

output "compute_security_policy_custom_name" {
    description = "Name"
    value       = "${module.compute_security.google_compute_security_policy_custom_name}"
}

output "compute_security_policy_custom_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_security.google_compute_security_policy_custom_self_link}"
}

