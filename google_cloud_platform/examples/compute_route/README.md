# Work with Google Cloud  Platform (compute route) via terraform

A terraform module for making google compute route.
 
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

module "compute_network" {
    source                          = "../../modules/compute_network"
    name                            = "TEST"

    enable_compute_network          = true
    auto_create_subnetworks         = false
}

module "compute_subnetwork" {
    source                          = "../../modules/compute_network"
    name                            = "TEST"

    enable_compute_network          = false
    enable_compute_subnetwork       = true
    enable_secondary_ip_range       = false
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
    ip_cidr_range                   = "10.0.0.0/16"
}

module "compute_route" {
    source                          = "../../modules/compute_route"
    name                            = "TEST"

    enable_compute_route            = true
    dest_range                      = "15.0.0.0/24"
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
    next_hop_ip                     = "10.0.0.5"
    
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `project` - "The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `network` - "The name or self_link of the network to attach this firewall to." (`    default     = "default"`)
- `enable_compute_route` - "Enable compute route usage" (`    default     = "true"`)
- `timeouts_create` - "Time to create. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `timeouts_delete` - "Time to delete. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `description` - "(Optional) An optional description of this resource. Provide this property when you create the resource." (`    default     = ""`)
- `dest_range` - "(Required) The destination range of outgoing packets that this route applies to. Only IPv4 is supported." (`    default     = ""`)
- `next_hop_ip` - "(Optional) Network IP address of an instance that should handle matching packets." (`    default     = ""`)
- `priority` - "(Optional) The priority of this route. Priority is used to break ties in cases where there is more than one matching route of equal prefix length. In the case of two routes with equal prefix length, the one with the lowest-numbered priority value wins. Default value is 1000. Valid range is 0 through 65535." (`    default     = "1000"`)
- `next_hop_gateway` - "Optional) URL to a gateway that should handle matching packets. Currently, you can only specify the internet gateway, using a full or partial valid URL: https://www.googleapis.com/compute/v1/projects/project/global/gateways/default-internet-gateway or projects/project/global/gateways/default-internet-gateway or global/gateways/default-internet-gateway or The string default-internet-gateway." (`    default     = ""`)
- `next_hop_instance` - "(Optional) URL to an instance that should handle matching packets. You can specify this as a full or partial URL. For example: https://www.googleapis.com/compute/v1/projects/project/zones/zone/instances/instance or projects/project/zones/zone/instances/instance or zones/zone/instances/instance or Just the instance name, with the zone in next_hop_instance_zone." (`    default     = ""`)
- `next_hop_vpn_tunnel` - "(Optional) URL to a VpnTunnel that should handle matching packets." (`    default     = ""`)
- `next_hop_instance_zone` - "(Optional when next_hop_instance is specified) The zone of the instance specified in next_hop_instance. Omit if next_hop_instance is specified as a URL." (`    default     = ""`)

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
