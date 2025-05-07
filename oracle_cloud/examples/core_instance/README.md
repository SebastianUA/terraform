# Work with CORE_INSTANCE via terraform

A terraform module for making CORE_INSTANCE.


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
  # config_file = var.provider_oci_config_file
  # profile     = var.provider_oci_profile

  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
}

module "core_instance" {
  source = "../../modules/core_instance"

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `compartment_id` - (Required) (Updatable) The OCID of the compartment to (`default = null`)
- `tags` - Add additional tags (`default = {}`)
- `enable_core_dedicated_vm_host` - Enable core dedicated vm host usages (`default = False`)
- `core_dedicated_vm_host_availability_domain` - (Required) The availability domain of the dedicated virtual machine host. Example: Uocm:PHX-AD-1 (`default = null`)
- `core_dedicated_vm_host_dedicated_vm_host_shape` - (Required) The dedicated virtual machine host shape. The shape determines the number of CPUs and other resources available for VM instances launched on the dedicated virtual machine host. (`default = null`)
- `core_dedicated_vm_host_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = ""`)
- `core_dedicated_vm_host_fault_domain` - (Optional) The fault domain for the dedicated virtual machine host's assigned instances. For more information, see Fault Domains. If you do not specify the fault domain, the system selects one for you. To change the fault domain for a dedicated virtual machine host, delete it and create a new dedicated virtual machine host in the preferred fault domain. (`default = null`)
- `core_dedicated_vm_host_defined_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'} (`default = {}`)
- `core_dedicated_vm_host_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Dedicated Vm Host * update - (Defaults to 20 minutes), when updating the Dedicated Vm Host * delete - (Defaults to 20 minutes), when destroying the Dedicated Vm Host (`default = {}`)
- `enable_core_instance_maintenance_event` - Enable core instance maintenance event usage (`default = False`)
- `core_instance_maintenance_event_instance_maintenance_event_id` - (Required) The OCID of the instance maintenance event. (`default = null`)
- `core_instance_maintenance_event_alternative_resolution_action` - (Optional) (Updatable) One of the alternativeResolutionActions that was provided in the InstanceMaintenanceEvent. (`default = null`)
- `core_instance_maintenance_event_can_delete_local_storage` - (Optional) (Updatable) This field is only applicable when setting the alternativeResolutionAction. (`default = null`)
- `core_instance_maintenance_event_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = ""`)
- `core_instance_maintenance_event_time_window_start` - (Optional) (Updatable) The beginning of the time window when Maintenance is scheduled to begin. The Maintenance will not begin before this time. (`default = null`)
- `core_instance_maintenance_event_defined_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `core_instance_maintenance_event_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Instance Maintenance Event * update - (Defaults to 20 minutes), when updating the Instance Maintenance Event * delete - (Defaults to 20 minutes), when destroying the Instance Maintenance Event (`default = {}`)
- `enable_core_instance_console_connection` - Enable core instance console connection usages (`default = False`)
- `core_instance_console_connection_instance_id` - Required) The OCID of the instance to create the console connection to. (`default = ""`)
- `core_instance_console_connection_public_key` - (Required) The SSH public key used to authenticate the console connection. (`default = null`)
- `core_instance_console_connection_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `core_instance_console_connection_name` - Set name for core instance console connection (`default = ""`)
- `core_instance_console_connection_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Instance Console Connection * update - (Defaults to 20 minutes), when updating the Instance Console Connection * delete - (Defaults to 20 minutes), when destroying the Instance Console Connection (`default = {}`)
- `enable_core_compute_cluster` - Enable core compute cluster usages (`default = False`)
- `core_compute_cluster_availability_domain` - (Required) The availability domain to place the compute cluster in. Example: Uocm:PHX-AD-1 (`default = null`)
- `core_compute_cluster_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_compute_cluster_defined_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'} (`default = {}`)
- `core_compute_cluster_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Compute Cluster * update - (Defaults to 20 minutes), when updating the Compute Cluster * delete - (Defaults to 20 minutes), when destroying the Compute Cluster (`default = {}`)
- `enable_core_compute_capacity_topology` - Enable core compute capacity topology usages (`default = False`)
- `core_compute_capacity_topology_availability_domain` - (Required) The availability domain of this compute capacity topology. Example: Uocm:US-CHICAGO-1-AD-2 (`default = null`)
- `core_compute_capacity_topology_capacity_source` - (Required) (Updatable) A capacity source of bare metal hosts. (`default = []`)
- `core_compute_capacity_topology_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_compute_capacity_topology_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. (`default = {}`)
- `core_compute_capacity_topology_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Compute Capacity Topology * update - (Defaults to 20 minutes), when updating the Compute Capacity Topology * delete - (Defaults to 20 minutes), when destroying the Compute Capacity Topology (`default = {}`)

