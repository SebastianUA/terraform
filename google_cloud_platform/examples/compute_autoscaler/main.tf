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

module "compute_health_check" {
    source                              = "../../modules/compute_health_check"
    name                                = "TEST"

    project                             = "terraform-2018"

    enable_compute_http_health_check    = true
}

module "compute_target_pool" {
    source                              = "../../modules/compute_target_pool"
    name                                = "TEST"

    project                             = "terraform-2018"
    region                              = "us-east1"

    use_compute_target_pool_default     = true
    health_checks                       = ["testhttphcstage"]
}

module "compute_forwarding_rule" {
    source                          = "../../modules/compute_forwarding_rule"
    name                            = "TEST"

    project                         = "terraform-2018"

    port_range                      = "80"
    target                          = "${element(module.compute_target_pool.default_pool_self_link, 0)}"
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
    can_ip_forward                      = false
    network                             = "default"
    machine_type                        = "n1-highcpu-4"
}

module "compute_instance_group_manager" {
    source                              = "../../modules/compute_instance_group_manager"
    name                                = "TEST"

    enable_just_instance_template_usage = "false"
    use_compute_instance_group_manager_default = true
    instance_template                   = "${element(module.compute_instance_template.self_link, 0)}"
    target_pools                        = ["${element(module.compute_target_pool.default_pool_self_link, 0)}"]
    #auto_healing_policies_health_check  = "${element(module.compute_health_check.http_self_link, 0)}"
    target_size                         = 0
} 

module "compute_autoscaler" {
    source                              = "../../modules/compute_autoscaler"
    name                                = "TEST"

    target                              = "${element(module.compute_instance_group_manager.gm_self_link_default, 0)}"
    #target                              = "${element(module.compute_instance_group_manager.group_manager_self_link, 0)}"
    #target                              = "https://www.googleapis.com/compute/v1/projects/terraform-2018/zones/us-east1-b/instanceGroupManagers/test-ce-gm-stage"
}



