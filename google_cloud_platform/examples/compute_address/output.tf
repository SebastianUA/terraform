#
# Compute address
#
output "compute_address_name" {
    description = "Name of google_compute_address"
    value       = "${module.compute_address.google_compute_address_name}"    
}

output "compute_address_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_address.google_compute_address_self_link}"
}

output "compute_address_address" {
    description = "The IP of the created resource."
    value       = "${module.compute_address.google_compute_address_address}"
}

output "compute_address_users" {
    description = "The URLs of the resources that are using this address."
    value       = "${module.compute_address.google_compute_address_users}"
}
#
# Compute global address
#
output "compute_global_address_name" {
    description = "Name of google_compute_global_address"
    value       = "${module.compute_address.google_compute_global_address_name}"
}

output "compute_global_address_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_address.google_compute_global_address_self_link}"
}

output "compute_global_address_address" {
    description = "The IP of the created resource."
    value       = "${module.compute_address.google_compute_global_address_address}"
}

