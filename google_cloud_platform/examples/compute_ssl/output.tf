#
# SSL policy
#       
output "compute_ssl_policy_name" {
    description = "Name of google_compute_ssl_policy"
    value       = "${module.compute_ssl.google_compute_ssl_policy_name}"
}

output "compute_ssl_policy_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_ssl.google_compute_ssl_policy_self_link}"
}

output "compute_ssl_policy_enabled_features" {
    description = "The list of features enabled in the SSL policy."
    value       = "${module.compute_ssl.google_compute_ssl_policy_enabled_features}"
}

output "compute_ssl_policy_custom_name" {
    description = "Name of google_compute_ssl_policy"
    value       = "${module.compute_ssl.google_compute_ssl_policy_custom_name}"
}

output "compute_ssl_policy_custom_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_ssl.google_compute_ssl_policy_custom_self_link}"
}

output "compute_ssl_policy_custom_enabled_features" {
    description = "The list of features enabled in the SSL policy."
    value       = "${module.compute_ssl.google_compute_ssl_policy_custom_enabled_features}"
}
#
# SSL certificate
#
output "google_compute_ssl_certificate_name" {
    description = "Name of google_compute_ssl_certificate"
    value       = "${module.compute_ssl.google_compute_ssl_certificate_name}"
}

output "google_compute_ssl_certificate_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_ssl.google_compute_ssl_certificate_self_link}"
}

output "google_compute_ssl_certificate_certificate_id" {
    description = "A unique ID for the certificate, assigned by GCE."
    value       = "${module.compute_ssl.google_compute_ssl_certificate_certificate_id}"
}

output "compute_ssl_certificate_name_prefix_name" {
    description = "Name of google_compute_ssl_certificate"
    value       = "${module.compute_ssl.google_compute_ssl_certificate_name_prefix_name}"
}

output "compute_ssl_certificate_name_prefix_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_ssl.google_compute_ssl_certificate_name_prefix_self_link}"
}

output "compute_ssl_certificate_name_prefix_certificate_id" {
    description = "A unique ID for the certificate, assigned by GCE."
    value       = "${module.compute_ssl.google_compute_ssl_certificate_name_prefix_certificate_id}"
}
