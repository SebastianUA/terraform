#
# Gateway
#
output "compute_vpn_gateway_name" {
    description = "Name of compute_vpn_gateway"
    value       = "${module.compute_vpn_gateway.google_compute_vpn_gateway_name}"
}

output "compute_vpn_gateway_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_vpn_gateway.google_compute_vpn_gateway_name}"
}

output "compute_vpn_gateway_id" {
    description = "ID"
    value       = "${module.compute_vpn_gateway.google_compute_vpn_gateway_id}"
}
#
# Tunnel
#   
output "compute_vpn_tunnel_name" {
    description = "Name"
    value       = "${module.compute_vpn_tunnel.google_compute_vpn_tunnel_name}"
}

output "compute_vpn_tunnel_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_vpn_tunnel.google_compute_vpn_tunnel_self_link}"
}

output "compute_vpn_tunnel_detailed_status" {
    description = "Detailed status message for the VPN tunnel."
    value       = "${module.compute_vpn_tunnel.google_compute_vpn_tunnel_detailed_status}"
}

output "compute_vpn_tunnel_shared_secret_hash" {
    description = "Hash of the shared secret."
    value       = "${module.compute_vpn_tunnel.google_compute_vpn_tunnel_shared_secret_hash}"
}

