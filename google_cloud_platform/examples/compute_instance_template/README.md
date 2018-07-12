# Work with Google Cloud  Platform (compute instance template) via terraform

A terraform module for making google compute instance template.
 
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
module "compute_instance_template" {
    source                              = "../../modules/compute_instance_template"
    name                                = "TEST"

    #Create a new boot disk from an image
    disk_source_image                   = "debian-cloud/debian-8"
    disk_auto_delete                    = true
    disk_boot                           = true

    #Use an existing disk resource
    #disk_source_image                   = "foo_existing_disk"
    #disk_auto_delete                    = false
    #disk_boot                           = false

    service_account_scopes              = ["userinfo-email", "compute-ro", "storage-ro"]
}
```

Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created (`default     = "TEST"`).
- `region` - An instance template is a global resource that is not bound to a zone or a region. However, you can still specify some regional resources in an instance template, which restricts the template to the region where that resource resides. For example, a custom subnetwork resource is tied to a specific region. Defaults to the region of the Provider if no value is given (`default     = ""`).
- `project` - The ID of the project in which the resource belongs. If it is not provided, the provider project is used (`default     = ""`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `can_ip_forward` - Whether to allow sending and receiving of packets with non-matching source or destination IPs. This defaults to false (`default     = false`).
- `description` - A brief description of this resource (`default     = ""`).
- `instance_description` - A brief description to use for instances created from this template (`default     = ""`).
- `ssh_user` - User for connection to google machine (`default     = "captain"`).
- `public_key_path` - Path to file containing public key (`default     = "~/.ssh/gcloud_id_rsa.pub"`).
- `install_script_src_path` - Path to install script within this repository (`default     = "scripts/install.sh"`).
- `network` - The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided (`default     = "default"`).
- `subnetwork` - The name or self_link of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided (`default     = ""`).
- `subnetwork_project` - The project in which the subnetwork belongs. If the subnetwork is a self_link, this field is ignored in favor of the project defined in the subnetwork self_link. If the subnetwork is a name and this field is not provided, the provider project is used (`default     = ""`).
- `address` - The private IP address to assign to the instance. If empty, the address will be automatically assigned (`default     = ""`).
- `nat_ip` - The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated (`default     = ""`).
- `network_tier` - The networking tier used for configuring this instance. This field can take the following values: PREMIUM or STANDARD. If this field is not specified, it is assumed to be PREMIUM (`default     = "PREMIUM"`).
- `service_account_email` - The service account e-mail address. If not given, the default Google Compute Engine service account is used. Note: allow_stopping_for_update must be set to true in order to update this field (`default     = ""`).
- `service_account_scopes` - A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope. Note: allow_stopping_for_update must be set to true in order to update this field (`default     = []`).
- `scheduling_preemptible` - Is the instance preemptible (`default     = "false"`).
- `scheduling_on_host_maintenance` - Describes maintenance behavior for the instance. Can be MIGRATE or TERMINATE (`default     = "TERMINATE"`).
- `scheduling_automatic_restart` - Specifies if the instance should be restarted if it was terminated by Compute Engine (not a user) - (`default     = "true"`).
- `guest_accelerator_type` - The accelerator type resource to expose to this instance. E.g. nvidia-tesla-k80 (`default     = ""`).
- `guest_accelerator_count` - The number of the guest accelerator cards exposed to this instance (`default     = "0"`).
- `min_cpu_platform` - Specifies a minimum CPU platform for the VM instance. Applicable values are the friendly names of CPU platforms, such as Intel Haswell or Intel Skylake. Note: allow_stopping_for_update must be set to true in order to update this field (`default     = "Intel Haswell"`).
- `machine_type` - The machine type to create.To create a machine with a custom type (such as extended memory), format the value like custom-VCPUS-MEM_IN_MB like custom-6-20480 for 6 vCPU and 20GB of RAM (`default     = "n1-highcpu-4"`).
- `alias_ip_range_ip_cidr_range` - The IP CIDR range represented by this alias IP range. This IP CIDR range must belong to the specified subnetwork and cannot contain IP addresses reserved by system or used by other network interfaces. At the time of writing only a netmask (e.g. /24) may be supplied, with a CIDR format resulting in an API error (`default     = "/24"`).
- `alias_ip_range_subnetwork_range_name` - The subnetwork secondary range name specifying the secondary range from which to allocate the IP CIDR range for this alias IP range. If left unspecified, the primary range of the subnetwork will be used (`default     = ""`).
- `disk_auto_delete` - Whether or not the disk should be auto-deleted. This defaults to true (`default     = "true"`).
- `disk_boot` - Indicates that this is a boot disk (`default     = "true"`).
- `disk_device_name` - A unique device name that is reflected into the /dev/ tree of a Linux operating system running within the instance. If not specified, the server chooses a default device name to apply to this disk (`default     = ""`).
- `disk_disk_name` - Name of the disk. When not provided, this defaults to the name of the instance (`default     = ""`).
- `disk_source_image` - The image from which to initialize this disk. This can be one of: the image's self_link, projects/{project}/global/images/{image}, projects/{project}/global/images/family/{family}, global/images/{image}, global/images/family/{family}, family/{family}, {project}/{family}, {project}/{image}, {family}, or {image}  (`default     = ""`).
- `disk_interface` - Specifies the disk interface to use for attaching this disk (`default     = ""`).
- `disk_mode` - The mode in which to attach this disk, either READ_WRITE or READ_ONLY. If you are attaching or creating a boot disk, this must read-write mode (`default     = "READ_WRITE"`).
- `disk_source` - The name of the disk (such as those managed by google_compute_disk) to attach (`default     = ""`).
- `disk_disk_type` - The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard' (`default     = "pd-standard"`).
- `disk_disk_size_gb` - The size of the image in gigabytes. If not specified, it will inherit the size of its base image (`default     = "10"`).
- `disk_type` - The type of GCE disk, can be either 'SCRATCH' or 'PERSISTENT' (`default     = "PERSISTENT"`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
