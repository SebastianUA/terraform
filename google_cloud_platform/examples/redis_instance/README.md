# Work with Google Cloud  Platform (redis instance) via terraform

A terraform module for making google redis instance.
 
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
module "redis_instance" {
    source                              = "../../modules/redis_instance"
    name                                = "TEST"
    authorized_network                  = "default"
    reserved_ip_range                   = "192.168.0.0/29"
} 
```

Module Input Variables
----------------------
- `name` - "(Required) The ID of the instance or a fully qualified identifier for the instance." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `memory_size_gb` - "(Required) Redis memory size in GiB." (`    default     = "1"`)
- `tier` - "(Optional) The service tier of the instance. Must be one of these values. BASIC: standalone instance. STANDARD_HA: highly available primary/replica instances" (`    default     = "STANDARD_HA"`)
- `region` - "(Optional) The name of the Redis region of the instance." (`    default     = "us-east1"`)
- `location_id` - "(Optional) The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For STANDARD_HA tier, instances will be created across two zones for protection against zonal failures. If [alternativeLocationId] is also provided, it must be different from [locationId]." (`    default     = "us-east1-b"`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `alternative_location_id` - "(Optional) Only applicable to STANDARD_HA tier which protects the instance against zonal failures by provisioning it across two zones. If provided, it must be a different zone from the one provided in [locationId]." (`    default     = "us-east1-d"`)
- `authorized_network` - "(Optional) The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used." (`    default     = ""`)
- `redis_version` - "(Optional) The version of Redis software. If not provided, latest supported version will be used. Updating the version will perform an upgrade/downgrade to the new version. Currently, the supported values are REDIS_3_2 for Redis 3.2." (`    default     = "REDIS_3_2"`)
- `display_name` - "(Optional) An arbitrary and optional user-provided name for the instance." (`    default     = ""`)
- `count_redis_instance` - "How many machines will be created" (`    default     = "1"`)
- `reserved_ip_range` - "(Optional) The CIDR range of internal addresses that are reserved for this instance. If not provided, the service will choose an unused /29 block, for example, 10.0.0.0/29 or 192.168.0.0/29. Ranges must be unique and non-overlapping with existing subnets in an authorized network." (`    default     = ""`)
- `timeouts_create` - "Time to create redis node. Default is 6 minutes." (`    default     = "6m"`)
- `timeouts_update` - "Time to update redis node. Default is 4 minutes." (`    default     = "4m"`)
- `timeouts_delete` - "Time to delete redis node. Default is 4 minutes." (`    default     = "4m"`)

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
