output "google_compute_url_map_name" {
    description = "Name of google_compute_url_map"
    value       = "${google_compute_url_map.compute_url_map.*.name}"
}

output "google_compute_url_map_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_url_map.compute_url_map.*.self_link}"
}

output "google_compute_url_map_map_id" {
    description = "The GCE assigned ID of the resource."
    value       = "${google_compute_url_map.compute_url_map.*.map_id}"
}

output "google_compute_url_map_custom_name" {
    description = "Name of google_compute_url_map"
    value       = "${google_compute_url_map.compute_url_map_custom.*.name}"
}

output "google_compute_url_map_custom_self_link" {
    description = "The URI of the created resource."
    value       = "${google_compute_url_map.compute_url_map_custom.*.self_link}"
}

output "google_compute_url_map_custom_map_id" {
    description = "The GCE assigned ID of the resource."
    value       = "${google_compute_url_map.compute_url_map_custom.*.map_id}"
}

