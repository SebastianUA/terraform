#---------------------------------------------------
# AWS Batch job queue
#---------------------------------------------------
resource "aws_batch_job_queue" "batch_job_queue" {
    count                   = var.enable_batch_job_queue ? 1 : 0

    name                    = var.batch_job_queue_name != "" ? lower(var.batch_job_queue_name) : "${lower(var.name)}-batch-job-queue-${lower(var.environment)}"
    state                   = upper(var.batch_job_queue_state)
    priority                = var.batch_job_queue_priority
    compute_environments    = length(var.batch_job_queue_compute_environments) >0 && !var.enable_batch_compute_environment ? var.batch_job_queue_compute_environments : element(concat(aws_batch_compute_environment.batch_compute_environment.*.arn, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_batch_compute_environment.batch_compute_environment
    ]
}
