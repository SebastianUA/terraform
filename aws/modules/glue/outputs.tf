#---------------------------------------------------
# AWS Glue catalog database
#---------------------------------------------------
output "glue_catalog_database_arn" {
  description = "ARN for glue catalog database"
  value       = element(concat(aws_glue_catalog_database.glue_catalog_database.*.arn, [""]), 0)
}

output "glue_catalog_database_id" {
  description = "ID for glue catalog database"
  value       = element(concat(aws_glue_catalog_database.glue_catalog_database.*.id, [""]), 0)
}

output "glue_catalog_database_name" {
  description = "Name for glue catalog database"
  value       = element(concat(aws_glue_catalog_database.glue_catalog_database.*.name, [""]), 0)
}

#---------------------------------------------------
# AWS Glue catalog table
#---------------------------------------------------
output "glue_catalog_table_arn" {
  description = "ARN for glue catalog table"
  value       = element(concat(aws_glue_catalog_table.glue_catalog_table.*.arn, [""]), 0)
}

output "glue_catalog_table_id" {
  description = "ID for glue catalog table"
  value       = element(concat(aws_glue_catalog_table.glue_catalog_table.*.id, [""]), 0)
}

output "glue_catalog_table_name" {
  description = "Name for glue catalog table"
  value       = element(concat(aws_glue_catalog_table.glue_catalog_table.*.name, [""]), 0)
}

