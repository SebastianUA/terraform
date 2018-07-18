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
module "google_bigtable" {
    source                              = "../../modules/google_bigtable"
    name                                = "TEST"

    enable_bigtable_instance            = true
    # table
    #enable_bigtable_table               = true
    #instance_name                       = "test-bt-instance-stage"
    #split_keys                          = ["a", "b", "c"]
}           

module "google_bigtable_table" {
    source                              = "../../modules/google_bigtable"
    name                                = "TEST"

    enable_bigtable_instance            = false
    enable_bigtable_table               = true
    instance_name                       = "${element(module.google_bigtable.google_bigtable_instance_name, 0)}"
    split_keys                          = ["a", "b", "c"]

}
