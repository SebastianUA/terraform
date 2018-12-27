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




https://github.com/OlegGorj/tf-modules-crossclouds-vpc/blob/master/terraform/gcp_networking.tf





module "compute_network" {
    source                          = "../../../modules/compute_network"
    name                            = "GKE"

    enable_compute_network          = true
    auto_create_subnetworks         = false
}

module "compute_subnetwork" {
    source                          = "../../../modules/compute_network"
    name                            = "GKE"

    enable_compute_network          = false
    enable_compute_subnetwork       = true
    enable_secondary_ip_range       = false
    region                          = "us-east1"
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
    ip_cidr_range                   = "10.0.0.0/16"
}

module "compute_address" {
    source                          = "../../../modules/compute_address"
    name                            = "GKE"

    enable_compute_address          = true
    enable_compute_global_address   = false
}

module "compute_route" {
    source                          = "../../../modules/compute_route"
    name                            = "GKE"

    enable_compute_route            = true
    dest_range                      = "15.0.0.0/24"
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
    next_hop_ip                     = "10.0.0.5"   
}

module "compute_firewall" {
    source                          = "../../../modules/compute_firewall"
    name                            = "GKE"

    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
    enable_all_ingress              = true
    enable_all_egress               = true
}
