#---------------------------------------------------
# Create google dataflow job
#---------------------------------------------------
resource "google_dataflow_job" "dataflow_job" {

    name                = "${lower(var.name)}-df-job-${lower(var.environment)}"    
    project             = "${var.project}"
    zone                = "${var.zone}"

    template_gcs_path   = "${var.template_gcs_path}"
    temp_gcs_location   = "${var.temp_gcs_location}"
    
    max_workers         = "${var.max_workers}"
    on_delete           = "${var.on_delete}"
    
    parameters          = ["${var.parameters}"]
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
