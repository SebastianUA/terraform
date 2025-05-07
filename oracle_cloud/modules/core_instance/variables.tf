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

variable "compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to"
  default     = null
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# dedicated vm host
#-----------------------------------------------------------
variable "enable_core_dedicated_vm_host" {
  description = "Enable core dedicated vm host usages"
  default     = false
}

variable "core_dedicated_vm_host_availability_domain" {
  description = "(Required) The availability domain of the dedicated virtual machine host. Example: Uocm:PHX-AD-1"
  default     = null
}

variable "core_dedicated_vm_host_dedicated_vm_host_shape" {
  description = "(Required) The dedicated virtual machine host shape. The shape determines the number of CPUs and other resources available for VM instances launched on the dedicated virtual machine host."
  default     = null
}

variable "core_dedicated_vm_host_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = ""
}

variable "core_dedicated_vm_host_fault_domain" {
  description = "(Optional) The fault domain for the dedicated virtual machine host's assigned instances. For more information, see Fault Domains. If you do not specify the fault domain, the system selects one for you. To change the fault domain for a dedicated virtual machine host, delete it and create a new dedicated virtual machine host in the preferred fault domain."
  default     = null
}

variable "core_dedicated_vm_host_defined_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'}"
  default     = {}
}

variable "core_dedicated_vm_host_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Dedicated Vm Host * update - (Defaults to 20 minutes), when updating the Dedicated Vm Host * delete - (Defaults to 20 minutes), when destroying the Dedicated Vm Host"
  default     = {}
}

#-----------------------------------------------------------
# instance maintenance event
#-----------------------------------------------------------
variable "enable_core_instance_maintenance_event" {
  description = "Enable core instance maintenance event usage"
  default     = false
}

variable "core_instance_maintenance_event_instance_maintenance_event_id" {
  description = "(Required) The OCID of the instance maintenance event."
  default     = null
}

variable "core_instance_maintenance_event_alternative_resolution_action" {
  description = "(Optional) (Updatable) One of the alternativeResolutionActions that was provided in the InstanceMaintenanceEvent."
  default     = null
}

variable "core_instance_maintenance_event_can_delete_local_storage" {
  description = "(Optional) (Updatable) This field is only applicable when setting the alternativeResolutionAction."
  default     = null
}

variable "core_instance_maintenance_event_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = ""
}

variable "core_instance_maintenance_event_time_window_start" {
  description = "(Optional) (Updatable) The beginning of the time window when Maintenance is scheduled to begin. The Maintenance will not begin before this time."
  default     = null
}

variable "core_instance_maintenance_event_defined_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "core_instance_maintenance_event_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Instance Maintenance Event * update - (Defaults to 20 minutes), when updating the Instance Maintenance Event * delete - (Defaults to 20 minutes), when destroying the Instance Maintenance Event"
  default     = {}
}

#-----------------------------------------------------------
# instance console connection
#-----------------------------------------------------------
variable "enable_core_instance_console_connection" {
  description = "Enable core instance console connection usages"
  default     = false
}

variable "core_instance_console_connection_instance_id" {
  description = "Required) The OCID of the instance to create the console connection to."
  default     = ""
}

variable "core_instance_console_connection_public_key" {
  description = "(Required) The SSH public key used to authenticate the console connection."
  default     = null
}

variable "core_instance_console_connection_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "core_instance_console_connection_name" {
  description = "Set name for core instance console connection"
  default     = ""
}

variable "core_instance_console_connection_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Instance Console Connection * update - (Defaults to 20 minutes), when updating the Instance Console Connection * delete - (Defaults to 20 minutes), when destroying the Instance Console Connection"
  default     = {}
}

#-----------------------------------------------------------
# compute cluster
#-----------------------------------------------------------
variable "enable_core_compute_cluster" {
  description = "Enable core compute cluster usages"
  default     = false
}

variable "core_compute_cluster_availability_domain" {
  description = "(Required) The availability domain to place the compute cluster in. Example: Uocm:PHX-AD-1"
  default     = null
}

variable "core_compute_cluster_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_compute_cluster_defined_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'}"
  default     = {}
}

variable "core_compute_cluster_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Compute Cluster * update - (Defaults to 20 minutes), when updating the Compute Cluster * delete - (Defaults to 20 minutes), when destroying the Compute Cluster"
  default     = {}
}

#-----------------------------------------------------------
# compute capacity topology
#-----------------------------------------------------------
variable "enable_core_compute_capacity_topology" {
  description = "Enable core compute capacity topology usages"
  default     = false
}

variable "core_compute_capacity_topology_availability_domain" {
  description = "(Required) The availability domain of this compute capacity topology. Example: Uocm:US-CHICAGO-1-AD-2"
  default     = null
}

variable "core_compute_capacity_topology_capacity_source" {
  description = "(Required) (Updatable) A capacity source of bare metal hosts."
  default     = []
}

variable "core_compute_capacity_topology_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_compute_capacity_topology_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_compute_capacity_topology_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Compute Capacity Topology * update - (Defaults to 20 minutes), when updating the Compute Capacity Topology * delete - (Defaults to 20 minutes), when destroying the Compute Capacity Topology"
  default     = {}
}
