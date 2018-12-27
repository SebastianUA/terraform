# Work with Google Cloud  Platform (compute vpn gateway and tunnel) via terraform

A terraform module for making google compute vpn gateway and tunnel.
 
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

module "compute_vpn_gateway" {
    source                          = "../../modules/compute_vpn"
    name                            = "TEST"

    enable_compute_vpn_gateway      = true
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
}

module "compute_vpn_tunnel" {
    source                          = "../../modules/compute_vpn"
    name                            = "TEST"

    enable_compute_vpn_tunnel       = true
    peer_ip                         = "15.0.0.120"
    shared_secret                   = "test"
    target_vpn_gateway              = "${element(module.compute_vpn_gateway.google_compute_vpn_gateway_self_link, 0)}"
    
    local_traffic_selector          = []
    remote_traffic_selector         = []
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `project` - "The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `enable_compute_vpn_gateway` - "Enable compute vpn gateway usage" (`    default     = "false"`)
- `network` - "(Required) The network this VPN gateway is accepting traffic for." (`    default     = ""`)
- `region` - "(Optional) The region this gateway should sit in." (`    default     = ""`)
- `description` - "(Optional) An optional description of this resource." (`    default     = ""`)
- `timeouts_create` - "Time to create. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `timeouts_update` - "Time to update. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `timeouts_delete` - "Time to delete. Default is 4 minutes. Valid units of time are s, m, h." (`    default     = "4m"`)
- `enable_compute_vpn_tunnel` - "Enable compute vpn tunnel usage" (`    default     = "false"`)
- `target_vpn_gateway` - "(Required) URL of the Target VPN gateway with which this VPN tunnel is associated." (`    default     = ""`)
- `peer_ip` - "(Required) IP address of the peer VPN gateway. Only IPv4 is supported." (`    default     = ""`)
- `shared_secret` - "(Required) Shared secret used to set the secure session between the Cloud VPN gateway and the peer VPN gateway." (`    default     = ""`)
- `remote_traffic_selector` - "(Optional) Remote traffic selector to use when establishing the VPN tunnel with peer VPN gateway. The value should be a CIDR formatted string, for example 192.168.0.0/16. The ranges should be disjoint. Only IPv4 is supported." (`    default     = []`)
- `local_traffic_selector` - "(Optional) Local traffic selector to use when establishing the VPN tunnel with peer VPN gateway. The value should be a CIDR formatted string, for example 192.168.0.0/16. The ranges should be disjoint. Only IPv4 is supported." (`    default     = []`)
- `ike_version` - "(Optional) IKE protocol version to use when establishing the VPN tunnel with peer VPN gateway. Acceptable IKE versions are 1 or 2. Default version is 2." (`    default     = "2"`)
- `router` - "(Optional) URL of router resource to be used for dynamic routing." (`    default     = ""`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
