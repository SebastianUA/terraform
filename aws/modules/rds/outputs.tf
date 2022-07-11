#---------------------------------------------------
# AWS RDS cluster
#---------------------------------------------------
output "rds_cluster_reader_endpoint" {
  description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas"
  value       = element(concat(aws_rds_cluster.rds_cluster.*.reader_endpoint, [""]), 0)
}

output "rds_cluster_endpoint" {
  description = "The DNS address of the RDS instance"
  value       = element(concat(aws_rds_cluster.rds_cluster.*.endpoint, [""]), 0)
}

output "rds_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = element(concat(aws_rds_cluster.rds_cluster.*.arn, [""]), 0)
}

output "rds_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = element(concat(aws_rds_cluster.rds_cluster.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS RDS global cluster
#---------------------------------------------------
output "rds_global_cluster_arn" {
  description = "RDS Global Cluster Amazon Resource Name (ARN)"
  value       = element(concat(aws_rds_global_cluster.rds_global_cluster.*.arn, [""]), 0)
}

output "rds_global_cluster_global_cluster_resource_id" {
  description = "AWS Region-unique, immutable identifier for the global database cluster. This identifier is found in AWS CloudTrail log entries whenever the AWS KMS key for the DB cluster is accessed"
  value       = element(concat(aws_rds_global_cluster.rds_global_cluster.*.global_cluster_resource_id, [""]), 0)
}

