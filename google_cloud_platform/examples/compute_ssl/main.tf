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

module "compute_ssl" {
    source                          = "../../modules/compute_ssl"
    name                            = "TEST"

    # Use MODERN
    enable_compute_ssl_policy       = true
    profile                         = "MODERN"
    min_tls_version                 = "TLS_1_2"

    # Use custom
    #enable_compute_ssl_policy       = true
    #profile                         = "CUSTOM"
    #min_tls_version                 = "TLS_1_0"
    #custom_features                 = ["TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384", "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"]
}

module "compute_ssl_certificate" {
    source                          = "../../modules/compute_ssl"

    # Use with name
    #name                            = "TEST"
    #enable_compute_ssl_certificate  = true
    #private_key                     = "/Users/captain/.ssh/gcloud_id_rsa"
    #certificate                     = "/Users/captain/.ssh/certificate"

    # Use prefix-name
    name                            = ""
    name_prefix                     = "cert-"
    enable_compute_ssl_certificate  = true
    private_key                     = "/Users/captain/.ssh/gcloud_id_rsa"
    certificate                     = "/Users/captain/.ssh/certificate"
}
