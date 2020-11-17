#---------------------------------------------------
# ASW athena database
#---------------------------------------------------
output "athena_database_id" {
  description = "The database name"
  value       = element(concat(aws_athena_database.athena_database.*.id, [""]), 0)
}

#---------------------------------------------------
# ASW athena named query
#---------------------------------------------------
output "athena_named_query_id" {
  description = "The unique ID of the query."
  value       = element(concat(aws_athena_named_query.athena_named_query.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS athena workgroup
#---------------------------------------------------
output "athena_workgroup_id" {
  description = "The workgroup name"
  value       = element(concat(aws_athena_workgroup.athena_workgroup.*.id, [""]), 0)
}

output "athena_workgroup_arn" {
  description = "Amazon Resource Name (ARN) of the workgroup"
  value       = element(concat(aws_athena_workgroup.athena_workgroup.*.arn, [""]), 0)
}
