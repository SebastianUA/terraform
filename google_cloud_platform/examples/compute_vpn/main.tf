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

module "compute_vpn_gateway" {
    source                          = "../../modules/compute_vpn"
    name                            = "TEST"

    enable_compute_vpn_gateway      = true
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
}

module "compute_vpn_tunnel" {
    source                          = "../../modules/compute_vpn"
    name                            = "TEST"

    enable_compute_vpn_tunnel       = true
    peer_ip                         = "15.0.0.120"
    shared_secret                   = "test"
    target_vpn_gateway              = "${element(module.compute_vpn_gateway.google_compute_vpn_gateway_self_link, 0)}"
    
    local_traffic_selector          = []
    remote_traffic_selector         = []
}

