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
    name                            = "TEST"

    enable_compute_network          = true
    auto_create_subnetworks         = true
}

module "compute_network_peering" {
    source                          = "../../modules/compute_network"
    name                            = "TEST"
   
    enable_compute_network          = false
    enable_compute_network_peering  = true
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
    peer_network                    = "https://www.googleapis.com/compute/v1/projects/terraform-2018/global/networks/default"
}

#
# Custom subnetwork
#
module "compute_network2" {
    source                          = "../../modules/compute_network"
    name                            = "TEST2"

    enable_compute_network          = true
    auto_create_subnetworks         = false
}

module "compute_subnetwork" {
    source                          = "../../modules/compute_network"
    name                            = "TEST2"

    enable_compute_network          = false
    enable_compute_subnetwork       = true
    enable_secondary_ip_range       = false
    network                         = "${element(module.compute_network2.google_compute_network_self_link, 0)}"
}

#
# IAM policy
#
module "compute_subnetwork_iam_policy" {
    source                                  = "../../modules/compute_network"

    enable_compute_network                  = false
    enable_compute_subnetwork_iam_policy    = false
    subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_name, 0)}"
    #subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_with_secondary_ip_range_name, 0)}"
    role                                    = "roles/editor"
    members                                 = ["user:solo.metalisebastian@gmail.com"]
}

module "compute_subnetwork_iam_binding" {
    source                                  = "../../modules/compute_network"

    enable_compute_network                  = false
    enable_compute_subnetwork_iam_binding   = false
    subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_name, 0)}"
    #subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_with_secondary_ip_range_name, 0)}"
    role                                    = "roles/compute.networkUser"
    members                                 = ["user:solo.metalisebastian@gmail.com"]
}

module "compute_subnetwork_iam_member" {
    source                                  = "../../modules/compute_network"

    enable_compute_network                  = false
    enable_compute_subnetwork_iam_member    = false
    subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_name, 0)}"
    #subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_with_secondary_ip_range_name, 0)}"
    role                                    = "roles/compute.networkUser"
    members                                 = ["user:solo.metalisebastian@gmail.com"]
}

