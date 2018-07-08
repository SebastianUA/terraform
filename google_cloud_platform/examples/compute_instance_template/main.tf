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
module "compute_instance_template" {
    source                              = "../../modules/compute_instance_template"
    name                                = "TEST"

    #Create a new boot disk from an image
    disk_source_image                   = "centos-7"
    disk_auto_delete                    = true
    disk_boot                           = true

    #Use an existing disk resource
    #disk_source_image                   = "foo_existing_disk"
    #disk_auto_delete                    = false
    #disk_boot                           = false

    service_account_scopes              = ["userinfo-email", "compute-ro", "storage-ro"]
}

