output "compute_instance_ids" {
    description = "The server-assigned unique identifier of this instance."
    value       = "${module.compute_instance.compute_instance_ids}"
}

output "compute_instance_self_links" {
    description = "output the URI of the created resource."
    value       = "${module.compute_instance.compute_instance_self_links}"
}

output "compute_instance_cpu_platforms" {
    description = "The CPU platform used by this instance."
    value       = "${module.compute_instance.compute_instance_cpu_platforms}"
}

output "compute_instance_internal_ip_addresses" {
    description = "The internal ip address of the instance, either manually or dynamically assigned."
    value       = "${module.compute_instance.compute_instance_internal_ip_addresses}"
}

output "compute_instance_external_ip_addresses" {
    description = "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip (if you didn't provide one)."
    value       = "${module.compute_instance.compute_instance_external_ip_addresses}"
}
#-----
# instance with attached disk
#-----
output "compute_instance_with_attached_disk_ids" {
    description = "The server-assigned unique identifier of this instance."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_ids}"
}

output "compute_instance_with_attached_disk_self_links" {
    description = "output the URI of the created resource."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_self_links}"
}

output "compute_instance_with_attached_disk_cpu_platforms" {
    description = "The CPU platform used by this instance."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_cpu_platforms}"
}

output "compute_instance_with_attached_disk_internal_ip_addresses" {
    description = "The internal ip address of the instance, either manually or dynamically assigned."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_internal_ip_addresses}"
}

output "compute_instance_with_attached_disk_external_ip_addresses" {
    description = "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip (if you didn't provide one)."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_external_ip_addresses}"
}

