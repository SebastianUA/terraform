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

#---------------------------------------------------
# AWS DB proxy default target group
#---------------------------------------------------
output "db_proxy_endpoint_id" {
  description = "The name of the proxy and proxy endpoint separated by /, DB-PROXY-NAME/DB-PROXY-ENDPOINT-NAME."
  value       = element(concat(aws_db_proxy_endpoint.db_proxy_endpoint.*.id, [""]), 0)
}

output "db_proxy_endpoint_arn" {
  description = "The Amazon Resource Name (ARN) for the proxy endpoint."
  value       = element(concat(aws_db_proxy_endpoint.db_proxy_endpoint.*.arn, [""]), 0)
}

output "db_proxy_endpoint_endpoint" {
  description = "The endpoint that you can use to connect to the proxy. You include the endpoint value in the connection string for a database client application."
  value       = element(concat(aws_db_proxy_endpoint.db_proxy_endpoint.*.endpoint, [""]), 0)
}

output "db_proxy_endpoint_is_default" {
  description = "Indicates whether this endpoint is the default endpoint for the associated DB proxy."
  value       = element(concat(aws_db_proxy_endpoint.db_proxy_endpoint.*.is_default, [""]), 0)
}

output "db_proxy_endpoint_vpc_id" {
  description = "The VPC ID of the DB proxy endpoint."
  value       = element(concat(aws_db_proxy_endpoint.db_proxy_endpoint.*.vpc_id, [""]), 0)
}
