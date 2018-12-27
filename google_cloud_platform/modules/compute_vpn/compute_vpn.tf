#---------------------------------------------------
# Create compute vpn gateway
#---------------------------------------------------
resource "google_compute_vpn_gateway" "compute_vpn_gateway" {
    count       = "${var.enable_compute_vpn_gateway ? 1 : 0}"
            
    name        = "${lower(var.name)}-cv-gateway-${lower(var.environment)}"
    description = "${var.description}"
    project     = "${var.project}"
    network     = "${var.network}"
    region      = "${var.region}"

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
# Create compute vpn tunnel
#---------------------------------------------------
resource "google_compute_vpn_tunnel" "compute_vpn_tunnel" {
    count       = "${var.enable_compute_vpn_tunnel ? 1 : 0}"    

    name                    = "${lower(var.name)}-cv-tunnel-${lower(var.environment)}"
    description             = "${var.description}"
    project                 = "${var.project}"
    region                  = "${var.region}"
    peer_ip                 = "${var.peer_ip}"
    shared_secret           = "${var.shared_secret}"
    target_vpn_gateway      = "${var.target_vpn_gateway}"

    local_traffic_selector  = ["${var.local_traffic_selector}"]
    remote_traffic_selector = ["${var.remote_traffic_selector}"]
    ike_version             = "${var.ike_version}"
    router                  = "${var.router}"

    labels {
        name            = "${lower(var.name)}-cv-tunnel-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }               

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
