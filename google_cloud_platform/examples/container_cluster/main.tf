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

module "compute_firewall" {
    source                          = "../../modules/compute_firewall"
    name                            = "TEST"

    project                         = "terraform-2018"

    enable_all_ingress              = true    
    enable_all_egress               = true

    #enable_all_ingress              = false
    #allow_protocol                  = "icmp"
    #allow_ports                     = ["80", "443"]
}

module "container_cluster" {
    source                              = "../../modules/container_cluster"
    name                                = "TEST"
    #
    # Create container cluster in zone
    enable_container_cluster            = true
    zone                                = "us-east1-b"
    additional_zones                    = []
    region                              = ""
    #    
    # Create container cluster in region
    #enable_container_cluster            = true
    #zone                                = ""
    #region                              = "us-east1"
}

module "node_pool" {
    source                              = "../../modules/container_cluster"
    name                                = "TEST"

    enable_container_cluster            = false
    
    # Create container node pool
    enable_container_node_pool          = false
    container_cluster_name              = "${element(module.container_cluster.google_container_cluster_zone_name, 0)}"
    ##OR
    ##container_cluster_name              = "${element(module.container_cluster.google_container_cluster_region_name, 0)}"

}

