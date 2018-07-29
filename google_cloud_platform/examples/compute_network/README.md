# Work with Google Cloud  Platform (compute network and subnetwork) via terraform

A terraform module for making google compute network and subnetwork.
 
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
    auto_create_subnetworks         = true
}

module "compute_network_peering" {
    source                          = "../../modules/compute_network"
    name                            = "TEST"
   
    enable_compute_network          = false
    enable_compute_network_peering  = true
    network                         = "${element(module.compute_network.google_compute_network_self_link, 0)}"
    peer_network                    = "https://www.googleapis.com/compute/v1/projects/terraform-2018/global/networks/default"
}

#
# Custom subnetwork
#
module "compute_network2" {
    source                          = "../../modules/compute_network"
    name                            = "TEST2"

    enable_compute_network          = true
    auto_create_subnetworks         = false
}

module "compute_subnetwork" {
    source                          = "../../modules/compute_network"
    name                            = "TEST2"

    enable_compute_network          = false
    enable_compute_subnetwork       = true
    network                         = "${element(module.compute_network2.google_compute_network_self_link, 0)}"
}

#
# IAM policy
#
module "compute_subnetwork_iam_policy" {
    source                                  = "../../modules/compute_network"

    enable_compute_network                  = false
    enable_compute_subnetwork_iam_policy    = false
    subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_name, 0)}"
    role                                    = "roles/editor"
    members                                 = ["user:solo.metalisebastian@gmail.com"]
}

module "compute_subnetwork_iam_binding" {
    source                                  = "../../modules/compute_network"

    enable_compute_network                  = false
    enable_compute_subnetwork_iam_binding   = false
    subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_name, 0)}"
    role                                    = "roles/compute.networkUser"
    members                                 = ["user:solo.metalisebastian@gmail.com"]
}

module "compute_subnetwork_iam_member" {
    source                                  = "../../modules/compute_network"

    enable_compute_network                  = false
    enable_compute_subnetwork_iam_member    = false
    subnetwork                              = "${element(module.compute_subnetwork.google_compute_subnetwork_name, 0)}"
    role                                    = "roles/compute.networkUser"
    members                                 = ["user:solo.metalisebastian@gmail.com"]
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `project` - "The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `auto_create_subnetworks` - "(Optional) If set to true, this network will be created in auto subnet mode, and Google will create a subnet for each region automatically. If set to false, a custom subnetted network will be created that can support google_compute_subnetwork resources. Defaults to true." (`    default     = "true"`)
- `routing_mode` - "(Optional) Sets the network-wide routing mode for Cloud Routers to use. Accepted values are 'GLOBAL' or 'REGIONAL'. Defaults to 'REGIONAL'. Refer to the Cloud Router documentation for more details." (`    default     = "REGIONAL"`)
- `description` - "(Optional) A brief description of this resource." (`    default     = ""`)
- `enable_compute_network` - "Enable compute network usage" (`    default     = "true"`)
- `enable_compute_network_peering` - "Enable compute network peering"  (`    default     = "false"`)
- `network` - "(Required) Resource link of the network to add a peering to." (`    default     = ""`)
- `peer_network` - "(Required) Resource link of the peer network." (`    default     = ""`)
- `auto_create_routes` - "(Optional) If set to true, the routes between the two networks will be created and managed automatically. Defaults to true." (`    default     = "true"`)
- `enable_compute_subnetwork` - "Enable compute subnetwork usage" (`    default     = "false"`)
- `ip_cidr_range` - "(Required) The range of internal addresses that are owned by this subnetwork. Provide this property when you create the subnetwork. For example, 10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and non-overlapping within a network. Only IPv4 is supported." (`    default     = "10.2.0.0/16"`)
- `region` - "(Optional) URL of the GCP region for this subnetwork." (`    default     = "us-east1"`)
- `enable_flow_logs` - "(Optional) Whether to enable flow logging for this subnetwork." (`    default     = "false"`)
- `private_ip_google_access` - "(Optional) Whether the VMs in this subnet can access Google services without assigned external IP addresses." (`    default     = "false"`)
- `secondary_ip_range_name` - "(Required) The name associated with this subnetwork secondary range, used when adding an alias IP range to a VM instance. The name must be 1-63 characters long, and comply with RFC1035. The name must be unique within the subnetwork." (`    default     = "tf-test-secondary-range"`)
- `secondary_ip_range_cidr` - "(Required) The range of IP addresses belonging to this subnetwork secondary range. Provide this property when you create the subnetwork. Ranges must be unique and non-overlapping with all primary and secondary IP ranges within a network. Only IPv4 is supported." (`    default     = "192.168.10.0/24"`)
- `timeouts_create` - "Time to create redis node. Default is 6 minutes. Valid units of time are s, m, h." (`    default     = "6m"`)
- `timeouts_update` - "Time to update redis node. Default is 6 minutes. Valid units of time are s, m, h." (`    default     = "6m"`)
- `timeouts_delete` - "Time to delete redis node. Default is 6 minutes. Valid units of time are s, m, h." (`    default     = "6m"`)
- `enable_compute_subnetwork_iam_policy` - "Enable compute subnetwork iam policy" (`    default     = "false"`)
- `role` - "The role that should be applied. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}." (`    default     = "roles/editor"`)
- `members` - "(Required) Identities that will be granted the privilege in role." (`    default     = []`)
- `subnetwork` - "(Required) The name of the subnetwork." (`    default     = ""`)
- `enable_compute_subnetwork_iam_binding` - "Enable compute subnetwork iam binding" (`    default     = "false"`)
- `enable_compute_subnetwork_iam_member` - "Enable compute subnetwork iam member" (`    default     = "false"`)

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
