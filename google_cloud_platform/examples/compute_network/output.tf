#
# Network
# 
output "compute_network_name" {
    description = "Name of google compute network"
    value       = "${module.compute_network.google_compute_network_name}"
}

output "google_compute_network_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_network.google_compute_network_self_link}"
}

output "google_compute_network_gateway_ipv4" {
    description = "The IPv4 address of the gateway."
    value       = "${module.compute_network.google_compute_network_gateway_ipv4}"
}
#
# Network peering
#   
output "compute_network_peering_name" {
    description = "Name"
    value       = "${module.compute_network.google_compute_network_peering_name}"
}

output "compute_network_peering_state" {
    description = "State for the peering."
    value       = "${module.compute_network.google_compute_network_peering_state}"
}

output "compute_network_peering_state_details" {
    description = "Details about the current state of the peering."
    value       = "${module.compute_network.google_compute_network_peering_state_details}"
}

#
# Subnetwork
#
output "compute_subnetwork_name" {
    description = "Name"
    value       = "${module.compute_network.google_compute_subnetwork_name}"
}

output "compute_subnetwork_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_network.google_compute_subnetwork_self_link}"
}

output "compute_subnetwork_gateway_address" {
    description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
    value       = "${module.compute_network.google_compute_subnetwork_gateway_address}"
}

output "compute_subnetwork_with_secondary_ip_range_name" {
    description = "Name"
    value       = "${module.compute_network.google_compute_subnetwork_with_secondary_ip_range_name}"
}

output "compute_subnetwork_with_secondary_ip_range_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_network.google_compute_subnetwork_with_secondary_ip_range_self_link}"
}

output "compute_subnetwork_with_secondary_ip_range_gateway_address" {
    description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
    value       = "${module.compute_network.google_compute_subnetwork_with_secondary_ip_range_gateway_address}"
}

#
# IAM
#
output "compute_subnetwork_iam_policy_etag" {
    description = "(Computed) The etag of the subnetwork's IAM policy."
    value       = "${module.compute_network.google_compute_subnetwork_iam_policy_etag}"
}

output "compute_subnetwork_iam_binding_etag" {
    description = "Etag"
    value       = "${module.compute_network.google_compute_subnetwork_iam_binding_etag}"
}

output "compute_subnetwork_iam_member_etag" {
    description = ""
    value       = "${module.compute_subnetwork_iam_member.google_compute_subnetwork_iam_member_etag}"
}

