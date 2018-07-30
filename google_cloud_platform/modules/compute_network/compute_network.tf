#---------------------------------------------------
# Create compute network
#---------------------------------------------------
resource "google_compute_network" "compute_network" {
    count                   = "${var.enable_compute_network ? 1 : 0}"    

    name                    = "${lower(var.name)}-cn-network-${lower(var.environment)}"
    description             = "${var.description}" 
    project                 = "${var.project}"

    auto_create_subnetworks = "${var.auto_create_subnetworks}"
    routing_mode            = "${var.routing_mode}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
#---------------------------------------------------
# Create compute network peering
#---------------------------------------------------
resource "google_compute_network_peering" "compute_network_peering" {
    count               = "${var.enable_compute_network_peering ? 1 : 0}" 

    name                = "${lower(var.name)}-cn-peering-${lower(var.environment)}"
    network             = "${var.network}"
    peer_network        = "${var.peer_network}"
    auto_create_routes  = "${var.auto_create_routes}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
#---------------------------------------------------
# Create compute subnetwork
#---------------------------------------------------
resource "google_compute_subnetwork" "compute_subnetwork" {
    count                       = "${var.enable_compute_subnetwork && !var.enable_secondary_ip_range ? 1 :0}"
                
    name                        = "${lower(var.name)}-subnetwork-${lower(var.environment)}"
    description                 = "${var.description}"
    project                     = "${var.project}"
    ip_cidr_range               = "${var.ip_cidr_range}"
    region                      = "${var.region}"
    network                     = "${var.network}"
                        
    enable_flow_logs            = "${var.enable_flow_logs}"
    private_ip_google_access    = "${var.private_ip_google_access}"    

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

resource "google_compute_subnetwork" "compute_subnetwork_with_secondary_ip_range" {
    count                       = "${var.enable_compute_subnetwork && var.enable_secondary_ip_range ? 1 :0}"

    name                        = "${lower(var.name)}-subnetwork-${lower(var.environment)}"
    description                 = "${var.description}"
    project                     = "${var.project}"
    ip_cidr_range               = "${var.ip_cidr_range}"
    region                      = "${var.region}"
    network                     = "${var.network}"

    enable_flow_logs            = "${var.enable_flow_logs}"
    private_ip_google_access    = "${var.private_ip_google_access}"

    secondary_ip_range {
        range_name    = "${var.secondary_ip_range_name}"
        ip_cidr_range = "${var.secondary_ip_range_cidr}"
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

#---------------------------------------------------
# Create google compute subnetwork iam policy
#---------------------------------------------------
data "google_iam_policy" "iam_policy" {
    binding {
        role = "${var.role}"
        members = ["${var.members}"]
    }
}

resource "google_compute_subnetwork_iam_policy" "compute_subnetwork_iam_policy" {
    count       = "${var.enable_compute_subnetwork_iam_policy ? 1 :0}"

    project     = "${var.project}"
    region      = "${var.region}"
    subnetwork  = "${var.subnetwork}"
    policy_data = "${data.google_iam_policy.iam_policy.policy_data}"

    depends_on  = ["data.google_iam_policy.iam_policy"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google compute subnetwork iam binding
#---------------------------------------------------
resource "google_compute_subnetwork_iam_binding" "compute_subnetwork_iam_binding" {
    count       = "${var.enable_compute_subnetwork_iam_binding ? 1 : 0}"
    
    project     = "${var.project}"
    region      = "${var.region}"
    subnetwork  = "${var.subnetwork}"
    role        = "${var.role}"

    members     = ["${var.members}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google compute subnetwork iam member
#---------------------------------------------------
resource "google_compute_subnetwork_iam_member" "compute_subnetwork_iam_member" {
    count       = "${var.enable_compute_subnetwork_iam_member ? 1 :0}"

    project     = "${var.project}"
    region      = "${var.region}"
    subnetwork  = "${var.subnetwork}"
    role        = "${var.role}"

    member      = "${element(var.members, 0)}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
