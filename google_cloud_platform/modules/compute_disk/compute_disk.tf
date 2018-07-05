#---------------------------------------------------
# Create compute disk
#---------------------------------------------------
resource "google_compute_disk" "compute_disk" {
    name        = "${lower(var.name)}-disk-${lower(var.environment)}"
    description = "${var.description}"
    
    size        = "${var.size}"
    type        = "${var.type}"
    zone        = "${var.zone}"
    image       = "${var.image}"
    
    disk_encryption_key {
        raw_key = "${var.disk_encryption_key_raw_key}"
    }

    source_image_encryption_key {
        raw_key = "${var.source_image_encryption_key_raw_key}"
    }

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    labels {
        name            = "${lower(var.name)}-disk-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
