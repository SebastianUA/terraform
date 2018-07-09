output "http_name" {
    description = "Name of http HC"
    value       = "${module.compute_health_check.http_name}"
}

output "http_self_link" {
    description = "self_link of http HC"
    value       = "${module.compute_health_check.http_self_link}"
}

output "https_name" {
    description = "Name of https HC"
    value       = "${module.compute_health_check.https_name}"
}

output "https_self_link" {
    description = "self_link of https HC"
    value       = "${module.compute_health_check.https_self_link}"
}

output "ssl_name" {
    description = "Name of ssl HC"
    value       = "${module.compute_health_check.ssl_name}"
}

output "ssl_self_link" {
    description = "self_link of ssl HC"
    value       = "${module.compute_health_check.ssl_self_link}"
}