output "rds_global_cluster_id" {
  description = "RDS Global Cluster identifier"
  value       = element(concat(aws_rds_global_cluster.rds_global_cluster.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS RDS cluster endpoint
#---------------------------------------------------
output "rds_cluster_endpoint_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = element(concat(aws_rds_cluster_endpoint.rds_cluster_endpoint.*.arn, [""]), 0)
}

output "rds_cluster_endpoint_id" {
  description = "The RDS Cluster Endpoint Identifier"
  value       = element(concat(aws_rds_cluster_endpoint.rds_cluster_endpoint.*.id, [""]), 0)
}

output "rds_cluster_endpoint_endpoint" {
  description = "A custom endpoint for the Aurora cluster"
  value       = element(concat(aws_rds_cluster_endpoint.rds_cluster_endpoint.*.endpoint, [""]), 0)
}

#---------------------------------------------------
# AWS RDS cluster parameter group
#---------------------------------------------------
output "rds_cluster_parameter_group_arn" {
  description = "The ARN of the db cluster parameter group."
  value       = element(concat(aws_rds_cluster_parameter_group.rds_cluster_parameter_group.*.arn, [""]), 0)
}

output "rds_cluster_parameter_group_id" {
  description = "The db cluster parameter group name."
  value       = element(concat(aws_rds_cluster_parameter_group.rds_cluster_parameter_group.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS DB instance
#---------------------------------------------------
output "db_instance_id" {
  description = ""
  value       = element(concat(aws_db_instance.db_instance.*.id, [""]), 0)
}

output "db_instance_arn" {
  description = ""
  value       = element(concat(aws_db_instance.db_instance.*.arn, [""]), 0)
}

output "db_instance_addresses" {
  description = ""
  value       = element(concat(aws_db_instance.db_instance.*.address, [""]), 0)
}

output "db_instance_hosted_zone_id" {
  description = "Get DB instance hosted zone ID"
  value       = element(concat(aws_db_instance.db_instance.*.hosted_zone_id, [""]), 0)
}

output "db_instance_endpoint" {
  description = "Get DB instance hosted zone ID"
  value       = element(concat(aws_db_instance.db_instance.*.endpoint, [""]), 0)
}



#---------------------------------------------------
# AWS DB subnet group
#---------------------------------------------------
output "aws_db_subnet_group_id" {
  description = "Get DB subnet group ID"
  value       = element(concat(aws_db_subnet_group.db_subnet_group.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS DB parameter group
#---------------------------------------------------
output "db_parameter_group_id" {
  description = "Get DB parameter group ID"
  value       = element(concat(aws_db_parameter_group.db_parameter_group.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS DB cluster snapshot
#---------------------------------------------------
output "db_cluster_snapshot_id" {
  description = "Get DB cluster snapshot ID"
  value       = element(concat(aws_db_cluster_snapshot.db_cluster_snapshot.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS DB event subscription
#---------------------------------------------------
output "db_event_subscription_id" {
  description = "The name of the RDS event notification subscription"
  value       = element(concat(aws_db_event_subscription.db_event_subscription.*.id, [""]), 0)
}

output "db_event_subscription_arn" {
  description = "The Amazon Resource Name of the RDS event notification subscription"
  value       = element(concat(aws_db_event_subscription.db_event_subscription.*.arn, [""]), 0)
}

output "db_event_subscription_customer_aws_id" {
  description = "The AWS customer account associated with the RDS event notification subscription"
  value       = element(concat(aws_db_event_subscription.db_event_subscription.*.customer_aws_id, [""]), 0)
}

#---------------------------------------------------
# AWS DB snapshot
#---------------------------------------------------
output "db_snapshot_id" {
  description = "Get DB snapshot ID"
  value       = element(concat(aws_db_snapshot.db_snapshot.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS DB security group
#---------------------------------------------------
output "db_security_group_id" {
  description = "The db security group ID."
  value       = element(concat(aws_db_security_group.db_security_group.*.id, [""]), 0)
}

output "db_security_group_arn" {
  description = "The arn of the DB security group."
  value       = element(concat(aws_db_security_group.db_security_group.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS DB instance role association
#---------------------------------------------------
output "db_instance_role_association_id" {
  description = ""
  value       = element(concat(aws_db_instance_role_association.db_instance_role_association.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS DB option group
#---------------------------------------------------
output "db_option_group_id" {
  description = "The db option group name."
  value       = element(concat(aws_db_option_group.db_option_group.*.id, [""]), 0)
}

output "db_option_group_arn" {
  description = "The ARN of the db option group."
  value       = element(concat(aws_db_option_group.db_option_group.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS DB proxy
#---------------------------------------------------
output "db_proxy_id" {
  description = "The Amazon Resource Name (ARN) for the proxy."
  value       = element(concat(aws_db_proxy.db_proxy.*.id, [""]), 0)
}

output "db_proxy_arn" {
  description = "The Amazon Resource Name (ARN) for the proxy."
  value       = element(concat(aws_db_proxy.db_proxy.*.arn, [""]), 0)
}

output "db_proxy_endpoint" {
  description = "The endpoint that you can use to connect to the proxy. You include the endpoint value in the connection string for a database client application."
  value       = element(concat(aws_db_proxy.db_proxy.*.endpoint, [""]), 0)
}

#---------------------------------------------------
# AWS DB proxy default target group
#---------------------------------------------------
output "db_proxy_default_target_group_id" {
  description = "Name of the RDS DB Proxy."
  value       = element(concat(aws_db_proxy_default_target_group.db_proxy_default_target_group.*.id, [""]), 0)
}

output "db_proxy_default_target_group_arn" {
  description = "The Amazon Resource Name (ARN) representing the target group."
  value       = element(concat(aws_db_proxy_default_target_group.db_proxy_default_target_group.*.arn, [""]), 0)
}

output "db_proxy_default_target_group_name" {
  description = "The name of the default target group."
  value       = element(concat(aws_db_proxy_default_target_group.db_proxy_default_target_group.*.name, [""]), 0)
}

#---------------------------------------------------
# AWS DB proxy target
#---------------------------------------------------
output "db_proxy_target_id" {
  description = "Identifier of db_proxy_name, target_group_name, target type (e.g. RDS_INSTANCE or TRACKED_CLUSTER), and resource identifier separated by forward slashes (/)."
  value       = element(concat(aws_db_proxy_target.db_proxy_target.*.id, [""]), 0)
}

output "db_proxy_target_endpoint" {
  description = "Hostname for the target RDS DB Instance. Only returned for RDS_INSTANCE type."
  value       = element(concat(aws_db_proxy_target.db_proxy_target.*.endpoint, [""]), 0)
}

output "db_proxy_target_port" {
  description = "Port for the target RDS DB Instance or Aurora DB Cluster."
  value       = element(concat(aws_db_proxy_target.db_proxy_target.*.port, [""]), 0)
}

output "db_proxy_target_rds_resource_id" {
  description = "Identifier representing the DB Instance or DB Cluster target."
  value       = element(concat(aws_db_proxy_target.db_proxy_target.*.rds_resource_id, [""]), 0)
}

output "db_proxy_target_target_arn" {
  description = "Amazon Resource Name (ARN) for the DB instance or DB cluster. Currently not returned by the RDS API."
  value       = element(concat(aws_db_proxy_target.db_proxy_target.*.target_arn, [""]), 0)
}

output "db_proxy_target_tracked_cluster_id" {
  description = "DB Cluster identifier for the DB Instance target. Not returned unless manually importing an RDS_INSTANCE target that is part of a DB Cluster."
  value       = element(concat(aws_db_proxy_target.db_proxy_target.*.tracked_cluster_id, [""]), 0)
}

output "db_proxy_target_type" {
  description = "Type of target. e.g. RDS_INSTANCE or TRACKED_CLUSTER"
  value       = element(concat(aws_db_proxy_target.db_proxy_target.*.type, [""]), 0)
}

