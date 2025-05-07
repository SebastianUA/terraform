#-----------------------------------------------------------
# dedicated vm host
#-----------------------------------------------------------
output "core_dedicated_vm_host_availability_domain" {
  description = "The availability domain the dedicated virtual machine host is running in. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.availability_domain, [""]), 0)
}

output "core_dedicated_vm_host_compartment_id" {
  description = "The OCID of the compartment that contains the dedicated virtual machine host."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.compartment_id, [""]), 0)
}

output "core_dedicated_vm_host_dedicated_vm_host_shape" {
  description = "The dedicated virtual machine host shape. The shape determines the number of CPUs and other resources available for VMs."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.dedicated_vm_host_shape, [""]), 0)
}

output "core_dedicated_vm_host_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.display_name, [""]), 0)
}

output "core_dedicated_vm_host_fault_domain" {
  description = "The fault domain for the dedicated virtual machine host's assigned instances. For more information, see Fault Domains."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.fault_domain, [""]), 0)
}

output "core_dedicated_vm_host_id" {
  description = "The OCID of the dedicated VM host."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.id, [""]), 0)
}

output "core_dedicated_vm_host_remaining_memory_in_gbs" {
  description = "The current available memory of the dedicated VM host, in GBs."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.remaining_memory_in_gbs, [""]), 0)
}

output "core_dedicated_vm_host_remaining_ocpus" {
  description = "The current available OCPUs of the dedicated VM host."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.remaining_ocpus, [""]), 0)
}

output "core_dedicated_vm_host_state" {
  description = "The current state of the dedicated VM host."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.state, [""]), 0)
}

output "core_dedicated_vm_host_time_created" {
  description = "The date and time the dedicated VM host was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.time_created, [""]), 0)
}

output "core_dedicated_vm_host_total_memory_in_gbs" {
  description = "The current total memory of the dedicated VM host, in GBs."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.total_memory_in_gbs, [""]), 0)
}

output "core_dedicated_vm_host_total_ocpus" {
  description = "The current total OCPUs of the dedicated VM host."
  value       = element(concat(oci_core_dedicated_vm_host.core_dedicated_vm_host.*.total_ocpus, [""]), 0)
}

#-----------------------------------------------------------
# instance maintenance event
#-----------------------------------------------------------
output "core_instance_maintenance_event_additional_details" {
  description = "Additional details of the maintenance in the form of json."
  value       = concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.additional_details, [""])
}

output "core_instance_maintenance_event_alternative_resolution_actions" {
  description = "These are alternative actions to the requested instanceAction that can be taken to resolve the Maintenance."
  value       = concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.alternative_resolution_actions, [""])
}

output "core_instance_maintenance_event_can_delete_local_storage" {
  description = "For Instances that have local storage, this field is set to true when local storage will be deleted as a result of the Maintenance."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.can_delete_local_storage, [""]), 0)
}

output "core_instance_maintenance_event_can_reschedule" {
  description = "Indicates if this MaintenanceEvent is capable of being rescheduled up to the timeHardDueDate."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.can_reschedule, [""]), 0)
}

output "core_instance_maintenance_event_compartment_id" {
  description = "The OCID of the compartment that contains the instance."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.compartment_id, [""]), 0)
}

output "core_instance_maintenance_event_correlation_token" {
  description = "A unique identifier that will group Instances that have a relationship with one another and must be scheduled together for the Maintenance to proceed. Any Instances that have a relationship with one another from a Maintenance perspective will have a matching correlationToken."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.correlation_token, [""]), 0)
}

output "core_instance_maintenance_event_created_by" {
  description = "The creator of the maintenance event."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.created_by, [""]), 0)
}

output "core_instance_maintenance_event_id" {
  description = "The OCID of the maintenance event."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.id, [""]), 0)
}

output "core_instance_maintenance_event_description" {
  description = "It is the descriptive information about the maintenance taking place on the customer instance."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.description, [""]), 0)
}

output "core_instance_maintenance_event_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.display_name, [""]), 0)
}

output "core_instance_maintenance_event_estimated_duration" {
  description = "This is the estimated duration of the Maintenance, once the Maintenance has entered the STARTED state."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.estimated_duration, [""]), 0)
}

output "core_instance_maintenance_event_instance_action" {
  description = "This is the action that will be performed on the Instance by Oracle Cloud Infrastructure when the Maintenance begins."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.instance_action, [""]), 0)
}

output "core_instance_maintenance_event_instance_id" {
  description = "The OCID of the instance."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.instance_id, [""]), 0)
}

output "core_instance_maintenance_event_maintenance_category" {
  description = "This indicates the priority and allowed actions for this Maintenance. Higher priority forms of Maintenance have tighter restrictions and may not be rescheduled, while lower priority/severity Maintenance can be rescheduled, deferred, or even cancelled. Please see the Instance Maintenance documentation for details."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.maintenance_category, [""]), 0)
}

output "core_instance_maintenance_event_maintenance_reason" {
  description = "This is the reason that Maintenance is being performed. See Instance Maintenance documentation for details."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.maintenance_reason, [""]), 0)
}

output "core_instance_maintenance_event_start_window_duration" {
  description = "The duration of the time window Maintenance is scheduled to begin within."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.start_window_duration, [""]), 0)
}

output "core_instance_maintenance_event_state" {
  description = "The current state of the maintenance event."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.state, [""]), 0)
}

output "core_instance_maintenance_event_time_created" {
  description = "The date and time the maintenance event was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.time_created, [""]), 0)
}

