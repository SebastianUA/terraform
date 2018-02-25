output "elasticache_sg_ids" {
    description = ""
    value       = "${aws_elasticache_security_group.elasticache_sg.*.id}"
}

output "elasticache_subnet_group" {
    description = ""
    value       = "${aws_elasticache_subnet_group.elasticache_subnet_group.*.id}"
}

output "elasticache_parameter_group_names" {
    description = ""
    value       = "${aws_elasticache_parameter_group.elasticache_parameter_group.*.name}"
}

output "elasticache_cluster_ids" {  
    description = ""
    value       = "${aws_elasticache_cluster.elasticache_cluster.*.id}"
}

output "elasticache_replication_group_ids" {
    description = ""
    value       = "${aws_elasticache_replication_group.elasticache_replication_group.*.id}"
}

output "elasticache_replication_group_2_ids" {
    description = ""
    value       = "${aws_elasticache_replication_group.elasticache_replication_group_2.*.id}"
}
