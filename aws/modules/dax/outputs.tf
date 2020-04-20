#---------------------------------------------------
# AWS dax cluster
#---------------------------------------------------
output "dax_cluster_id" {
  description = "The ID of the DAX cluster"
  value       = element(concat(aws_dax_cluster.dax_cluster.*.id, [""]), 0)
}

output "dax_cluster_arn" {
  description = "The ARN of the DAX cluster"
  value       = element(concat(aws_dax_cluster.dax_cluster.*.arn, [""]), 0)
}

output "dax_cluster_nodes" {
  description = "List of node objects including id, address, port and availability_zone. Referenceable e.g. as aws_dax_cluster.test.nodes.0.address"
  value       = concat(aws_dax_cluster.dax_cluster.*.nodes, [""])
}

output "dax_cluster_configuration_endpoint" {
  description = "The configuration endpoint for this DAX cluster, consisting of a DNS name and a port number"
  value       = concat(aws_dax_cluster.dax_cluster.*.configuration_endpoint, [""])
}

output "dax_cluster_cluster_address" {
  description = "The DNS name of the DAX cluster without the port appended"
  value       = element(concat(aws_dax_cluster.dax_cluster.*.cluster_address, [""]), 0)
}

output "dax_cluster_port" {
  description = "The port used by the configuration endpoint"
  value       = element(concat(aws_dax_cluster.dax_cluster.*.port, [""]), 0)
}

#---------------------------------------------------
# AWS dax parameter group
#---------------------------------------------------
output "dax_parameter_group_id" {
  description = "The name of the parameter group."
  value       = element(concat(aws_dax_parameter_group.dax_parameter_group.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS dax subnet group
#---------------------------------------------------
output "dax_subnet_group_id" {
  description = "The name of the subnet group."
  value       = element(concat(aws_dax_subnet_group.dax_subnet_group.*.id, [""]), 0)
}

output "dax_subnet_group_vpc_id" {
  description = "VPC ID of the subnet group."
  value       = element(concat(aws_dax_subnet_group.dax_subnet_group.*.vpc_id, [""]), 0)
}
