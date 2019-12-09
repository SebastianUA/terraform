output "elasticache_sg_ids" {
    description = ""
    value       = element(concat(aws_elasticache_security_group.elasticache_security_group.*.id, [""]), 0)
}

output "elasticache_subnet_group" {
    description = ""
    value       = element(concat(aws_elasticache_subnet_group.elasticache_subnet_group.*.id, [""]), 0)
}

output "elasticache_parameter_group_names" {
    description = ""
    value       = element(concat(aws_elasticache_parameter_group.elasticache_parameter_group.*.name, [""]), 0)
}

output "elasticache_cluster_ids" {  
    description = ""
    value       = element(concat(aws_elasticache_cluster.elasticache_cluster.*.id, [""]), 0)
}

output "elasticache_replication_group_ids" {
    description = ""
    value       = element(concat(aws_elasticache_replication_group.elasticache_replication_group.*.id, [""]), 0)
}

output "elasticache_replication_group_2_ids" {
    description = ""
    value       = element(concat(aws_elasticache_replication_group.elasticache_replication_group_2.*.id, [""]), 0)
}