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
module "google_kms" {
    source                              = "../../modules/google_kms"
    name                                = "TEST"

    enable_kms_key_ring                 = false
    
    enable_kms_crypto_key_iam_binding   = false
    members                             = []
    
    enable_kms_crypto_key               = false
    
    enable_kms_crypto_key_iam_member    = false
    
    enable_kms_key_ring_iam_policy      = false
}
