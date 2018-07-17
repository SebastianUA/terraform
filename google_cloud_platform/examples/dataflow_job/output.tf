output "dataflow_job_name" {
    description = "Name of google dataflow job"
    value       = "${module.dataflow_job.google_dataflow_job_name}"
}

output "dataflow_job_state" {
    description = "State"
    value       = "${module.dataflow_job.google_dataflow_job_state}"
}

output "dataflow_job_id" {
    description = "ID"
    value       = "${module.dataflow_job.google_dataflow_job_id}"
}

