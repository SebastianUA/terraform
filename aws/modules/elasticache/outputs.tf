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

output "elasticache_parameter_group_id" {
  description = "The ElastiCache parameter group name."
  value       = element(concat(aws_elasticache_parameter_group.elasticache_parameter_group.*.id, [""]), 0)
}

output "elasticache_parameter_group_arn" {
  description = "The AWS ARN associated with the parameter group."
  value       = element(concat(aws_elasticache_parameter_group.elasticache_parameter_group.*.arn, [""]), 0)
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

#---------------------------------------------------
# AWS elasticache global replication group
#---------------------------------------------------
output "elasticache_global_replication_group_id" {
  description = "The ID of the ElastiCache Global Replication Group."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.id, [""]), 0)
}

output "elasticache_global_replication_group_arn" {
  description = "The ARN of the ElastiCache Global Replication Group."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.arn, [""]), 0)
}

output "elasticache_global_replication_group_engine_version_actual" {
  description = "The full version number of the cache engine running on the members of this global replication group."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.engine_version_actual, [""]), 0)
}

output "elasticache_global_replication_group_at_rest_encryption_enabled" {
  description = "A flag that indicate whether the encryption at rest is enabled."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.at_rest_encryption_enabled, [""]), 0)
}

output "elasticache_global_replication_group_auth_token_enabled" {
  description = "A flag that indicate whether AuthToken (password) is enabled."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.auth_token_enabled, [""]), 0)
}

output "elasticache_global_replication_group_cache_node_type" {
  description = "The instance class used. See AWS documentation for information on supported node types and guidance on selecting node types."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.cache_node_type, [""]), 0)
}

output "elasticache_global_replication_group_cluster_enabled" {
  description = "Indicates whether the Global Datastore is cluster enabled."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.cluster_enabled, [""]), 0)
}

output "elasticache_global_replication_group_engine" {
  description = "The name of the cache engine to be used for the clusters in this global replication group."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.engine, [""]), 0)
}

output "elasticache_global_replication_group_global_replication_group_id" {
  description = "The full ID of the global replication group."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.global_replication_group_id, [""]), 0)
}

output "elasticache_global_replication_group_transit_encryption_enabled" {
  description = "A flag that indicates whether the encryption in transit is enabled."
  value       = element(concat(aws_elasticache_global_replication_group.elasticache_global_replication_group.*.transit_encryption_enabled, [""]), 0)
}

#---------------------------------------------------
# AWS elasticache user
#---------------------------------------------------
output "elasticache_user_arn" {
  description = "The ARN of the created ElastiCache User."
  value       = element(concat(aws_elasticache_user.elasticache_user.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS elasticache user group
#---------------------------------------------------
output "elasticache_user_group_id" {
  description = "The user group identifier."
  value       = element(concat(aws_elasticache_user_group.elasticache_user_group.*.id, [""]), 0)
}