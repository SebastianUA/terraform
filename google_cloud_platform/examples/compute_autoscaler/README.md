# Work with Google Cloud  Platform (compute autoscaler) via terraform

A terraform module for making google compute autoscaler.
 
## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `zone` - "The zone that the machine should be created in" (`  default     = "us-east1-b"    `)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `description` - "An optional textual description of the instance group manager." (`    default     = ""`)
- `project` - "The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `target` - "The full URL to the instance group manager whose size we control." (`    default     = ""`)
- `autoscaling_policy_max_replicas` - "(Required) The group will never be larger than this." (`    default     = "1"`)
- `autoscaling_policy_min_replicas` - "(Required) The group will never be smaller than this." (`    default     = "1"`)
- `autoscaling_policy_cooldown_period` - "(Optional) Period to wait between changes. This should be at least double the time your instances take to start up." (`    default     = "60"`)
- `cpu_utilization_target` - "The floating point threshold where CPU utilization should be. E.g. for 50% one would specify 0.5." (`    default     = "0.5"`)
- `metric_name` - "The name of the Google Cloud Monitoring metric to follow, e.g. compute.googleapis.com/instance/network/received_bytes_count" (`    default     = ""`)
- `metric_type` - "Either 'cumulative', 'delta', or 'gauge'." (`    default     = "delta"`)
- `metric_target` - "The desired metric value per instance. Must be a positive value." (`    default     = "0"`)
- `load_balancing_utilization_target` - "The floating point threshold where load balancing utilization should be. E.g. if the load balancer's maxRatePerInstance is 10 requests per second (RPS) then setting this to 0.5 would cause the group to be scaled such that each instance receives 5 RPS." (`    default     = "0.5"`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
