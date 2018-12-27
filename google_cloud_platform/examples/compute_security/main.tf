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

module "compute_security" {
    source                          = "../../modules/compute_security"
    name                            = "TEST"

    enable_compute_security_policy  = true
    rule                            = [
        {
            action   = "deny(403)"
            priority = "1000"
            match = [{
                versioned_expr = "SRC_IPS_V1"
                config = [{
                    src_ip_ranges = ["9.9.9.9/32"]
                },]
            },]
            description = "Deny access to IPs in 9.9.9.0/24"
        },
        {
            action   = "allow"
            priority = "2147483647"
            match = [{
                versioned_expr = "SRC_IPS_V1"
                config = [{
                    src_ip_ranges = ["*"]
                },]
            },]
            description = "default rule"
        },
    ]
}

