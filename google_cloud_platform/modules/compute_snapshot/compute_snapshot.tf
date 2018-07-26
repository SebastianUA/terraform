#---------------------------------------------------
# Create compute snapshot
#---------------------------------------------------
resource "google_compute_snapshot" "compute_snapshot" {
    count                           = "${var.source_disk !="" ? 1 : 0}"  
                
    name                            = "${lower(var.name)}-snapshot-${lower(var.environment)}"
    source_disk                     = "${var.source_disk}"
    zone                            = "${var.zone}"
                
    source_disk_encryption_key_raw  = "${var.source_disk_encryption_key_raw}"
    source_disk_encryption_key_raw  = "${var.source_disk_encryption_key_raw}"

    labels {
        name            = "${lower(var.name)}-cs-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
