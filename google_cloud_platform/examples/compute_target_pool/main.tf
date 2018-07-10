#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    #credentials = "${file("/Users/captain/.config/gcloud/creds/captain_creds.json")}"
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   

module "compute_instance" {
    source                          = "../../modules/compute_instance"
    name                            = "TEST"

    project_name                    = "terraform-2018"

    number_of_instances             = "2"
    machine_type                    = "n1-highcpu-4"
    service_account_scopes          = ["userinfo-email", "compute-ro", "storage-ro"]
}

module "compute_health_check" {
    source                              = "../../modules/compute_health_check"
    name                                = "TEST"

    project                             = "terraform-2018"

    custom_name                         = "testhttp"
    enable_compute_http_health_check    = "true"
    http_health_check_port              = "80"
    http_health_check_request_path      = "/"
}

module "compute_target_pool" {
    source                              = "../../modules/compute_target_pool"
    name                                = "TEST"

    project                             = "terraform-2018"
    region                              = "us-east1"

    #Use it when you want to add nodes to pool with HC
    use_compute_target_pool_default     = false
    instances                           = ["${module.compute_instance.compute_instance_self_links}"]
    #health_checks                       = ["${module.compute_health_check.http_self_link}"]
    health_checks                       = ["testhttphcstage"]
        
    #Use this way if you want to create default target pool for autoscaler or group manager. But, you SHOULD delete compute_instance for this case 
    #use_compute_target_pool_default     = true
    #health_checks                       = ["testhttphcstage"]
}   

module "compute_forwarding_rule" {
    source                          = "../../modules/compute_forwarding_rule"
    name                            = "TEST"

    project                         = "terraform-2018"

    port_range                      = "80"
    target                          = "${element(module.compute_target_pool.self_link, 0)}"
    #target                          = "${element(module.compute_target_pool.default_pool_self_link, 0)}"
}

module "compute_firewall" {
    source                          = "../../modules/compute_firewall"
    name                            = "TEST"

    project                         = "terraform-2018"

    enable_all_ingress              = true
    enable_all_egress               = true

    #enable_all_ingress              = false
    #allow_protocol                  = "icmp"
    #allow_ports                     = ["80", "443"]
}
