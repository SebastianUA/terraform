#-----------------------------------------------------------
# compute cloud at customer ccc infrastructure
#-----------------------------------------------------------
output "ccc_infrastructure_id" {
  description = "The Compute Cloud@Customer infrastructure OCID. This cannot be changed once created."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_infrastructure.ccc_infrastructure.*.id, [""]), 0)
}

output "ccc_infrastructure_display_name" {
  description = "The name that will be used to display the Compute Cloud@Customer infrastructure in the Oracle Cloud Infrastructure console. Does not have to be unique and can be changed. Avoid entering confidential information."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_infrastructure.ccc_infrastructure.*.display_name, [""]), 0)
}

output "ccc_infrastructure_description" {
  description = "A mutable client-meaningful text description of the Compute Cloud@Customer infrastructure. Avoid entering confidential information."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_infrastructure.ccc_infrastructure.*.description, [""]), 0)
}

output "ccc_infrastructure_ccc_upgrade_schedule_id" {
  description = "Schedule used for upgrades. If no schedule is associated with the infrastructure, it can be updated at any time."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_infrastructure.ccc_infrastructure.*.ccc_upgrade_schedule_id, [""]), 0)
}

output "ccc_infrastructure_compartment_id" {
  description = "The infrastructure compartment OCID."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_infrastructure.ccc_infrastructure.*.compartment_id, [""]), 0)
}

output "ccc_infrastructure_connection_state" {
  description = "The current connection state of the infrastructure. A user can only update it from REQUEST to READY or from any state back to REJECT. The system automatically handles the REJECT to REQUEST, READY to CONNECTED, or CONNECTED to DISCONNECTED transitions."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_infrastructure.ccc_infrastructure.*.connection_state, [""]), 0)
}

#-----------------------------------------------------------
# compute cloud at customer ccc upgrade schedule
#-----------------------------------------------------------
output "ccc_upgrade_schedule_id" {
  description = "Upgrade schedule OCID. This cannot be changed once created."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_upgrade_schedule.ccc_upgrade_schedule.*.id, [""]), 0)
}

output "ccc_upgrade_schedule_infrastructure_ids" {
  description = "List of Compute Cloud@Customer infrastructure OCIDs that are using this upgrade schedule."
  value       = concat(oci_compute_cloud_at_customer_ccc_upgrade_schedule.ccc_upgrade_schedule.*.infrastructure_ids, [""])
}

output "ccc_upgrade_schedule_state" {
  description = "Lifecycle state of the resource."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_upgrade_schedule.ccc_upgrade_schedule.*.state, [""]), 0)
}

output "ccc_upgrade_schedule_compartment_id" {
  description = "Compartment OCID for the Compute Cloud@Customer upgrade schedule."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_upgrade_schedule.ccc_upgrade_schedule.*.compartment_id, [""]), 0)
}

output "ccc_upgrade_schedule_description" {
  description = "An optional description of the Compute Cloud@Customer upgrade schedule. Avoid entering confidential information."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_upgrade_schedule.ccc_upgrade_schedule.*.description, [""]), 0)
}

output "ccc_upgrade_schedule_display_name" {
  description = "Compute Cloud@Customer upgrade schedule display name. Avoid entering confidential information."
  value       = element(concat(oci_compute_cloud_at_customer_ccc_upgrade_schedule.ccc_upgrade_schedule.*.display_name, [""]), 0)
}
