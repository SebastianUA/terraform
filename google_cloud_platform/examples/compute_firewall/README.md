# Work with Google Cloud  Platform (compute firewall) via terraform

A terraform module for making google compute firewall.
 
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
```

Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `project` - he project in which the resource belongs. If it is not provided, the provider project is used (`default     = ""`).
- `network` - The name or self_link of the network to attach this firewall to (`default     = ""`).
- `description` - Textual description field (`default     = ""`).
- `priority` - The priority for this firewall. Ranges from 0-65535, inclusive. Defaults to 1000. Firewall resources with lower priority values have higher precedence (e.g. a firewall resource with a priority value of 0 takes effect over all other firewall rules with a non-zero priority) - (`default     = "1000"`).
- `source_ranges` - A list of source CIDR ranges that this firewall applies to. Can't be used for EGRESS  (`default     = []`).
- `source_tags` - A list of source tags for this firewall. Can't be used for EGRESS  (`default     = []`).
- `target_tags` - A list of target tags for this firewall (`default     = []`).
- `direction` - Direction of traffic to which this firewall applies; One of INGRESS or EGRESS. Defaults to INGRESS (`default     = "INGRESS"`).
- `destination_ranges` - A list of destination CIDR ranges that this firewall applies to. Can't be used for INGRESS  (`default     = []`).
- `source_service_accounts` - A list of service accounts such that the firewall will apply only to traffic originating from an instance with a service account in this list. Note that as of May 2018, this list can contain only one item, due to a change in the way that these firewall rules are handled. Source service accounts cannot be used to control traffic to an instance's external IP address because service accounts are associated with an instance, not an IP address. source_ranges can be set at the same time as source_service_accounts. If both are set, the firewall will apply to traffic that has source IP address within source_ranges OR the source IP belongs to an instance with service account listed in source_service_accounts. The connection does not need to match both properties for the firewall to apply. source_service_accounts cannot be used at the same time as source_tags or target_tags (`default     = []`).
- `target_service_accounts` - A list of service accounts indicating sets of instances located in the network that may make network connections as specified in allow. target_service_accounts cannot be used at the same time as source_tags or target_tags. If neither target_service_accounts nor target_tags are specified, the firewall rule applies to all instances on the specified network. Note that as of May 2018, this list can contain only one item, due to a change in the way that these firewall rules are handled (`default     = []`).
- `allow_protocol` - The name of the protocol to allow. This value can either be one of the following well known protocol strings (tcp, udp, icmp, esp, ah, sctp), or the IP protocol number, or all  (`default     = ""`).
- `allow_ports` - List of ports and/or port ranges to allow. This can only be specified if the protocol is TCP or UDP (`default     = []`).
- `deny_protocol` - The name of the protocol to deny. This value can either be one of the following well known protocol strings (tcp, udp, icmp, esp, ah, sctp), or the IP protocol number, or all  (`default     = ""`).
- `deny_ports` - List of ports and/or port ranges to allow. This can only be specified if the protocol is TCP or UDP (`default     = []`).
- `enable_all_ingress` - Enable all ports for ingress traffic (`default     = false`).
- `enable_all_egress` - Enable all ports for egress traffic (`default     = true`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
