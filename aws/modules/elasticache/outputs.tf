#-----------------------------------------------------------
# AWS elasticache security group
#-----------------------------------------------------------
output "elasticache_sg_id" {
  description = "Get ID of elasticache sg"
  value       = element(concat(aws_elasticache_security_group.elasticache_security_group.*.id, [""]), 0)
}

#-----------------------------------------------------------
# AWS elasticache subnet group
#-----------------------------------------------------------
output "elasticache_subnet_group_id" {
  description = "Get subnet group ID of elasticache"
  value       = element(concat(aws_elasticache_subnet_group.elasticache_subnet_group.*.id, [""]), 0)
}

#-----------------------------------------------------------
# parameters_for_parameter_group
#-----------------------------------------------------------
output "elasticache_parameter_group_name" {
  description = "Get name of elasticache parameter group"
  value       = element(concat(aws_elasticache_parameter_group.elasticache_parameter_group.*.name, [""]), 0)
}

#---------------------------------------------------
# Create AWS elasticache cluster
#---------------------------------------------------
output "elasticache_cluster_id" {
  description = "Get elasticache cluster id"
  value       = element(concat(aws_elasticache_cluster.elasticache_cluster.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS elasticache replication group
#---------------------------------------------------
output "elasticache_replication_group_id" {
  description = "Get elasticache replication group id"
  value       = element(concat(aws_elasticache_replication_group.elasticache_replication_group.*.id, [""]), 0)
}
