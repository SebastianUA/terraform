# Work with CONTAINER_INSTANCES via terraform

A terraform module for making CONTAINER_INSTANCES.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }
  }
}

provider "oci" {
  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
  alias            = var.provider_oci_alias
}

module "container_instances" {
  source = "../../modules/container_instances"

  enable_container_instance              = true
  container_instance_availability_domain = ""
  container_instance_compartment_id      = ""
  container_instance_shape               = ""

  container_instance_containers = [
    {

    }
  ]

  container_instance_shape_config = {}

  container_instance_vnics = []

  container_instance_display_name = ""

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_container_instance` - Enable container instance usages (`default = False`)
- `container_instance_availability_domain` - (Required) The availability domain where the container instance runs. (`default = null`)
- `container_instance_compartment_id` - (Required) (Updatable) The compartment OCID. (`default = null`)
- `container_instance_containers` - (Required) The containers to create on this container instance. (`default = []`)
- `container_instance_shape` - (Required) The shape of the container instance. The shape determines the resources available to the container instance. (`default = null`)
- `container_instance_shape_config` - (Required) The size and amount of resources available to the container instance. (`default = {}`)
- `container_instance_vnics` - (Required) The networks available to containers on this container instance. (`default = []`)
- `container_instance_container_restart_policy` - (Optional) Container restart policy (`default = null`)
- `container_instance_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. If you don't provide a name, a name is generated automatically. (`default = ""`)
- `container_instance_fault_domain` - (Optional) The fault domain where the container instance runs. (`default = null`)
- `container_instance_graceful_shutdown_timeout_in_seconds` - (Optional) The amount of time that processes in a container have to gracefully end when the container must be stopped. For example, when you delete a container instance. After the timeout is reached, the processes are sent a signal to be deleted. (`default = null`)
- `container_instance_dns_config` - (Optional) Allow customers to define DNS settings for containers. If this is not provided, the containers use the default DNS settings of the subnet. (`default = {}`)
- `container_instance_image_pull_secrets` - (Optional) The image pulls secrets so you can access private registry to pull container images. (`default = []`)
- `container_instance_volumes` - (Optional) A volume is a directory with data that is accessible across multiple containers in a container instance. (`default = []`)
- `ccc_infrastructure_freeform_tags` - (Optional) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'} (`default = {}`)
- `container_instance_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Container Instance * update - (Defaults to 20 minutes), when updating the Container Instance * delete - (Defaults to 20 minutes), when destroying the Container Instance (`default = {}`)

## Module Output Variables
----------------------
- `container_instance_availability_domain` - The availability domain to place the container instance.
- `container_instance_compartment_id` - The OCID of the compartment.
- `container_instance_container_count` - The number of containers on the container instance.
- `container_instance_container_restart_policy` - The container restart policy is applied for all containers in container instance.
- `container_instance_containers` - The containers on the container instance.
- `container_instance_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `container_instance_dns_config` - DNS settings for containers
- `container_instance_id` - An OCID that cannot be changed.
- `container_instance_image_pull_secrets` - The image pulls secrets so you can access private registry to pull container images.
- `container_instance_shape` - The shape of the container instance. The shape determines the number of OCPUs, amount of memory, and other resources that are allocated to a container instance.
- `container_instance_state` - The current state of the container instance.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
