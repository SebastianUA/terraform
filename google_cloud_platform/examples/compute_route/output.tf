output "compute_route_name" {
    description = "Name of compute_route"
    value       = "${module.compute_route.google_compute_route_name}"
}

output "compute_route_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_route.google_compute_route_name}"
}

output "compute_route_next_hop_network" {
    description = "URL to a Network that should handle matching packets."
    value       = "${module.compute_route.google_compute_route_name}"
}

