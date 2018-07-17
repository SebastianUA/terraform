variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "project" {
    description = "(Optional) The project in which the resource belongs. If it is not provided, the provider project is used."
    default     = "terraform-2018"
}

variable "template_gcs_path" {
    description = "(Required) The GCS path to the Dataflow job template. Expect 'gs://<bucket>/<path>'. Ex: 'gs://my-bucket/templates/template_file'"
    default     = ""
}

variable "temp_gcs_location" {
    description = "(Required) A writeable location on GCS for the Dataflow job to dump its temporary data. Expect 'gs://<bucket>/<path>'. Ex: 'gs://my-bucket/tmp_dir'"
    default     = ""
}

variable "zone" {
    description = "(Optional) The zone in which the created job should run. If it is not provided, the provider zone is used."
    default     = "us-east1"
}

variable "max_workers" {
    description = "(Optional) The number of workers permitted to work on the job. More workers may improve processing speed at additional cost."
    default     = "1"
}

variable "on_delete" {
    description = "(Optional) One of 'drain' or 'cancel'. Specifies behavior of deletion during terraform destroy. See above note."
    default     = "cancel"
}

variable "parameters" {
    description = "(Optional) Key/Value pairs to be passed to the Dataflow job (as used in the template)."
    default     = []
}