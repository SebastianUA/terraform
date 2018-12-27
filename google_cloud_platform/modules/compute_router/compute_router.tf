#---------------------------------------------------
# Create compute router
#---------------------------------------------------
resource "google_compute_router" "compute_router" {
    count       = "${var.enable_compute_router && length(var.bgp) ==0 ? 1 : 0}"
                    
    name        = "${lower(var.name)}-cr-router-${lower(var.environment)}"
    description = "${var.description}"
    project     = "${var.project}"
    region      = "${var.region}"
    
    network     = "${var.network}"
  
    bgp {
        asn               = "${var.bgp_asn}"
        advertise_mode    = "${var.bgp_advertise_mode}"
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

resource "google_compute_router" "compute_router_custom" {
    count       = "${var.enable_compute_router && length(var.bgp) >0 ? 1 : 0}"

    name        = "${lower(var.name)}-cr-router-${lower(var.environment)}"
    description = "${var.description}"
    project     = "${var.project}"
    region      = "${var.region}"

    network     = "${var.network}"

    bgp         = ["${var.bgp}"]

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

#---------------------------------------------------
# Create compute router interface
#---------------------------------------------------
resource "google_compute_router_interface" "compute_router_interface" {
    count       = "${var.enable_compute_router_interface ? 1 :0}"
                
    name        = "${lower(var.name)}-cr-interface-${lower(var.environment)}"
    router      = "${var.router}"
    project     = "${var.project}"
    region      = "${var.region}"
    ip_range    = "${var.ip_range}"
    vpn_tunnel  = "${var.vpn_tunnel}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create compute router peer
#---------------------------------------------------
resource "google_compute_router_peer" "compute_router_peer" {
    count                     = "${var.enable_compute_router_peer ? 1 :0}" 
                
    name                      = "${lower(var.name)}-cr-peer-${lower(var.environment)}"
    router                    = "${var.router}"
    interface                 = "${var.interface}"
    peer_ip_address           = "${var.peer_ip_address}"
    peer_asn                  = "${var.peer_asn}"
    
    project                   = "${var.project}"
    region                    = "${var.region}"
    advertised_route_priority = "${var.advertised_route_priority}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
