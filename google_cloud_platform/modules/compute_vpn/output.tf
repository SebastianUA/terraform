#
# Gateway
#
output "google_compute_vpn_gateway_name" {
    description = "Name of compute_vpn_gateway"
    value       = "${google_compute_vpn_gateway.compute_vpn_gateway.*.name}"
}

output "google_compute_vpn_gateway_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_vpn_gateway.compute_vpn_gateway.*.self_link}"
}

output "google_compute_vpn_gateway_id" {
    description = "ID"
    value       = "${google_compute_vpn_gateway.compute_vpn_gateway.*.id}"
}
#
# Tunnel
#
output "google_compute_vpn_tunnel_name" {
    description = "Name"
    value       = "${google_compute_vpn_tunnel.compute_vpn_tunnel.*.name}"
}

output "google_compute_vpn_tunnel_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_vpn_tunnel.compute_vpn_tunnel.*.self_link}"
}

output "google_compute_vpn_tunnel_detailed_status" {
    description = "Detailed status message for the VPN tunnel."
    value       = "${google_compute_vpn_tunnel.compute_vpn_tunnel.*.detailed_status}"
}

output "google_compute_vpn_tunnel_shared_secret_hash" {
    description = "Hash of the shared secret."
    value       = "${google_compute_vpn_tunnel.compute_vpn_tunnel.*.shared_secret_hash}"
}
