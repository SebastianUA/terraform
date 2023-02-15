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
