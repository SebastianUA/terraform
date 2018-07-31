#
# SSL policy
#
output "google_compute_ssl_policy_name" {
    description = "Name of google_compute_ssl_policy"
    value       = "${google_compute_ssl_policy.compute_ssl_policy.*.name}"
}

output "google_compute_ssl_policy_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_ssl_policy.compute_ssl_policy.*.self_link}"
}

output "google_compute_ssl_policy_enabled_features" {
    description = "The list of features enabled in the SSL policy."
    value       = "${google_compute_ssl_policy.compute_ssl_policy.*.enabled_features}"
}

output "google_compute_ssl_policy_custom_name" {
    description = "Name of google_compute_ssl_policy"
    value       = "${google_compute_ssl_policy.compute_ssl_policy_custom.*.name}"
}

output "google_compute_ssl_policy_custom_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_ssl_policy.compute_ssl_policy_custom.*.self_link}"
}

output "google_compute_ssl_policy_custom_enabled_features" {
    description = "The list of features enabled in the SSL policy."
    value       = "${google_compute_ssl_policy.compute_ssl_policy_custom.*.enabled_features}"
}
#
# SSL certificate
#
output "google_compute_ssl_certificate_name" {
    description = "Name of google_compute_ssl_certificate"
    value       = "${google_compute_ssl_certificate.compute_ssl_certificate.*.name}"
}

output "google_compute_ssl_certificate_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_ssl_certificate.compute_ssl_certificate.*.self_link}"
}

output "google_compute_ssl_certificate_certificate_id" {
    description = "A unique ID for the certificate, assigned by GCE."
    value       = "${google_compute_ssl_certificate.compute_ssl_certificate.*.certificate_id}"
}

output "google_compute_ssl_certificate_name_prefix_name" {
    description = "Name of google_compute_ssl_certificate"
    value       = "${google_compute_ssl_certificate.compute_ssl_certificate_name_prefix.*.name}"
}

output "google_compute_ssl_certificate_name_prefix_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_ssl_certificate.compute_ssl_certificate_name_prefix.*.self_link}"
}

output "google_compute_ssl_certificate_name_prefix_certificate_id" {
    description = "A unique ID for the certificate, assigned by GCE."
    value       = "${google_compute_ssl_certificate.compute_ssl_certificate_name_prefix.*.certificate_id}"
}

