output "self_link" {
    description = "self link for target pool"
    value       = "${google_compute_target_pool.compute_target_pool.self_link}"
}

output "name" {
    description = "Name of target pool"
    value       = "${google_compute_target_pool.compute_target_pool.name}"
}
