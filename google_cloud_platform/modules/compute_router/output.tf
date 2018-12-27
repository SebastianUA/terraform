#
# Router
#
output "google_compute_router_name" {
    description = "Name of google_compute_router"
    value       = "${google_compute_router.compute_router.*.name}"
}

output "google_compute_router_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_router.compute_router.*.self_link}"
}

output "google_compute_router_custom_name" {
    description = "Name of google_compute_router"
    value       = "${google_compute_router.compute_router_custom.*.name}"
}

output "google_compute_router_custom_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_router.compute_router_custom.*.self_link}"
}
#
# Router interface
#
output "google_compute_router_interface_name" {
    description = "Name"
    value       = "${google_compute_router_interface.compute_router_interface.*.name}"
}

output "google_compute_router_interface_id" {
    description = "ID"
    value       = "${google_compute_router_interface.compute_router_interface.*.id}"
}
#
# Router peer
#
output "google_compute_router_peer_name" {
    description = "Name"
    value       = "${google_compute_router_peer.compute_router_peer.*.name}"
}

output "google_compute_router_peer_ip_address" {
    description = "ip_address"
    value       = "${google_compute_router_peer.compute_router_peer.*.ip_address}"
}

