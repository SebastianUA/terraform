output "container_cluster_zone_name" {
    description = "Name"
    value       = "${module.container_cluster.google_container_cluster_zone_name}"
}

output "container_cluster_zone_client_certificate" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_zone_client_certificate}"
}

output "container_cluster_zone_client_key" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_zone_client_key}"
}

output "container_cluster_zone_cluster_ca_certificate" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_zone_cluster_ca_certificate}"
}

output "container_cluster_zone_endpoint" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_zone_endpoint}"
}

output "container_cluster_zone_instance_group_urls" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_zone_instance_group_urls}"
}

output "container_cluster_zone_master_version" {
     description = ""
    value       = "${module.container_cluster.google_container_cluster_zone_master_version}"
}

output "container_cluster_region_name" {
    description = "Name"
    value       = "${module.container_cluster.google_container_cluster_region_name}"
}

output "container_cluster_region_client_certificate" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_region_client_certificate}"
}

output "container_cluster_region_client_key" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_region_client_key}"
}

output "container_cluster_region_cluster_ca_certificate" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_region_cluster_ca_certificate}"
}

output "container_cluster_region_endpoint" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_region_endpoint}"
}

output "container_cluster_region_instance_group_urls" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_region_instance_group_urls}"
}

output "container_cluster_region_master_version" {
    description = ""
    value       = "${module.container_cluster.google_container_cluster_region_master_version}"
}
#--------------------------------------------------------------------------------
# Container node pool
#--------------------------------------------------------------------------------
output "container_node_pool_zone_instance_group_urls" {
    description = "instance_group_urls"
    value       = "${module.container_cluster.google_container_node_pool_zone_instance_group_urls}"
}

output "container_node_pool_zone_name" {
    description = "Name"
    value       = "${module.container_cluster.google_container_node_pool_zone_name}"
}

output "container_node_pool_region_instance_group_urls" {
    description = "instance_group_urls"
    value       = "${module.container_cluster.google_container_node_pool_region_instance_group_urls}"
}

output "container_node_pool_region_name" {
    description = "Name"
    value       = "${module.container_cluster.google_container_node_pool_region_name}"
}

