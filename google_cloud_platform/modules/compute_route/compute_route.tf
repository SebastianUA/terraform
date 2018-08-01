#---------------------------------------------------
# Create compute route
#---------------------------------------------------
resource "google_compute_route" "compute_route" {
    count               = "${var.enable_compute_route ? 1 : 0}"
                    
    name                = "${lower(var.name)}-cr-route-${lower(var.environment)}"
    description         = "${var.description}"
    project             = "${var.project}"
    dest_range          = "${var.dest_range}"
    network             = "${var.network}"
    next_hop_ip         = "${var.next_hop_ip}"
    priority            = "${var.priority}"

    next_hop_gateway    = "${var.next_hop_gateway}"
    next_hop_instance   = "${var.next_hop_instance}"
    next_hop_vpn_tunnel = "${var.next_hop_vpn_tunnel}"
    
    next_hop_instance_zone = ""

    tags = ["${lower(var.name)}-cr-route-${lower(var.environment)}"]
    
    timeouts {
        create  = "${var.timeouts_create}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
