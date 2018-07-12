# Work with Google Cloud  Platform (compute target pool) via terraform

A terraform module for making google compute target pool.
 
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
    service_account_scopes          = ["userinfo-email", "compute-ro", "storage-ro"]

}

module "compute_health_check" {
    source                              = "../../modules/compute_health_check"
    name                                = "TEST"

    project                             = "terraform-2018"


    custom_name                         = "testhc"
    enable_compute_http_health_check    = true


}

module "compute_target_pool" {
    source                              = "../../modules/compute_target_pool"
    name                                = "TEST"

    project                             = "terraform-2018"
    region                              = "us-east1"

    instances                           = ["${module.compute_instance.compute_instance_self_links}"]
    health_checks                       = ["${module.compute_health_check.http_self_link}"]
    #health_checks                       = ["${module.compute_health_check.https_name}"]
}
```

Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created (`default     = "TEST"`).
- `project` - The project in which the resource belongs. If it is not provided, the provider project is used (`default     = ""`).
- `region` - Where the target pool resides. Defaults to project region (`default     = ""`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `backup_pool` - URL to the backup target pool. Must also set failover_ratio (`default     = ""`).
- `description` - Textual description field (`default     = ""`).
- `failover_ratio` - Ratio (0 to 1) of failed nodes before using the backup pool (which must also be set) - (`default     = 0`).
- `health_checks` - List of zero or one health check name or self_link. Only legacy google_compute_http_health_check is supported (`default     = []`).
- `instances` - List of instances in the pool. They can be given as URLs, or in the form of 'zone/name'. Note that the instances need not exist at the time of target pool creation, so there is no need to use the Terraform interpolators to create a dependency on the instances from the target pool (`default     = []`).                                                                                  
- `session_affinity` - How to distribute load. Options are 'NONE' (no affinity). 'CLIENT_IP' (hash of the source/dest addresses / ports), and 'CLIENT_IP_PROTO' also includes the protocol (default 'NONE') - (`default     = "NONE"`).                         
- `use_compute_target_pool_default` - Enable compute target pool default for compute autoscaler or compute instance group manager. Default - fasle (`default = false`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
