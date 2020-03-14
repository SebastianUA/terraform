output "self_link" {
    description = "self link for target pool"
    value       = "${google_compute_target_pool.compute_target_pool.*.self_link}"
}

output "name" {
    description = "Name of target pool"
    value       = "${google_compute_target_pool.compute_target_pool.*.name}"
}

output "default_pool_name" {
    description = "Name for default target pool"
    value       = "${google_compute_target_pool.compute_target_pool_default.*.name}"
}

output "default_pool_self_link" {
    description = "self_link for default target pool"
    value       = "${google_compute_target_pool.compute_target_pool_default.*.self_link}"
}
