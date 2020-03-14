output "google_dataflow_job_name" {
    description = "Name of google dataflow job"
    value       = "${google_dataflow_job.dataflow_job.name}"
}

output "google_dataflow_job_state" {
    description = "State"
    value       = "${google_dataflow_job.dataflow_job.state}"
}

output "google_dataflow_job_id" {
    description = "ID"
    value       = "${google_dataflow_job.dataflow_job.id}"
}