output "core_instance_maintenance_event_time_finished" {
  description = "The time at which the Maintenance actually finished."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.time_finished, [""]), 0)
}

output "core_instance_maintenance_event_time_hard_due_date" {
  description = "It is the scheduled hard due date and time of the maintenance event. The maintenance event will happen at this time and the due date will not be extended."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.time_hard_due_date, [""]), 0)
}

output "core_instance_maintenance_event_time_started" {
  description = "The time at which the Maintenance actually started."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.time_started, [""]), 0)
}

output "core_instance_maintenance_event_time_window_start" {
  description = "The beginning of the time window when Maintenance is scheduled to begin. The Maintenance will not begin before this time."
  value       = element(concat(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.time_window_start, [""]), 0)
}

#-----------------------------------------------------------
# instance console connection
#-----------------------------------------------------------
output "core_instance_console_connection_compartment_id" {
  description = "The OCID of the compartment to contain the console connection."
  value       = element(concat(oci_core_instance_console_connection.core_instance_console_connection.*.compartment_id, [""]), 0)
}

output "core_instance_console_connection_connection_string" {
  description = "The SSH connection string for the console connection."
  value       = element(concat(oci_core_instance_console_connection.core_instance_console_connection.*.connection_string, [""]), 0)
}

output "core_instance_console_connection_fingerprint" {
  description = "The SSH public key's fingerprint for client authentication to the console connection."
  value       = element(concat(oci_core_instance_console_connection.core_instance_console_connection.*.fingerprint, [""]), 0)
}

output "core_instance_console_connection_id" {
  description = "The OCID of the console connection."
  value       = element(concat(oci_core_instance_console_connection.core_instance_console_connection.*.id, [""]), 0)
}

output "core_instance_console_connection_instance_id" {
  description = "The OCID of the instance the console connection connects to."
  value       = element(concat(oci_core_instance_console_connection.core_instance_console_connection.*.instance_id, [""]), 0)
}

output "core_instance_console_connection_service_host_key_fingerprint" {
  description = "The SSH public key's fingerprint for the console connection service host."
  value       = element(concat(oci_core_instance_console_connection.core_instance_console_connection.*.service_host_key_fingerprint, [""]), 0)
}

output "core_instance_console_connection_state" {
  description = "The current state of the console connection."
  value       = element(concat(oci_core_instance_console_connection.core_instance_console_connection.*.state, [""]), 0)
}

output "core_instance_console_connection_vnc_connection_string" {
  description = "The SSH connection string for the SSH tunnel used to connect to the console connection over VNC."
  value       = element(concat(oci_core_instance_console_connection.core_instance_console_connection.*.vnc_connection_string, [""]), 0)
}

#-----------------------------------------------------------
# compute cluster
#-----------------------------------------------------------
output "core_compute_cluster_availability_domain" {
  description = "The availability domain the compute cluster is running in. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_compute_cluster.core_compute_cluster.*.availability_domain, [""]), 0)
}

output "core_compute_cluster_compartment_id" {
  description = "The OCID of the compartment that contains the compute cluster."
  value       = element(concat(oci_core_compute_cluster.core_compute_cluster.*.compartment_id, [""]), 0)
}

output "core_compute_cluster_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_compute_cluster.core_compute_cluster.*.display_name, [""]), 0)
}

output "core_compute_cluster_id" {
  description = "The OCID of the compute cluster."
  value       = element(concat(oci_core_compute_cluster.core_compute_cluster.*.id, [""]), 0)
}

output "core_compute_cluster_state" {
  description = "The current state of the compute cluster."
  value       = element(concat(oci_core_compute_cluster.core_compute_cluster.*.state, [""]), 0)
}

output "core_compute_cluster_time_created" {
  description = "The date and time the compute cluster was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_compute_cluster.core_compute_cluster.*.time_created, [""]), 0)
}

#-----------------------------------------------------------
# compute capacity topology
#-----------------------------------------------------------
output "core_compute_capacity_topology_id" {
  description = "The OCID of the compute capacity topology."
  value       = element(concat(oci_core_compute_capacity_topology.core_compute_capacity_topology.*.id, [""]), 0)
}

output "core_compute_capacity_topology_state" {
  description = "The current state of the compute capacity topology."
  value       = element(concat(oci_core_compute_capacity_topology.core_compute_capacity_topology.*.state, [""]), 0)
}

output "core_compute_capacity_topology_time_created" {
  description = "The date and time that the compute capacity topology was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_compute_capacity_topology.core_compute_capacity_topology.*.time_created, [""]), 0)
}

output "core_compute_capacity_topology_time_updated" {
  description = "The date and time that the compute capacity topology was updated, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_compute_capacity_topology.core_compute_capacity_topology.*.time_updated, [""]), 0)
}

output "core_compute_capacity_topology_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_compute_capacity_topology.core_compute_capacity_topology.*.display_name, [""]), 0)
}

output "core_compute_capacity_topology_compartment_id" {
  description = "The OCID of the compartment that contains the compute capacity topology."
  value       = element(concat(oci_core_compute_capacity_topology.core_compute_capacity_topology.*.compartment_id, [""]), 0)
}

output "core_compute_capacity_topology_availability_domain" {
  description = "The availability domain of the compute capacity topology. Example: Uocm:US-CHICAGO-1-AD-2"
  value       = element(concat(oci_core_compute_capacity_topology.core_compute_capacity_topology.*.availability_domain, [""]), 0)
}
