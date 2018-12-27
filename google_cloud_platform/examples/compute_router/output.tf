#
# Router
#
output "compute_router_name" {
    description = "Name of google_compute_router"
    value       = "${module.compute_router.google_compute_router_name}"
}

output "compute_router_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_router.google_compute_router_self_link}"
}

output "compute_router_custom_name" {
    description = "Name of google_compute_router"
    value       = "${module.compute_router.google_compute_router_custom_name}"
}

output "compute_router_custom_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_router.google_compute_router_custom_self_link}"
}
#
# Router interface
#   
output "compute_router_interface_name" {
    description = "Name"
    value       = "${module.compute_router.google_compute_router_interface_name}"
}

output "compute_router_interface_id" {
    description = "ID"
    value       = "${module.compute_router.google_compute_router_interface_id}"
}
#
# Router peer
#
output "compute_router_peer_name" {
    description = "Name"
    value       = "${module.compute_router.google_compute_router_peer_name}"
}

output "compute_router_peer_ip_address" {
    description = "ip_address"
    value       = "${module.compute_router.google_compute_router_peer_ip_address}"
}

