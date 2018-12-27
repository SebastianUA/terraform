output "compute_url_map_name" {
    description = "Name of google_compute_url_map"
    value       = "${module.compute_url.google_compute_url_map_name}"
} 

output "compute_url_map_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_url.google_compute_url_map_self_link}"
}

output "compute_url_map_map_id" {
    description = "The GCE assigned ID of the resource."
    value       = "${module.compute_url.google_compute_url_map_map_id}"
}

output "compute_url_map_custom_name" {
    description = "Name of google_compute_url_map"
    value       = "${module.compute_url.google_compute_url_map_custom_name}"
}

output "compute_url_map_custom_self_link" {
    description = "The URI of the created resource."
    value       = "${module.compute_url.google_compute_url_map_custom_self_link}"
}

output "compute_url_map_custom_map_id" {
    description = "The GCE assigned ID of the resource."
    value       = "${module.compute_url.google_compute_url_map_custom_map_id}"
}

