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
