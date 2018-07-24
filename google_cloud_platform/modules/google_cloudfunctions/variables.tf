variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "description" {
    description = "(Optional) Description of the function."
    default     = ""
}

variable "available_memory_mb" {
    description = "(Optional) Memory (in MB), available to the function. Default value is 256. Allowed values are: 128MB, 256MB, 512MB, 1024MB, and 2048MB."
    default     = "256"
}

variable "source_archive_bucket" {
    description = "(Required) The GCS bucket containing the zip archive which contains the function."
    default     = ""
}

variable "source_archive_object" {
    description = "(Required) The source archive object (file) in archive bucket."
    default     = ""
}

variable "timeout" {
    description = "(Optional) Timeout (in seconds) for the function. Default value is 60 seconds. Cannot be more than 540 seconds."
    default     = "60"
}

variable "entry_point" {
    description = "(Optional) Name of a JavaScript function that will be executed when the Google Cloud Function is triggered."
    default     = ""
}

variable "trigger_http" {
    description = "(Optional) Boolean variable. Any HTTP request (of a supported type) to the endpoint will trigger function execution. Supported HTTP request types are: POST, PUT, GET, DELETE, and OPTIONS. Endpoint is returned as https_trigger_url. Cannot be used with trigger_bucket and trigger_topic."
    default     = "true"
}

variable "trigger_bucket" {
    description = "(Optional) Google Cloud Storage bucket name. Every change in files in this bucket will trigger function execution. Cannot be used with trigger_http and trigger_topic."
    default     = ""
}

variable "trigger_topic" {
    description = "(Optional) Name of Pub/Sub topic. Every message published in this topic will trigger function execution with message contents passed as input data. Cannot be used with trigger_http and trigger_bucket."
    default     = ""
}

variable "retry_on_failure" {
    description = "(Optional) Whether the function should be retried on failure. This only applies to bucket and topic triggers, not HTTPS triggers."
    default     = ""
}

variable "project" {
    description = "Project of the function. If it is not provided, the provider project is used."
    default     = ""
}

variable "region" {                                             
    description = "Region of function. Currently can be only 'us-central1'. If it is not provided, the provider region is used."
    default     = "us-central1"
}
