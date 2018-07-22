#--------------------------------------------------------------------------------
# Container cluster
#--------------------------------------------------------------------------------
output "google_container_cluster_zone_name" {
    description = "Name"
    value       = "${google_container_cluster.container_cluster_zone.*.name}"
}

output "google_container_cluster_zone_client_certificate" {
    description = ""
    value       = "${google_container_cluster.container_cluster_zone.*.master_auth.0.client_certificate}"
}

output "google_container_cluster_zone_client_key" {
    description = ""
    value       = "${google_container_cluster.container_cluster_zone.*.master_auth.0.client_key}"
}

output "google_container_cluster_zone_cluster_ca_certificate" {
    description = ""
    value       = "${google_container_cluster.container_cluster_zone.*.master_auth.0.cluster_ca_certificate}"
}

output "google_container_cluster_zone_endpoint" {
    description = ""
    value       = "${google_container_cluster.container_cluster_zone.*.endpoint}"
}

output "google_container_cluster_zone_instance_group_urls" {
    description = ""
    value       = "${google_container_cluster.container_cluster_zone.*.instance_group_urls}"
}

output "google_container_cluster_zone_master_version" {
     description = ""
    value       = "${google_container_cluster.container_cluster_zone.*.master_version}"
}

output "google_container_cluster_region_name" {
    description = "Name"
    value       = "${google_container_cluster.container_cluster_region.*.name}"
}

output "google_container_cluster_region_client_certificate" {
    description = ""
    value       = "${google_container_cluster.container_cluster_region.*.master_auth.0.client_certificate}"
}

output "google_container_cluster_region_client_key" {
    description = ""
    value       = "${google_container_cluster.container_cluster_region.*.master_auth.0.client_key}"
}

output "google_container_cluster_region_cluster_ca_certificate" {
    description = ""
    value       = "${google_container_cluster.container_cluster_region.*.master_auth.0.cluster_ca_certificate}"
}

output "google_container_cluster_region_endpoint" {
    description = ""
    value       = "${google_container_cluster.container_cluster_region.*.endpoint}"
}

output "google_container_cluster_region_instance_group_urls" {
    description = ""
    value       = "${google_container_cluster.container_cluster_region.*.instance_group_urls}"
}

output "google_container_cluster_region_master_version" {
    description = ""
    value       = "${google_container_cluster.container_cluster_region.*.master_version}"
}

#--------------------------------------------------------------------------------
# Container node pool
#--------------------------------------------------------------------------------
output "google_container_node_pool_zone_instance_group_urls" {
    description = "instance_group_urls"
    value       = "${google_container_node_pool.container_node_pool_zone.*.instance_group_urls}"
}

output "google_container_node_pool_zone_name" {
    description = "Name"
    value       = "${google_container_node_pool.container_node_pool_zone.*.name}"
}

output "google_container_node_pool_region_instance_group_urls" {
    description = "instance_group_urls"
    value       = "${google_container_node_pool.container_node_pool_region.*.instance_group_urls}"
}

output "google_container_node_pool_region_name" {
    description = "Name"
    value       = "${google_container_node_pool.container_node_pool_region.*.name}"
}
