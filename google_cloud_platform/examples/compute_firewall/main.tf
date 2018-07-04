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

