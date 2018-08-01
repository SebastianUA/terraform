output "google_compute_route_name" {
    description = "Name of compute_route"
    value       = "${google_compute_route.compute_route.*.name}"
}

output "google_compute_route_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_route.compute_route.*.self_link}"
}

output "google_compute_route_next_hop_network" {
    description = "URL to a Network that should handle matching packets."
    value       = "${google_compute_route.compute_route.*.next_hop_network}"
}