## Module Output Variables
----------------------
- `core_dedicated_vm_host_availability_domain` - The availability domain the dedicated virtual machine host is running in. Example: Uocm:PHX-AD-1
- `core_dedicated_vm_host_compartment_id` - The OCID of the compartment that contains the dedicated virtual machine host.
- `core_dedicated_vm_host_dedicated_vm_host_shape` - The dedicated virtual machine host shape. The shape determines the number of CPUs and other resources available for VMs.
- `core_dedicated_vm_host_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_dedicated_vm_host_fault_domain` - The fault domain for the dedicated virtual machine host's assigned instances. For more information, see Fault Domains.
- `core_dedicated_vm_host_id` - The OCID of the dedicated VM host.
- `core_dedicated_vm_host_remaining_memory_in_gbs` - The current available memory of the dedicated VM host, in GBs.
- `core_dedicated_vm_host_remaining_ocpus` - The current available OCPUs of the dedicated VM host.
- `core_dedicated_vm_host_state` - The current state of the dedicated VM host.
- `core_dedicated_vm_host_time_created` - The date and time the dedicated VM host was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_dedicated_vm_host_total_memory_in_gbs` - The current total memory of the dedicated VM host, in GBs.
- `core_dedicated_vm_host_total_ocpus` - The current total OCPUs of the dedicated VM host.
- `core_instance_maintenance_event_additional_details` - Additional details of the maintenance in the form of json.
- `core_instance_maintenance_event_alternative_resolution_actions` - These are alternative actions to the requested instanceAction that can be taken to resolve the Maintenance.
- `core_instance_maintenance_event_can_delete_local_storage` - For Instances that have local storage, this field is set to true when local storage will be deleted as a result of the Maintenance.
- `core_instance_maintenance_event_can_reschedule` - Indicates if this MaintenanceEvent is capable of being rescheduled up to the timeHardDueDate.
- `core_instance_maintenance_event_compartment_id` - The OCID of the compartment that contains the instance.
- `core_instance_maintenance_event_correlation_token` - A unique identifier that will group Instances that have a relationship with one another and must be scheduled together for the Maintenance to proceed. Any Instances that have a relationship with one another from a Maintenance perspective will have a matching correlationToken.
- `core_instance_maintenance_event_created_by` - The creator of the maintenance event.
- `core_instance_maintenance_event_id` - The OCID of the maintenance event.
- `core_instance_maintenance_event_description` - It is the descriptive information about the maintenance taking place on the customer instance.
- `core_instance_maintenance_event_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_instance_maintenance_event_estimated_duration` - This is the estimated duration of the Maintenance, once the Maintenance has entered the STARTED state.
- `core_instance_maintenance_event_instance_action` - This is the action that will be performed on the Instance by Oracle Cloud Infrastructure when the Maintenance begins.
- `core_instance_maintenance_event_instance_id` - The OCID of the instance.
- `core_instance_maintenance_event_maintenance_category` - This indicates the priority and allowed actions for this Maintenance. Higher priority forms of Maintenance have tighter restrictions and may not be rescheduled, while lower priority/severity Maintenance can be rescheduled, deferred, or even cancelled. Please see the Instance Maintenance documentation for details.
- `core_instance_maintenance_event_maintenance_reason` - This is the reason that Maintenance is being performed. See Instance Maintenance documentation for details.
- `core_instance_maintenance_event_start_window_duration` - The duration of the time window Maintenance is scheduled to begin within.
- `core_instance_maintenance_event_state` - The current state of the maintenance event.
- `core_instance_maintenance_event_time_created` - The date and time the maintenance event was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_instance_maintenance_event_time_finished` - The time at which the Maintenance actually finished.
- `core_instance_maintenance_event_time_hard_due_date` - It is the scheduled hard due date and time of the maintenance event. The maintenance event will happen at this time and the due date will not be extended.
- `core_instance_maintenance_event_time_started` - The time at which the Maintenance actually started.
- `core_instance_maintenance_event_time_window_start` - The beginning of the time window when Maintenance is scheduled to begin. The Maintenance will not begin before this time.
- `core_instance_console_connection_compartment_id` - The OCID of the compartment to contain the console connection.
- `core_instance_console_connection_connection_string` - The SSH connection string for the console connection.
- `core_instance_console_connection_fingerprint` - The SSH public key's fingerprint for client authentication to the console connection.
- `core_instance_console_connection_id` - The OCID of the console connection.
- `core_instance_console_connection_instance_id` - The OCID of the instance the console connection connects to.
- `core_instance_console_connection_service_host_key_fingerprint` - The SSH public key's fingerprint for the console connection service host.
- `core_instance_console_connection_state` - The current state of the console connection.
- `core_instance_console_connection_vnc_connection_string` - The SSH connection string for the SSH tunnel used to connect to the console connection over VNC.
- `core_compute_cluster_availability_domain` - The availability domain the compute cluster is running in. Example: Uocm:PHX-AD-1
- `core_compute_cluster_compartment_id` - The OCID of the compartment that contains the compute cluster.
- `core_compute_cluster_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_compute_cluster_id` - The OCID of the compute cluster.
- `core_compute_cluster_state` - The current state of the compute cluster.
- `core_compute_cluster_time_created` - The date and time the compute cluster was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_compute_capacity_topology_id` - The OCID of the compute capacity topology.
- `core_compute_capacity_topology_state` - The current state of the compute capacity topology.
- `core_compute_capacity_topology_time_created` - The date and time that the compute capacity topology was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_compute_capacity_topology_time_updated` - The date and time that the compute capacity topology was updated, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_compute_capacity_topology_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_compute_capacity_topology_compartment_id` - The OCID of the compartment that contains the compute capacity topology.
- `core_compute_capacity_topology_availability_domain` - The availability domain of the compute capacity topology. Example: Uocm:US-CHICAGO-1-AD-2


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
