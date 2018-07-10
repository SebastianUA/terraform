#---------------------------------------------------
# Create compute target pool
#---------------------------------------------------
resource "google_compute_target_pool" "compute_target_pool" {
    count               = "${!var.use_compute_target_pool_default ? 1 : 0}"

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

resource "google_compute_target_pool" "compute_target_pool_default" {
    count               = "${var.use_compute_target_pool_default ? 1 : 0}"    

    name                = "${lower(var.name)}-tp-${lower(var.environment)}"
    description         = "${var.description}"

    project             = "${var.project}"
    region              = "${var.region}"

    health_checks       = ["${var.health_checks}"]

    backup_pool         = "${var.backup_pool}"
    failover_ratio      = "${var.failover_ratio}"

    session_affinity    = "${var.session_affinity}"
}

