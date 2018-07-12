# Work with Google Cloud  Platform (compute instance group manager) via terraform

A terraform module for making google compute instance group manager.
 
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

    enable_just_instance_template_usage = "true"
    use_compute_instance_group_manager_default = true
    instance_template                   = "${element(module.compute_instance_template.self_link, 0)}"
    target_pools                        = ["${element(module.compute_target_pool.default_pool_self_link, 0)}"]
    #target_pools                        = ["https://www.googleapis.com/compute/v1/projects/terraform-2018/regions/us-east1/targetPools/test1-tp-stage"]
    auto_healing_policies_health_check  = "${element(module.compute_health_check.http_self_link, 0)}"
    target_size                         = 1
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `project` - "The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `createdby` - "Created by" (`    default     = "Vitaliy Natarov"`)
- `zone` - "The zone that instances in this group should be created in." (`    default     = "us-east1-b"`)
- `base_instance_name` - "The base instance name to use for instances in this group. The value must be a valid RFC1035 name. Supported characters are lowercase letters, numbers, and hyphens (-). Instances are named by appending a hyphen and a random four-character string to the base instance name." (`    default     = "TEST"`)
- `instance_template` - "The full URL to an instance template from which all new instances will be created. Conflicts with version" (`    default     = ""`)
- `target_pools` - "The full URL of all target pools to which new instances in the group are added. Updating the target pools attribute does not affect existing instances." (`    default     = []`)
- `description` - "An optional textual description of the instance group manager." (`    default     = ""`)
- `update_strategy` - "(Optional, Default 'RESTART') If the instance_template resource is modified, a value of 'NONE' will prevent any of the managed instances from being restarted by Terraform. A value of 'RESTART' will restart all of the instances at once. 'ROLLING_UPDATE' is supported as [Beta feature]. A value of 'ROLLING_UPDATE' requires rolling_update_policy block to be set" (`    default     = "RESTART"`)
- `target_size` - "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set. Defaults to 0." (`    default     = 0`)
- `wait_for_instances` - "Whether to wait for all instances to be created/updated before returning. Note that if this is set to true and the operation does not succeed, Terraform will continue trying until it times out." (`    default     = "true"`)
- `rolling_update_policy_type` - "The type of update. Valid values are 'OPPORTUNISTIC', 'PROACTIVE'" (`    default     = "PROACTIVE"`)
- `rolling_update_policy_minimal_action` - "Minimal action to be taken on an instance. Valid values are 'RESTART', 'REPLACE'" (`    default     = "REPLACE"`)
- `rolling_update_policy_max_surge_fixed` - "The maximum number of instances that can be created above the specified targetSize during the update process. Conflicts with max_surge_percent. If neither is set, defaults to 1" (`    default     = "1"`)
- `rolling_update_policy_max_surge_percent` - "The maximum number of instances(calculated as percentage) that can be created above the specified targetSize during the update process. Conflicts with max_surge_fixed." (`    default     = "20"`)
- `rolling_update_policy_max_unavailable_fixed` - "The maximum number of instances that can be unavailable during the update process. Conflicts with max_unavailable_percent. If neither is set, defaults to 1" (`    default     = "1"`)
- `rolling_update_policy_max_unavailable_percent` - "The maximum number of instances(calculated as percentage) that can be unavailable during the update process. Conflicts with max_unavailable_fixed." (`    default     = "20"`)
- `rolling_update_policy_min_ready_sec` - "Minimum number of seconds to wait for after a newly created instance becomes available. This value must be from range [0, 3600]" (`    default     = "50"`)
- `named_port_name` - "The name of the port." (`    default     = "custom-http"`)
- `named_port_port` - "The port number." (`    default     = "80"`)
- `auto_healing_policies_health_check` - "The health check resource that signals autohealing." (`    default     = ""`)
- `auto_healing_policies_initial_delay_sec` - "The number of seconds that the managed instance group waits before it applies autohealing policies to new instances or recently recreated instances. Between 0 and 3600." (`    default     = "300"`)
- `enable_just_instance_template_usage` - "Enable instance template usage. Will be conflict with version. Default - true" (`    default     = "true"`)
- `use_compute_instance_group_manager_default` - Enable compute group manager default. Default false. If true, will use with autoscaler (`default     = "false"`). 

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
