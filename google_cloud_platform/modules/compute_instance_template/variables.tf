variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "region" {
  description = "An instance template is a global resource that is not bound to a zone or a region. However, you can still specify some regional resources in an instance template, which restricts the template to the region where that resource resides. For example, a custom subnetwork resource is tied to a specific region. Defaults to the region of the Provider if no value is given."
  default     = ""    
} 

variable "project" {
    description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
    default     = "template-"
}

variable "can_ip_forward" {
    description = "Whether to allow sending and receiving of packets with non-matching source or destination IPs. This defaults to false."
    default     = false
}

variable "description" {
    description = "A brief description of this resource."
    default     = ""
}

variable "instance_description" {
    description = "A brief description to use for instances created from this template."
    default     = ""
}

variable "ssh_user" {
    description = "User for connection to google machine"
    default     = "captain"
}

variable "public_key_path" {
    description = "Path to file containing public key"
    default     = "~/.ssh/gcloud_id_rsa.pub"
}

variable "install_script_src_path" {
    description = "Path to install script within this repository"
    default     = "scripts/install.sh"
}

variable "network" {
    description = "The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided."
    default     = "default"
}

variable "subnetwork" {
    description = "The name or self_link of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
    default     = ""
}

variable "subnetwork_project" {
    description = "The project in which the subnetwork belongs. If the subnetwork is a self_link, this field is ignored in favor of the project defined in the subnetwork self_link. If the subnetwork is a name and this field is not provided, the provider project is used."
    default     = ""
}

variable "address" {
    description = "The private IP address to assign to the instance. If empty, the address will be automatically assigned."
    default     = ""
}

variable "nat_ip" {
    description = "The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated."
    default     = ""
}

variable "network_tier" {
    description = "The networking tier used for configuring this instance. This field can take the following values: PREMIUM or STANDARD. If this field is not specified, it is assumed to be PREMIUM."
    default     = "PREMIUM"
}

variable "service_account_email" {
    description = "The service account e-mail address. If not given, the default Google Compute Engine service account is used. Note: allow_stopping_for_update must be set to true in order to update this field."
    default     = ""
}

variable "service_account_scopes" {
    description = "A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope. Note: allow_stopping_for_update must be set to true in order to update this field."
    default     = []
}

variable "scheduling_preemptible" {
    description = "Is the instance preemptible."
    default     = "false"
}

variable "scheduling_on_host_maintenance" {
    description = "Describes maintenance behavior for the instance. Can be MIGRATE or TERMINATE"
    default     = "TERMINATE"
}

variable "scheduling_automatic_restart" {
    description = "Specifies if the instance should be restarted if it was terminated by Compute Engine (not a user)."
    default     = "true"
}

variable "guest_accelerator_type" {
    description = "The accelerator type resource to expose to this instance. E.g. nvidia-tesla-k80."
    default     = ""
}

variable "guest_accelerator_count" {
    description = "The number of the guest accelerator cards exposed to this instance."
    default     = "0"
}

variable "min_cpu_platform" {
    description = "Specifies a minimum CPU platform for the VM instance. Applicable values are the friendly names of CPU platforms, such as Intel Haswell or Intel Skylake. Note: allow_stopping_for_update must be set to true in order to update this field."
    default     = "Intel Haswell"
}

variable "machine_type" {
    description = "The machine type to create.To create a machine with a custom type (such as extended memory), format the value like custom-VCPUS-MEM_IN_MB like custom-6-20480 for 6 vCPU and 20GB of RAM."
    default     = "n1-highcpu-4"
}

variable "alias_ip_range_ip_cidr_range" {
    description = "The IP CIDR range represented by this alias IP range. This IP CIDR range must belong to the specified subnetwork and cannot contain IP addresses reserved by system or used by other network interfaces. At the time of writing only a netmask (e.g. /24) may be supplied, with a CIDR format resulting in an API error."
    default     = "/24"
}

variable "alias_ip_range_subnetwork_range_name" {
    description = "The subnetwork secondary range name specifying the secondary range from which to allocate the IP CIDR range for this alias IP range. If left unspecified, the primary range of the subnetwork will be used."
    default     = ""
}

variable "disk_auto_delete" {
    description = "Whether or not the disk should be auto-deleted. This defaults to true."
    default     = "true"
}

variable "disk_boot" {
    description = "Indicates that this is a boot disk."
    default     = true
}

variable "disk_device_name" {
    description = "A unique device name that is reflected into the /dev/ tree of a Linux operating system running within the instance. If not specified, the server chooses a default device name to apply to this disk."
    default     = ""
}

variable "disk_disk_name" {
    description = "Name of the disk. When not provided, this defaults to the name of the instance."
    default     = ""
}

variable "disk_source_image" {
    description = "The image from which to initialize this disk. This can be one of: the image's self_link, projects/{project}/global/images/{image}, projects/{project}/global/images/family/{family}, global/images/{image}, global/images/family/{family}, family/{family}, {project}/{family}, {project}/{image}, {family}, or {image}."
    default     = ""
}

variable "disk_interface" {
    description = "Specifies the disk interface to use for attaching this disk."
    default     = ""
}

variable "disk_mode" {
    description = "The mode in which to attach this disk, either READ_WRITE or READ_ONLY. If you are attaching or creating a boot disk, this must read-write mode."
    default     = "READ_WRITE"
}

variable "disk_source" {
    description = "The name of the disk (such as those managed by google_compute_disk) to attach."
    default     = ""
}

variable "disk_disk_type" {
    description = "The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'."
    default     = "pd-standard"
}

variable "disk_disk_size_gb" {
    description = "The size of the image in gigabytes. If not specified, it will inherit the size of its base image."
    default     = "10"
}

variable "disk_type" {
    description = "The type of GCE disk, can be either 'SCRATCH' or 'PERSISTENT'."
    default     = "PERSISTENT"
}
