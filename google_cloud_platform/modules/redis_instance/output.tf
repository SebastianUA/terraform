output "redis_instance_name" {
    description = "Name of google redis instance"
    value       = "${google_redis_instance.redis_instance.*.name}"
}

output "redis_instance_host" {
    description = "Host"
    value       = "${google_redis_instance.redis_instance.*.host}"
}

output "redis_instance_port" {
    description = "Port"
    value       = "${google_redis_instance.redis_instance.*.port}"
}

output "redis_instance_current_location_id" {
    description = "current_location_id"
    value       = "${google_redis_instance.redis_instance.*.current_location_id}"
}

