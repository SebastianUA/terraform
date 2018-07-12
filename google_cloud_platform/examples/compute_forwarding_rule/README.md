# Work with Google Cloud  Platform (compute forwarding rule) via terraform

A terraform module for making google compute forwarding rule.
 
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

    number_of_instances             = "1"
    service_account_scopes          = ["userinfo-email", "compute-ro", "storage-ro"]
}

module "compute_health_check" {
    source                              = "../../modules/compute_health_check"
    name                                = "TEST"

    project                             = "terraform-2018"

    custom_name                         = ""
    enable_compute_http_health_check    = "true"
    http_health_check_port              = "80"
    http_health_check_request_path      = "/"
}

module "compute_target_pool" {
    source                              = "../../modules/compute_target_pool"
    name                                = "TEST"

    project                             = "terraform-2018"
    region                              = "us-east1"

    instances                           = ["${module.compute_instance.compute_instance_self_links}"]
    health_checks                       = ["${module.compute_health_check.http_self_link}"]
    #health_checks                       = ["testhttphcstage"]
}       

module "compute_forwarding_rule" {
    source                          = "../../modules/compute_forwarding_rule"
    name                            = "TEST"

    project                         = "terraform-2018"

    port_range                      = "80"
    target                          = "${module.compute_target_pool.self_link}"
}
```

Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `project` - The project in which the resource belongs. If it is not provided, the provider project is used (`default     = ""`).
- `region` - The region in which the resource belongs. If it is not provided, the project region is used (`default     = ""`).
- `description` - Description of this forwarding rule (`default     = ""`).
- `network` - Network of this forwarding rule (`default     = ""`).
- `subnetwork` - Subnetwork of this forwarding rule (`default     = ""`).
- `ip_address` - IP address of this forwarding rule (`default     = ""`).
- `ip_protocol` - IP protocol of this forwarding rule (`default     = ""`).
- `ports` - List of ports to use for internal load balancing, if this forwarding rule has any (`default     = []`).
- `port_range` - Port range, if this forwarding rule has one (`default     = 80`).
- `target` - URL of the target pool, if this forwarding rule has one (`default     = ""`).
- `backend_service` - Backend service, if this forwarding rule has one (`default     = ""`).
- `load_balancing_scheme` - Type of load balancing of this forwarding rule (`default     = ""`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
