#---------------------------------------------------
# Create compute address
#---------------------------------------------------
resource "google_compute_address" "compute_address" {
    count           = "${var.enable_compute_address ? 1 : 0}"    
                
    name            = "${lower(var.name)}-address-${lower(var.environment)}"
    description     = "${var.description}"
    project         = "${var.project}"
    region          = "${var.region}"
                
    address_type    = "${var.address_type}"
    network_tier    = "${var.network_tier}"
    subnetwork      = "${var.subnetwork}"

    timeouts {
        create  = "${var.timeouts_create}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create compute global address
#---------------------------------------------------
resource "google_compute_global_address" "compute_global_address" {
    count           = "${var.enable_compute_global_address ? 1 : 0}"  

    name            = "${lower(var.name)}-gaddress-${lower(var.environment)}"
    description     = "${var.description}"
    project         = "${var.project}"

    ip_version      = "${var.ip_version}"

    timeouts {
        create  = "${var.timeouts_create}"
        delete  = "${var.timeouts_delete}"
    }
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