#---------------------------------------------------
# AWS Glue classifier
#---------------------------------------------------
output "glue_classifier_id" {
  description = "Name of the classifier"
  value       = element(concat(aws_glue_classifier.glue_classifier.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Glue connection
#---------------------------------------------------
output "glue_connection_id" {
  description = "Catalog ID and name of the connection"
  value       = element(concat(aws_glue_connection.glue_connection.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Glue crawler
#---------------------------------------------------
output "glue_crawler_id" {
  description = "Crawler name"
  value       = element(concat(aws_glue_crawler.glue_crawler.*.id, [""]), 0)
}

output "glue_crawler_arn" {
  description = "The ARN of the crawler"
  value       = element(concat(aws_glue_crawler.glue_crawler.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS glue security configuration
#---------------------------------------------------
output "glue_security_configuration_id" {
  description = "Glue security configuration name"
  value       = element(concat(aws_glue_security_configuration.glue_security_configuration.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Glue workflow
#---------------------------------------------------
output "glue_workflow_id" {
  description = "Glue workflow name"
  value       = element(concat(aws_glue_workflow.glue_workflow.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Glue job
#---------------------------------------------------
output "glue_job_id" {
  description = "Glue job name"
  value       = element(concat(aws_glue_job.glue_job.*.id, [""]), 0)
}

output "glue_job_arn" {
  description = "Amazon Resource Name (ARN) of Glue Job"
  value       = element(concat(aws_glue_job.glue_job.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Glue trigger
#---------------------------------------------------
output "glue_trigger_id" {
  description = "Trigger name"
  value       = element(concat(aws_glue_trigger.glue_trigger.*.id, [""]), 0)
}

output "glue_trigger_arn" {
  description = "Amazon Resource Name (ARN) of Glue Trigger"
  value       = element(concat(aws_glue_trigger.glue_trigger.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Glue data catalog encryption settings
#---------------------------------------------------
output "glue_data_catalog_encryption_settings_id" {
  description = "The ID of the Data Catalog to set the security configuration for."
  value       = element(concat(aws_glue_data_catalog_encryption_settings.glue_data_catalog_encryption_settings.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Glue dev endpoint
#---------------------------------------------------
output "glue_dev_endpoint_id" {
  description = "The ID of the endpoint."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.id, [""]), 0)
}

output "glue_dev_endpoint_arn" {
  description = "The ARN of the endpoint."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.arn, [""]), 0)
}

output "glue_dev_endpoint_name" {
  description = "The name of the new endpoint."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.name, [""]), 0)
}

output "glue_dev_endpoint_private_address" {
  description = "A private IP address to access the endpoint within a VPC, if this endpoint is created within one."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.private_address, [""]), 0)
}

output "glue_dev_endpoint_public_address" {
  description = "The public IP address used by this endpoint. The PublicAddress field is present only when you create a non-VPC endpoint."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.public_address, [""]), 0)
}

output "glue_dev_endpoint_yarn_endpoint_address" {
  description = "The YARN endpoint address used by this endpoint."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.yarn_endpoint_address, [""]), 0)
}

output "glue_dev_endpoint_zeppelin_remote_spark_interpreter_port" {
  description = "The Apache Zeppelin port for the remote Apache Spark interpreter."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.zeppelin_remote_spark_interpreter_port, [""]), 0)
}

output "glue_dev_endpoint_availability_zone" {
  description = "The AWS availability zone where this endpoint is located."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.availability_zone, [""]), 0)
}

output "glue_dev_endpoint_vpc_id" {
  description = "The ID of the VPC used by this endpoint."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.vpc_id, [""]), 0)
}

output "glue_dev_endpoint_status" {
  description = "The current status of this endpoint."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.status, [""]), 0)
}

output "glue_dev_endpoint_failure_reason" {
  description = "The reason for a current failure in this endpoint."
  value       = element(concat(aws_glue_dev_endpoint.glue_dev_endpoint.*.failure_reason, [""]), 0)
}

#---------------------------------------------------
# AWS Glue ml transform
#---------------------------------------------------
output "glue_ml_transform_id" {
  description = "Glue ML Transform ID."
  value       = element(concat(aws_glue_ml_transform.glue_ml_transform.*.id, [""]), 0)
}

output "glue_ml_transform_arn" {
  description = "Amazon Resource Name (ARN) of Glue ML Transform."
  value       = element(concat(aws_glue_ml_transform.glue_ml_transform.*.arn, [""]), 0)
}

output "glue_ml_transform_label_count" {
  description = "The number of labels available for this transform."
  value       = element(concat(aws_glue_ml_transform.glue_ml_transform.*.label_count, [""]), 0)
}

output "glue_ml_transform_schema" {
  description = "The object that represents the schema that this transform accepts. see Schema."
  value       = element(concat(aws_glue_ml_transform.glue_ml_transform.*.schema, [""]), 0)
}

#---------------------------------------------------
# AWS Glue partition
#---------------------------------------------------
output "glue_partition_id" {
  description = "partition id."
  value       = element(concat(aws_glue_partition.glue_partition.*.id, [""]), 0)
}

output "glue_partition_creation_time" {
  description = "The time at which the partition was created."
  value       = element(concat(aws_glue_partition.glue_partition.*.creation_time, [""]), 0)
}

output "glue_partition_last_analyzed_time" {
  description = "The last time at which column statistics were computed for this partition."
  value       = element(concat(aws_glue_partition.glue_partition.*.last_analyzed_time, [""]), 0)
}

output "glue_partition_last_accessed_time" {
  description = "The last time at which the partition was accessed."
  value       = element(concat(aws_glue_partition.glue_partition.*.last_accessed_time, [""]), 0)
}

#---------------------------------------------------
# AWS Glue registry
#---------------------------------------------------
output "glue_registry_id" {
  description = "Amazon Resource Name (ARN) of Glue Registry."
  value       = element(concat(aws_glue_registry.glue_registry.*.id, [""]), 0)
}

output "glue_registry_arn" {
  description = "Amazon Resource Name (ARN) of Glue Registry."
  value       = element(concat(aws_glue_registry.glue_registry.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Glue resource policy
#---------------------------------------------------
output "glue_resource_policy_id" {
  description = "The ID of Glue resource policy."
  value       = element(concat(aws_glue_resource_policy.glue_resource_policy.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Glue schema
#---------------------------------------------------
output "glue_schema_id" {
  description = "Amazon Resource Name (ARN) of the schema."
  value       = element(concat(aws_glue_schema.glue_schema.*.id, [""]), 0)
}

output "glue_schema_arn" {
  description = "Amazon Resource Name (ARN) of the schema."
  value       = element(concat(aws_glue_schema.glue_schema.*.arn, [""]), 0)
}

output "glue_schema_registry_name" {
  description = "The name of the Glue Registry."
  value       = element(concat(aws_glue_schema.glue_schema.*.registry_name, [""]), 0)
}

output "glue_schema_latest_schema_version" {
  description = "The latest version of the schema associated with the returned schema definition."
  value       = element(concat(aws_glue_schema.glue_schema.*.latest_schema_version, [""]), 0)
}

output "glue_schema_next_schema_version" {
  description = "The next version of the schema associated with the returned schema definition."
  value       = element(concat(aws_glue_schema.glue_schema.*.next_schema_version, [""]), 0)
}

output "glue_schema_schema_checkpoint" {
  description = "The version number of the checkpoint (the last time the compatibility mode was changed)."
  value       = element(concat(aws_glue_schema.glue_schema.*.schema_checkpoint, [""]), 0)
}

#---------------------------------------------------
# AWS Glue user defined function
#---------------------------------------------------
output "glue_user_defined_function_id" {
  description = "The id of the Glue User Defined Function."
  value       = element(concat(aws_glue_user_defined_function.glue_user_defined_function.*.id, [""]), 0)
}

output "glue_user_defined_function_arn" {
  description = "The ARN of the Glue User Defined Function."
  value       = element(concat(aws_glue_user_defined_function.glue_user_defined_function.*.arn, [""]), 0)
}

output "glue_user_defined_function_create_time" {
  description = "The time at which the function was created."
  value       = element(concat(aws_glue_user_defined_function.glue_user_defined_function.*.create_time, [""]), 0)
}
