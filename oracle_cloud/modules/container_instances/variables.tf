#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# container instances container instance
#-----------------------------------------------------------
variable "enable_container_instance" {
  description = "Enable container instance usages"
  default     = false
}

variable "container_instance_availability_domain" {
  description = "(Required) The availability domain where the container instance runs."
  default     = null
}

variable "container_instance_compartment_id" {
  description = "(Required) (Updatable) The compartment OCID."
  default     = null
}

variable "container_instance_containers" {
  description = "(Required) The containers to create on this container instance."
  default     = []
}

variable "container_instance_shape" {
  description = "(Required) The shape of the container instance. The shape determines the resources available to the container instance."
  default     = null
}

variable "container_instance_shape_config" {
  description = "(Required) The size and amount of resources available to the container instance."
  default     = {}
}

variable "container_instance_vnics" {
  description = "(Required) The networks available to containers on this container instance."
  default     = []
}

variable "container_instance_container_restart_policy" {
  description = "(Optional) Container restart policy"
  default     = null
}

variable "container_instance_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. If you don't provide a name, a name is generated automatically."
  default     = ""
}

variable "container_instance_fault_domain" {
  description = "(Optional) The fault domain where the container instance runs."
  default     = null
}

variable "container_instance_graceful_shutdown_timeout_in_seconds" {
  description = "(Optional) The amount of time that processes in a container have to gracefully end when the container must be stopped. For example, when you delete a container instance. After the timeout is reached, the processes are sent a signal to be deleted."
  default     = null
}

variable "container_instance_dns_config" {
  description = "(Optional) Allow customers to define DNS settings for containers. If this is not provided, the containers use the default DNS settings of the subnet."
  default     = {}
}

variable "container_instance_image_pull_secrets" {
  description = "(Optional) The image pulls secrets so you can access private registry to pull container images."
  default     = []
}

variable "container_instance_volumes" {
  description = "(Optional) A volume is a directory with data that is accessible across multiple containers in a container instance."
  type = list(object({
    name = string
    # Add other volume-specific attributes here
    # For example:
    # mount_path = string
    # size       = number
  }))
  default = []

  validation {
    condition     = length(var.container_instance_volumes) <= 32
    error_message = "You can attach up to 32 volumes to a single container instance. Currently, you have ${length(var.container_instance_volumes)} volumes defined."
  }
}

variable "ccc_infrastructure_freeform_tags" {
  description = "(Optional) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'}"
  default     = {}
}

variable "container_instance_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Container Instance * update - (Defaults to 20 minutes), when updating the Container Instance * delete - (Defaults to 20 minutes), when destroying the Container Instance"
  default     = {}
}
