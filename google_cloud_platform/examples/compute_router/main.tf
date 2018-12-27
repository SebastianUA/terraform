#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}

provider "google" {
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   

module "compute_network" {
    source                          = "../../modules/compute_network"
    name                            = "TEST2"

    enable_compute_network          = true
    auto_create_subnetworks         = false
}

module "compute_router" {
    source                          = "../../modules/compute_router"
    name                            = "TEST"

    enable_compute_router           = true
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"

    bgp                             = [
        {
            asn               = 64514
            advertise_mode    = "CUSTOM"
            advertised_groups = ["ALL_SUBNETS"]
            advertised_ip_ranges = [
                {
                    range = "1.2.3.4"
                }
            ]
            advertised_ip_ranges = [
                {
                    range = "6.7.0.0/16"
                }
            ]    
        }
    ]
}

module "compute_router_interface" {
    source                          = "../../modules/compute_router"
    name                            = "TEST"

    enable_compute_router           = false
    enable_compute_router_interface = true
    router                          = "${element(module.compute_router.google_compute_router_name, 0)}"
    ip_range                        = ""
    vpn_tunnel                      = ""
}

module "compute_router_peer" {
    source                          = "../../modules/compute_router"
    name                            = "TEST"

    enable_compute_router           = false
    enable_compute_router_peer      = true
    router                          = "${element(module.compute_router.google_compute_router_name, 0)}" 
    interface                       = "${element(module.compute_router_interface.google_compute_router_interface_name, 0)}"
    peer_ip_address                 = "169.254.1.2"
}

