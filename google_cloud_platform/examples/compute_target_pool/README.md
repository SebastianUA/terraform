# Work with COMPUTE_TARGET_POOL via terraform

A terraform module for making COMPUTE_TARGET_POOL.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "google" {
  #credentials = file("/Users/captain/.config/gcloud/creds/captain_creds.json")
  credentials = file("/Users/captain/.config/gcloud/creds/terraform_creds.json")
  project     = "terraform-2018"
  region      = "us-east1"
}

module "compute_instance" {
  source = "../../modules/compute_instance"
  name   = "TEST"

  project_name = "terraform-2018"

  number_of_instances    = "2"
  machine_type           = "n1-highcpu-4"
  service_account_scopes = ["userinfo-email", "compute-ro", "storage-ro"]
}

module "compute_health_check" {
  source = "../../modules/compute_health_check"
  name   = "TEST"

  project = "terraform-2018"

  custom_name                      = "testhttp"
  enable_compute_http_health_check = "true"
  http_health_check_port           = "80"
  http_health_check_request_path   = "/"
}

module "compute_target_pool" {
  source = "../../modules/compute_target_pool"
  name   = "TEST"

  project = "terraform-2018"
  region  = "us-east1"

  #Use it when you want to add nodes to pool with HC
  use_compute_target_pool_default = false
  instances                       = ["${module.compute_instance.compute_instance_self_links}"]
  #health_checks                       = ["${module.compute_health_check.http_self_link}"]
  health_checks = ["testhttphcstage"]

  #Use this way if you want to create default target pool for autoscaler or group manager. But, you SHOULD delete compute_instance for this case
  #use_compute_target_pool_default     = true
  #health_checks                       = ["testhttphcstage"]
}

module "compute_forwarding_rule" {
  source = "../../modules/compute_forwarding_rule"
  name   = "TEST"

  project = "terraform-2018"

  port_range = "80"
  target     = element(module.compute_target_pool.self_link, 0)
  #target                          = "${element(module.compute_target_pool.default_pool_self_link, 0)}"
}

module "compute_firewall" {
  source = "../../modules/compute_firewall"
  name   = "TEST"

  project = "terraform-2018"

  enable_all_ingress = true
  enable_all_egress  = true

  #enable_all_ingress              = false
  #allow_protocol                  = "icmp"
  #allow_ports                     = ["80", "443"]
}

```

## Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created. (`default = TEST`)
- `project` - The project in which the resource belongs. If it is not provided, the provider project is used. (`default = ""`)
- `region` - Where the target pool resides. Defaults to project region. (`default = ""`)
- `environment` - Environment for service (`default = STAGE`)
- `backup_pool` - URL to the backup target pool. Must also set failover_ratio. (`default = ""`)
- `description` - Textual description field. (`default = ""`)
- `failover_ratio` - Ratio (0 to 1) of failed nodes before using the backup pool (which must also be set). (`default = 0`)
- `health_checks` - (Optional) List of zero or one health check name or self_link. Only legacy google_compute_http_health_check is supported. (`default = []`)
- `instances` - List of instances in the pool. They can be given as URLs, or in the form of 'zone/name'. Note that the instances need not exist at the time of target pool creation, so there is no need to use the Terraform interpolators to create a dependency on the instances from the target pool. (`default = []`)
- `session_affinity` - How to distribute load. Options are 'NONE' (no affinity). 'CLIENT_IP' (hash of the source/dest addresses / ports), and 'CLIENT_IP_PROTO' also includes the protocol (default 'NONE'). (`default = NONE`)
- `use_compute_target_pool_default` - Enable compute target pool default for compute autoscaler or compute instance group manager. Default - fasle (`default = False`)

## Module Output Variables
----------------------
- `self_link` - self link for target pool
- `name` - Name of target pool
- `default_pool_name` - Name for default target pool
- `default_pool_self_link` - self_link for default target pool


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
