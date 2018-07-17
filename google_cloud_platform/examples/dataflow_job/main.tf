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
module "dataflow_job" {
    source                              = "../../modules/dataflow_job"
    name                                = "TEST"

    template_gcs_path                   = "gs://terraform-2018/templates/template_file"
    temp_gcs_location                   = "gs://terraform-2018/tmp_dir"
}

