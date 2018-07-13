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
module "google_dns" {
    source                              = "../../modules/google_dns"
    name                                = "TEST"
    # DNS Zone    
    enable_dns_managed_zone             = true
    description                         = "linux-notes.org"
    dns_name                            = "linux-notes.org."
    # DNS record
    enable_dns_record_set               = true
    managed_zone                        = "test-dns-mz-stage"
    rrdatas                             = ["8.8.8.8"]
        
}

