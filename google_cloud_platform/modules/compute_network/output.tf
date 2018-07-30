#
# Network
#
output "google_compute_network_name" {
    description = "Name of google compute network"
    value       = "${google_compute_network.compute_network.*.name}"
}

output "google_compute_network_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_network.compute_network.*.self_link}"
}

output "google_compute_network_gateway_ipv4" {
    description = "The IPv4 address of the gateway."
    value       = "${google_compute_network.compute_network.*.gateway_ipv4}"
}

#
# Network peering
#
output "google_compute_network_peering_name" {
    description = "Name"
    value       = "${google_compute_network_peering.compute_network_peering.*.name}"
}

output "google_compute_network_peering_state" {
    description = "State for the peering."
    value       = "${google_compute_network_peering.compute_network_peering.*.state}"
}

output "google_compute_network_peering_state_details" {
    description = "Details about the current state of the peering."
    value       = "${google_compute_network_peering.compute_network_peering.*.state_details}"
}

#
# Subnetwork
#
output "google_compute_subnetwork_name" {
    description = "Name"
    value       = "${google_compute_subnetwork.compute_subnetwork.*.name}"
}

output "google_compute_subnetwork_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_subnetwork.compute_subnetwork.*.self_link}"
}

output "google_compute_subnetwork_gateway_address" {
    description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
    value       = "${google_compute_subnetwork.compute_subnetwork.*.gateway_address}"
}

output "google_compute_subnetwork_with_secondary_ip_range_name" {
    description = "Name"
    value       = "${google_compute_subnetwork.compute_subnetwork_with_secondary_ip_range.*.name}"
}

output "google_compute_subnetwork_with_secondary_ip_range_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_subnetwork.compute_subnetwork_with_secondary_ip_range.*.self_link}"
}

output "google_compute_subnetwork_with_secondary_ip_range_gateway_address" {
    description = "The gateway address for default routes to reach destination addresses outside this subnetwork."
    value       = "${google_compute_subnetwork.compute_subnetwork_with_secondary_ip_range.*.gateway_address}"
}

#
# IAM
#
output "google_compute_subnetwork_iam_policy_etag" {
    description = "(Computed) The etag of the subnetwork's IAM policy."
    value       = "${google_compute_subnetwork_iam_policy.compute_subnetwork_iam_policy.*.etag}"
}

output "google_compute_subnetwork_iam_binding_etag" {
    description = "Etag"
    value       = "${google_compute_subnetwork_iam_binding.compute_subnetwork_iam_binding.*.etag}"
}

output "google_compute_subnetwork_iam_member_etag" {
    description = ""
    value       = "${google_compute_subnetwork_iam_member.compute_subnetwork_iam_member.*.etag}"
}

