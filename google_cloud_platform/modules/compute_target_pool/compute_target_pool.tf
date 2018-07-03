#---------------------------------------------------
# Create compute target pool
#---------------------------------------------------
resource "google_compute_target_pool" "compute_target_pool" {
    name                = "${lower(var.name)}-tp-${lower(var.environment)}"
    description         = "${var.description}"

    project             = "${var.project}"
    region              = "${var.region}"

    instances           = ["${var.instances}"]
    health_checks       = ["${var.health_checks}"]
                        
    backup_pool         = "${var.backup_pool}"
    failover_ratio      = "${var.failover_ratio}"
                    
    session_affinity    = "${var.session_affinity}"    
}

