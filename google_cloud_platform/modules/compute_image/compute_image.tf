#---------------------------------------------------
# Create compute image
#---------------------------------------------------
resource "google_compute_image" "compute_image" {
    count           = "${length(var.raw_disk_source) > 0 ? 1 : 0}"    
                        
    name            = "${lower(var.name)}-image-${lower(var.environment)}"
    description     = "${var.description}"
    
    project         = "${var.project}"  

    family          = "${var.family}"
    source_disk     = "${var.source_disk}"

    raw_disk {
        source          = "${var.raw_disk_source}"
        container_type  = "${var.raw_disk_container_type}"
        sha1            = "${var.raw_disk_sha1}"
    }

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    labels {
        name            = "${lower(var.name)}-image-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
