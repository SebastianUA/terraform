output "name" {
    description = "Name of compute instance group manager"
    value       = "${google_compute_instance_group_manager.compute_instance_group_manager.*.name}"
}

output "self_link" {
    description = "self_link"
    value       = "${google_compute_instance_group_manager.compute_instance_group_manager.*.self_link}"
}

output "instance_group" {
    description = "Instance group"
    value       = "${google_compute_instance_group_manager.compute_instance_group_manager.*.instance_group}"
}

output "gm_self_link_default" {
    description = "self_link"
    value       = "${google_compute_instance_group_manager.compute_instance_group_manager_default.*.self_link}"
}
