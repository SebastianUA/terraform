output "http_name" {
    description = "Name of http HC"
    value       = "${google_compute_health_check.compute_http_health_check.*.name}"
}

output "http_self_link" {
    description = "self_link of http HC"
    value       = "${google_compute_health_check.compute_http_health_check.*.self_link}"
}

output "https_name" {
    description = "Name of https HC"
    value       = "${google_compute_health_check.compute_https_health_check.*.name}"
}

output "https_self_link" {
    description = "self_link of https HC"
    value       = "${google_compute_health_check.compute_https_health_check.*.self_link}"
}

output "ssl_name" {
    description = "Name of ssl HC"
    value       = "${google_compute_health_check.compute_ssl_health_check.*.name}"
}

output "ssl_self_link" {
    description = "self_link of ssl HC"                     
    value       = "${google_compute_health_check.compute_ssl_health_check.*.self_link}"
}
