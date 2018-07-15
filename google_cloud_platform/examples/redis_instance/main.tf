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
module "redis_instance" {
    source                              = "../../modules/redis_instance"
    name                                = "TEST"
    authorized_network                  = "default"
    reserved_ip_range                   = "192.168.0.0/29"
} 

