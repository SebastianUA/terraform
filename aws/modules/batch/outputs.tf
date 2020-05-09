#---------------------------------------------------
# AWS Batch job definition
#---------------------------------------------------
output "batch_job_definition_id" {
    description = "Batch job definition ID"
    value       = element(concat(aws_batch_job_definition.batch_job_definition.*.id, [""]), 0)
}

output "batch_job_definition_arn" {
    description = "The Amazon Resource Name of the job definition."
    value       = element(concat(aws_batch_job_definition.batch_job_definition.*.arn, [""]), 0)
}

output "batch_job_definition_revision" {
    description = "The revision of the job definition."
    value       = element(concat(aws_batch_job_definition.batch_job_definition.*.revision, [""]), 0)
}

#---------------------------------------------------
# AWS Batch compute environment
#---------------------------------------------------
output "batch_compute_environment_id" {
    description = "Batch compute environment ID"
    value       = element(concat(aws_batch_compute_environment.batch_compute_environment.*.id, [""]), 0)
}

output "batch_compute_environment_arn" {
    description = "The Amazon Resource Name (ARN) of the compute environment."
    value       = element(concat(aws_batch_compute_environment.batch_compute_environment.*.arn, [""]), 0)
}

output "batch_compute_environment_ecs_cluster_arn" {
    description = "The Amazon Resource Name (ARN) of the underlying Amazon ECS cluster used by the compute environment."
    value       = element(concat(aws_batch_compute_environment.batch_compute_environment.*.ecs_cluster_arn, [""]), 0)
}

output "batch_compute_environment_status" {
    description = "The current status of the compute environment (for example, CREATING or VALID)."
    value       = element(concat(aws_batch_compute_environment.batch_compute_environment.*.status, [""]), 0)
}

output "batch_compute_environment_status_reason" {
    description = "A short, human-readable string to provide additional details about the current status of the compute environment."
    value       = element(concat(aws_batch_compute_environment.batch_compute_environment.*.status_reason, [""]), 0)
}

#---------------------------------------------------
# AWS Batch job queue
#---------------------------------------------------
output "batch_job_queue_id" {
    description = "Batch job queue ID"
    value       = element(concat(aws_batch_job_queue.batch_job_queue.*.id, [""]), 0)
}

output "batch_job_queue_arn" {
    description = "The Amazon Resource Name of the job queue."
    value       = element(concat(aws_batch_job_queue.batch_job_queue.*.arn, [""]), 0)
}
