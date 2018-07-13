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
module "cloudbuild_trigger" {
    source                              = "../../modules/cloudbuild_trigger"
    name                                = "TEST"
   
    #enable_cloudbuild_trigger_filename  = true
    #filename                            = ""
    #
    enable_cloudbuild_trigger_filename  = false
    trigger_template_branch_name        = "master"
    
}

