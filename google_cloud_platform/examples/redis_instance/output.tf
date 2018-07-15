output "redis_instance_name" {
    description = "Name of google redis instance"
    value       = "${module.redis_instance.redis_instance_name}"
}

output "redis_instance_host" {
    description = "Host"
    value       = "${module.redis_instance.redis_instance_host}"
}

output "redis_instance_port" {
    description = "Port"
    value       = "${module.redis_instance.redis_instance_port}"
}

output "redis_instance_current_location_id" {
    description = "current_location_id"
    value       = "${module.redis_instance.redis_instance_current_location_id}"
}

