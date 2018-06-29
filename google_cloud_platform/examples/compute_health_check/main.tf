#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    #credentials = "${file("/Users/captain/.config/gcloud/creds/captain_creds.json")}"
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east-1"
}   
module "compute_health_check" {
    source                              = "../../modules/compute_health_check"
    name                                = "TEST"

    project                             = "terraform-2018"
    
    enable_compute_http_health_check    = true
    enable_compute_https_health_check   = true
    enable_compute_ssl_health_check     = true
    enable_compute_tcp_health_check     = true
}

