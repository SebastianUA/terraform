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
    source                          = "../../../modules/compute_network"
    name                            = "auto-subnet"

    enable_compute_network          = true
    auto_create_subnetworks         = true
}

module "compute_firewall" {
    source                          = "../../../modules/compute_firewall"
    name                            = "auto-subnet"

    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
    enable_all_ingress              = true
    enable_all_egress               = true
}
