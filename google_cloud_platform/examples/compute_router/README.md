# Work with Google Cloud  Platform (compute router) via terraform

A terraform module for making google compute router.
 
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
    name                            = "TEST2"

    enable_compute_network          = true
    auto_create_subnetworks         = false
}

module "compute_router" {
    source                          = "../../modules/compute_router"
    name                            = "TEST"

    enable_compute_router           = true
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"

    bgp                             = [
        {
            asn               = 64514
            advertise_mode    = "CUSTOM"
            advertised_groups = ["ALL_SUBNETS"]
            advertised_ip_ranges = [
                {
                    range = "1.2.3.4"
                }
            ]
            advertised_ip_ranges = [
                {
                    range = "6.7.0.0/16"
                }
            ]    
        }
    ]
}

module "compute_router_interface" {
    source                          = "../../modules/compute_router"
    name                            = "TEST"

    enable_compute_router           = false
    enable_compute_router_interface = true
    router                          = "${element(module.compute_router.google_compute_router_name, 0)}"
    ip_range                        = ""
    vpn_tunnel                      = ""
}

module "compute_router_peer" {
    source                          = "../../modules/compute_router"
    name                            = "TEST"

    enable_compute_router           = false
    enable_compute_router_peer      = true
    router                          = "${element(module.compute_router.google_compute_router_name, 0)}" 
    interface                       = "${element(module.compute_router_interface.google_compute_router_interface_name, 0)}"
    peer_ip_address                 = "169.254.1.2"
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `network` - "(Required) A reference to the network to which this router belongs." (`    default     = "default"`)
- `description` - "(Optional) An optional description of this resource." (`    default     = ""`)
- `region` - "(Optional) Region where the router resides." (`    default     = ""`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `enable_compute_router` - "Enable compute router usage" (`    default     = "true"`)
- `bgp_asn` - "(Required) Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. The value will be fixed for this router resource. All VPN tunnels that link to this router will have the same local ASN." (`    default     = "64514"`)
- `bgp_advertise_mode` - "(Optional) User-specified flag to indicate which mode to use for advertisement. Valid values of this enum field are: DEFAULT, CUSTOM" (`    default     = "DEFAULT"`)
- `timeouts_create` - "Time to create. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `timeouts_update` - "Time to update. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `timeouts_delete` - "Time to delete. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `bgp` - " (Optional) BGP information specific to this router." (`    default     = []`)
- `enable_compute_router_interface` - "Enable compute router interface usage" (`    default     = "false"`)
- `router` - "(Required) The name of the router this interface will be attached to. Changing this forces a new interface to be created." (`    default     = ""`)
- `vpn_tunnel` - "(Required) The name or resource link to the VPN tunnel this interface will be linked to. Changing this forces a new interface to be created." (`    default     = ""`)
- `ip_range` - "(Optional) IP address and range of the interface. The IP range must be in the RFC3927 link-local IP space. Changing this forces a new interface to be created." (`    default     = ""`)
- `enable_compute_router_peer` - "Enable compute router peer usage" (`    default     = "false"`)
- `peer_ip_address` - "(Required) IP address of the BGP interface outside Google Cloud. Changing this forces a new peer to be created." (`    default     = ""`)
- `peer_asn` - "(Required) Peer BGP Autonomous System Number (ASN). Changing this forces a new peer to be created." (`    default     = "65513"`)
- `advertised_route_priority` - "(Optional) The priority of routes advertised to this BGP peer. Changing this forces a new peer to be created." (`    default     = "100"`)
- `interface` - "(Required) The name of the interface the BGP peer is associated with. Changing this forces a new peer to be created." (`    default     = ""`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
