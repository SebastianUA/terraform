#
# Compute address
#
output "google_compute_address_name" {
    description = "Name of google_compute_address"
    value       = "${google_compute_address.compute_address.*.name}"
}

output "google_compute_address_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_address.compute_address.*.self_link}"
}

output "google_compute_address_address" {
    description = "The IP of the created resource."
    value       = "${google_compute_address.compute_address.*.address}"
}

output "google_compute_address_users" {
    description = "The URLs of the resources that are using this address."
    value       = "${google_compute_address.compute_address.*.users}"
}
#
# Compute global address
#
output "google_compute_global_address_name" {
    description = "Name of google_compute_global_address"
    value       = "${google_compute_global_address.compute_global_address.*.name}"
}

output "google_compute_global_address_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_global_address.compute_global_address.*.self_link}"
}

output "google_compute_global_address_address" {
    description = "The IP of the created resource."
    value       = "${google_compute_global_address.compute_global_address.*.address}"
}

