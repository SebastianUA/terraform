#---------------------------------------------------
# Create compute forwarding rule
#---------------------------------------------------
resource "google_compute_forwarding_rule" "compute_forwarding_rule" {
    #count                   = "${length(var.target) > 0 ? 1 :0 }"    
                                                                                
    name                    = "${lower(var.name)}-fr-${lower(var.environment)}"
    description             = "${var.description}"

    project                 = "${var.project}"
    region                  = "${var.region}"
                    
    network                 = "${var.network}"
    subnetwork              = "${var.subnetwork}"
    ip_address              = "${var.ip_address}"
    ip_protocol             = "${var.ip_protocol}"
    ports                   = ["${var.ports}"]
    port_range              = "${var.port_range}"
    target                  = "${var.target}"
    backend_service         = "${var.backend_service}"
    load_balancing_scheme   = "${var.load_balancing_scheme}"
}
