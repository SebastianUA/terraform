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

module "compute_url" {
    source                          = "../../modules/compute_url"
    name                            = "TEST"

    enable_compute_url_map          = true

    default_service                 = ""
    # Set rules for host_rule
    host_rule_hosts                 = []
    host_rule_path_matcher          = ""
    # Set rules for path_matcher
    path_matcher_name               = ""
    path_rule                       = [
        {
            paths   = ["/home"]
            service = "home"
        },
        {
            paths   = ["/login"]
            service = "login"
        }
    ]
    # Set rules for test
    test_service                    = ""
    test_host                       = ""
    test_path                       = ""
    
}

