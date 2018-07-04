#---------------------------------------------------
# Create compute firewall for INGRESS
#---------------------------------------------------
resource "google_compute_firewall" "compute_firewall_all_ingress" {
    count                   = "${var.enable_all_ingress && upper(var.direction) == "INGRESS" ? 1 : 0}"

    name                    = "${lower(var.name)}-fw-${lower(var.environment)}-${lower(var.direction)}"
    description             = "${var.description}"     
                        
    project                 = "${var.project}"

    network                 = "${var.network}"
    
    priority                = "${var.priority}"
    source_ranges           = "${var.source_ranges}"
    source_tags             = ["${var.source_tags}"]
    target_tags             = ["${var.target_tags}"]
    direction               = "${var.direction}"
    #destination_ranges      = ["${var.destination_ranges}"]
    #source_service_accounts = ["${var.source_service_accounts}"]
    #target_service_accounts = ["${var.target_service_accounts}"] 
                            
    allow {
        protocol = "all"
    }
}

resource "google_compute_firewall" "compute_firewall_needed_ingress" {
    count                   = "${!var.enable_all_ingress && upper(var.direction) == "INGRESS" && var.allow_protocol !="" && length(var.allow_ports) > 0 ? 1 : 0}" 
    
    name                    = "${lower(var.name)}-fw-${lower(var.environment)}-${lower(var.direction)}"
    description             = "${var.description}"

    project                 = "${var.project}"

    network                 = "${var.network}"

    priority                = "${var.priority}"
    source_ranges           = "${var.source_ranges}"
    source_tags             = ["${var.source_tags}"]
    target_tags             = ["${var.target_tags}"]
    direction               = "${var.direction}"
    #destination_ranges      = ["${var.destination_ranges}"]
    #source_service_accounts = ["${var.source_service_accounts}"]
    #target_service_accounts = ["${var.target_service_accounts}"]

    allow {
        protocol = "${var.allow_protocol}"
        ports    = ["${var.allow_ports}"]
    }

}


#---------------------------------------------------
# Create compute firewall for EGRESS.
#---------------------------------------------------
resource "google_compute_firewall" "compute_firewall_all_egress" {
    count                   = "${var.enable_all_egress ? 1 : 0}"

    name                    = "${lower(var.name)}-fw-${lower(var.environment)}-egress"
    description             = "${var.description}"

    project                 = "${var.project}"

    network                 = "${var.network}"

    priority                = "${var.priority}"
    #target_tags             = ["${var.target_tags}"]
    direction               = "EGRESS"
    destination_ranges      = ["${var.destination_ranges}"]
    
    source_service_accounts = ["${var.source_service_accounts}"]
    target_service_accounts = ["${var.target_service_accounts}"]

    allow {
        protocol = "all"
    }
}

resource "google_compute_firewall" "compute_firewall_needed_egress" {
    count                   = "${!var.enable_all_egress ? 1 : 0}"

    name                    = "${lower(var.name)}-fw-${lower(var.environment)}-egress"
    description             = "${var.description}"

    project                 = "${var.project}"

    network                 = "${var.network}"

    priority                = "${var.priority}"
    #target_tags             = ["${var.target_tags}"]
    direction               = "EGRESS"
    destination_ranges      = ["${var.destination_ranges}"]

    source_service_accounts = ["${var.source_service_accounts}"]
    target_service_accounts = ["${var.target_service_accounts}"]

    allow {
        protocol = "${var.allow_protocol}"
        ports    = ["${var.allow_ports}"]
    }
}

