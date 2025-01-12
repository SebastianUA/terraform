#-----------------------------------------------------------
# container instances container instance
#-----------------------------------------------------------
output "container_instance_availability_domain" {
  description = "The availability domain to place the container instance."
  value       = element(concat(oci_container_instances_container_instance.container_instance.*.availability_domain, [""]), 0)
}

output "container_instance_compartment_id" {
  description = "The OCID of the compartment."
  value       = element(concat(oci_container_instances_container_instance.container_instance.*.compartment_id, [""]), 0)
}

output "container_instance_container_count" {
  description = "The number of containers on the container instance."
  value       = element(concat(oci_container_instances_container_instance.container_instance.*.container_count, [""]), 0)
}

output "container_instance_container_restart_policy" {
  description = "The container restart policy is applied for all containers in container instance."
  value       = element(concat(oci_container_instances_container_instance.container_instance.*.container_restart_policy, [""]), 0)
}

output "container_instance_containers" {
  description = "The containers on the container instance."
  value       = concat(oci_container_instances_container_instance.container_instance.*.containers, [""])
}

output "container_instance_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_container_instances_container_instance.container_instance.*.display_name, [""]), 0)
}

output "container_instance_dns_config" {
  description = "DNS settings for containers"
  value       = concat(oci_container_instances_container_instance.container_instance.*.dns_config, [""])
}

output "container_instance_id" {
  description = "An OCID that cannot be changed."
  value       = element(concat(oci_container_instances_container_instance.container_instance.*.id, [""]), 0)
}

output "container_instance_image_pull_secrets" {
  description = "The image pulls secrets so you can access private registry to pull container images."
  value       = concat(oci_container_instances_container_instance.container_instance.*.image_pull_secrets, [""])
}

output "container_instance_shape" {
  description = "The shape of the container instance. The shape determines the number of OCPUs, amount of memory, and other resources that are allocated to a container instance."
  value       = element(concat(oci_container_instances_container_instance.container_instance.*.shape, [""]), 0)
}

output "container_instance_state" {
  description = "The current state of the container instance."
  value       = element(concat(oci_container_instances_container_instance.container_instance.*.state, [""]), 0)
}
