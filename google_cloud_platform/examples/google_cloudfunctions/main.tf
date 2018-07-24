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

module "storage_bucket" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = true
    lifecycle_rule_action_type          = "Delete"
    versioning_enabled                  = false
}

module "storage_bucket_object" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_bucket_object        = true
    bucket                              = "${element(module.storage_bucket.google_storage_bucket_name, 0)}"
    source_path                         = "/Users/captain/Downloads/line-bot-google-cloud-functions-example-master.zip"
}
 
module "google_cloudfunctions" {
    source                              = "../../modules/google_cloudfunctions"
    name                                = "TEST"

    # Use http
    trigger_http                        = true
    source_archive_bucket               = "${element(module.storage_bucket.google_storage_bucket_name, 0)}"
    source_archive_object               = "${element(module.storage_bucket_object.google_storage_bucket_object_name, 0)}"
    entry_point                         = "MyFunction"
}
