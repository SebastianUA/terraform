# Work with Google Cloud  Platform (compute instance) via terraform

A terraform module for making google cloud compute instance.
 
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
    region      = "us-east-1"
}
module "compute_instance" {
    source                          = "../../modules/compute_instance"
    name                            = "TEST"

    project_name                    = "terraform-2018"

    number_of_instances        = "2"
    service_account_scopes      = ["userinfo-email", "compute-ro", "storage-ro"]

    enable_attached_disk        = false
    attached_disk_source        = "test-disk-1"
}

```

Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created (`default     = "TEST"`).
- `zone` - The zone that the machine should be created in (`default     = "us-east1-b"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (default     = "Vitaliy Natarov").
- `project_name` - The ID of the project in which the resource belongs. If it is not provided, the provider project is used (`default     = ""`).
- `machine_type` - The machine type to create (`default     = "f1-micro"`).
- `allow_stopping_for_update` - If true, allows Terraform to stop the instance to update its properties. If you try to update a property that requires stopping the instance without setting this field, the update will fail (`default     = true`).
- `can_ip_forward` - Whether to allow sending and receiving of packets with non-matching source or destination IPs. This defaults to false (`default     = false`).
- `timeouts` - Configurable timeout in minutes for creating instances. Default is 4 minutes. Changing this forces a new resource to be created (`default     = 4`).
- `description` - A brief description of this resource (`default     = ""`).
- `deletion_protection` - Enable deletion protection on this instance. Defaults to false. Note: you must disable deletion protection before removing the resource (e.g., via terraform destroy), or the instance cannot be deleted and the Terraform run will not complete successfully (`default     = false`).
- `min_cpu_platform` - Specifies a minimum CPU platform for the VM instance. Applicable values are the friendly names of CPU platforms, such as Intel Haswell or Intel Skylake. Note: allow_stopping_for_update must be set to true in order to update this field (`default     = "Intel Haswell"`).
- `boot_disk_auto_delete` - Whether the disk will be auto-deleted when the instance is deleted. Defaults to true (`default     = true`).
- `boot_disk_device_name` - Name with which attached disk will be accessible under /dev/disk/by-id/ (`default     = ""`).
- `disk_encryption_key_raw` - A 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to encrypt this disk (`default     = ""`).
- `boot_disk_initialize_params_size` - The size of the image in gigabytes. If not specified, it will inherit the size of its base image (`default     = "10"`).
- `boot_disk_initialize_params_type` - The GCE disk type. May be set to pd-standard or pd-ssd (`default     = "pd-standard"`).
- `boot_disk_initialize_params_image` - The image from which to initialize this disk. This can be one of: the image's self_link, projects/{project}/global/images/{image}, projects/{project}/global/images/family/{family}, global/images/{image}, global/images/family/{family}, family/{family}, {project}/{family}, {project}/{image}, {family}, or {image}. If referred by family, the images names must include the family name. If they don't, use the google_compute_image data source. For instance, the image centos-6-v20180104 includes its family name centos-6. These images can be referred by family name here (`default     = "centos-7"`).
- `number_of_instances` - Number of instances to make (`default     = "1"`).
- `network` - The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided (`default     = "default"`).
- `subnetwork` - The name or self_link of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided (`default     = ""`).
- `subnetwork_project` - The project in which the subnetwork belongs. If the subnetwork is a self_link, this field is ignored in favor of the project defined in the subnetwork self_link. If the subnetwork is a name and this field is not provided, the provider project is used (`default     = ""`).
- `address` - The private IP address to assign to the instance. If empty, the address will be automatically assigned (`default     = ""`).
- `nat_ip` - The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated (`default     = ""`).
- `public_ptr_domain_name` - The DNS domain name for the public PTR record. To set this field on an instance, you must be verified as the owner of the domain (`default     = ""`).
- `network_tier` - The networking tier used for configuring this instance. This field can take the following values: PREMIUM or STANDARD. If this field is not specified, it is assumed to be PREMIUM (`default     = "PREMIUM"`).
- `service_account_email` - The service account e-mail address. If not given, the default Google Compute Engine service account is used. Note: allow_stopping_for_update must be set to true in order to update this field (`default     = ""`).
- `service_account_scopes` - A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope. Note: allow_stopping_for_update must be set to true in order to update this field (`default     = []`).
- `scheduling_preemptible` - Is the instance preemptible (`default     = "false"`).
- `scheduling_on_host_maintenance` - Describes maintenance behavior for the instance. Can be MIGRATE or TERMINATE (`default     = "TERMINATE"`).
- `scheduling_automatic_restart` - Specifies if the instance should be restarted if it was terminated by Compute Engine (not a user) (`default     = "true"`).
- `guest_accelerator_type` - The accelerator type resource to expose to this instance. E.g. nvidia-tesla-k80 (`default     = ""`).
- `guest_accelerator_count` - The number of the guest accelerator cards exposed to this instance (`default     = "0"`).
- `ssh_user` - User for connection to google machine (`default     = "captain"`).
- `ssh_port` - Port for connection to google machine (`default     = "22"`).
- `public_key_path` - Path to file containing public key (`default     = "~/.ssh/gcloud_id_rsa.pub"`).
- `private_key_path` - Path to file containing private key (`default     = "~/.ssh/gcloud_id_rsa"`).
- `install_script_src_path` - Path to install script within this repository (`default     = "scripts/install.sh"`).
- `install_script_dest_path` - Path to put the install script on each destination resource (`default     = "/tmp/install.sh"`).
- `enable_attached_disk` - Enable attaching disk to node (`default     = "false"`).
- `attached_disk_source` - The name or self_link of the disk to attach to this instance (`default     = ""`).
- `attached_disk_device_name` - Name with which the attached disk will be accessible under /dev/disk/by-id/ (`default     = ""`).
- `attached_disk_mode` - Either 'READ_ONLY' or 'READ_WRITE', defaults to 'READ_WRITE' If you have a persistent disk with data that you want to share between multiple instances, detach it from any read-write instances and attach it to one or more instances in read-only mode (`default     = "READ_WRITE"`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
