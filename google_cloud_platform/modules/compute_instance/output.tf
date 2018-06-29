########################################################################
# Compute instance 
########################################################################
output "compute_instance_ids" {
    description = "The server-assigned unique identifier of this instance."
    value       = "${google_compute_instance.compute_instance.*.instance_id}"
}

output "compute_instance_metadata_fingerprints" {
    description = "The unique fingerprint of the metadata."
    value       = "${google_compute_instance.compute_instance.*.metadata_fingerprint}"
}

output "compute_instance_self_links" {
    description = "output the URI of the created resource."                                                                                                                
    value       = "${google_compute_instance.compute_instance.*.self_link}"
}

output "compute_instance_tags_fingerprints" {
    description = "The unique fingerprint of the tags."
    value       = "${google_compute_instance.compute_instance.*.tags_fingerprint}"
}

output "compute_instance_label_fingerprints" {
    description = "The unique fingerprint of the labels."
    value       = "${google_compute_instance.compute_instance.*.label_fingerprint}"
}

output "compute_instance_cpu_platforms" {
    description = "The CPU platform used by this instance."
    value       = "${google_compute_instance.compute_instance.*.cpu_platform}"
}

output "compute_instance_internal_ip_addresses" {
    description = "The internal ip address of the instance, either manually or dynamically assigned."
    value       = "${google_compute_instance.compute_instance.*.network_interface.0.address}"
}

output "compute_instance_external_ip_addresses" {
    description = "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip (if you didn't provide one)."
    value       = "${google_compute_instance.compute_instance.*.network_interface.0.access_config.0.assigned_nat_ip}"
}

########################################################################
# Compute instance with attached disk
########################################################################
output "compute_instance_with_attached_disk_ids" {
    description = "The server-assigned unique identifier of this instance."
    value       = "${google_compute_instance.compute_instance_with_attached_disk.*.instance_id}"
}

output "compute_instance_with_attached_disk_metadata_fingerprints" {
    description = "The unique fingerprint of the metadata."
    value       = "${google_compute_instance.compute_instance_with_attached_disk.*.metadata_fingerprint}"
}

output "compute_instance_with_attached_disk_self_links" {
    description = "output the URI of the created resource."
    value       = "${google_compute_instance.compute_instance_with_attached_disk.*.self_link}"
}

output "compute_instance_with_attached_disk_tags_fingerprints" {
    description = "The unique fingerprint of the tags."
    value       = "${google_compute_instance.compute_instance_with_attached_disk.*.tags_fingerprint}"
}

output "compute_instance_with_attached_disk_label_fingerprints" {
    description = "The unique fingerprint of the labels."
    value       = "${google_compute_instance.compute_instance_with_attached_disk.*.label_fingerprint}"
}

output "compute_instance_with_attached_disk_cpu_platforms" {
    description = "The CPU platform used by this instance."
    value       = "${google_compute_instance.compute_instance_with_attached_disk.*.cpu_platform}"
}

output "compute_instance_with_attached_disk_internal_ip_addresses" {
    description = "The internal ip address of the instance, either manually or dynamically assigned."
    value       = "${google_compute_instance.compute_instance_with_attached_disk.*.network_interface.0.address}"
}

output "compute_instance_with_attached_disk_external_ip_addresses" {
    description = "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip (if you didn't provide one)."
    value       = "${google_compute_instance.compute_instance_with_attached_disk.*.network_interface.0.access_config.0.assigned_nat_ip}"
}

