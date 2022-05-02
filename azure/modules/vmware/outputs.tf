#-----------------------------------------------------------
# Azure vmware private cloud
#-----------------------------------------------------------
output "vmware_private_cloud_id" {
  description = "The ID of the VMware Private Cloud."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.id, [""]), 0)
}

output "vmware_private_cloud_circuit" {
  description = "A circuit block"
  value       = azurerm_vmware_private_cloud.vmware_private_cloud.*.circuit
}

output "vmware_private_cloud_hcx_cloud_manager_endpoint" {
  description = "The endpoint for the HCX Cloud Manager."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.hcx_cloud_manager_endpoint, [""]), 0)
}

output "vmware_private_cloud_nsxt_manager_endpoint" {
  description = "The endpoint for the NSX-T Data Center manager."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.nsxt_manager_endpoint, [""]), 0)
}

output "vmware_private_cloud_vcsa_endpoint" {
  description = "The endpoint for Virtual Center Server Appliance."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.vcsa_endpoint, [""]), 0)
}

output "vmware_private_cloud_nsxt_certificate_thumbprint" {
  description = "The thumbprint of the NSX-T Manager SSL certificate.."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.nsxt_certificate_thumbprint, [""]), 0)
}

output "vmware_private_cloud_vcenter_certificate_thumbprint" {
  description = "The thumbprint of the vCenter Server SSL certificate."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.vcenter_certificate_thumbprint, [""]), 0)
}

output "vmware_private_cloud_management_subnet_cidr" {
  description = "The network used to access vCenter Server and NSX-T Manager."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.management_subnet_cidr, [""]), 0)
}

output "vmware_private_cloud_provisioning_subnet_cidr" {
  description = "The network which is used for virtual machine cold migration, cloning, and snapshot migration."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.provisioning_subnet_cidr, [""]), 0)
}

output "vmware_private_cloud_vmotion_subnet_cidr" {
  description = "The network which is used for live migration of virtual machines."
  value       = element(concat(azurerm_vmware_private_cloud.vmware_private_cloud.*.vmotion_subnet_cidr, [""]), 0)
}

#-----------------------------------------------------------
# Azure vmware cluster
#-----------------------------------------------------------
output "vmware_cluster_id" {
  description = "The ID of the VMware Cluster."
  value       = element(concat(azurerm_vmware_cluster.vmware_cluster.*.id, [""]), 0)
}

output "vmware_cluster_cluster_number" {
  description = "A number that identifies this VMware Cluster in its VMware Private Cloud."
  value       = element(concat(azurerm_vmware_cluster.vmware_cluster.*.cluster_number, [""]), 0)
}

output "vmware_cluster_hosts" {
  description = "A list of host of the VMware Cluster."
  value       = azurerm_vmware_cluster.vmware_cluster.*.hosts
}

#-----------------------------------------------------------
# Azure vmware express route authorization
#-----------------------------------------------------------
output "vmware_express_route_authorization_id" {
  description = "The ID of the VMware Authorization."
  value       = element(concat(azurerm_vmware_express_route_authorization.vmware_express_route_authorization.*.id, [""]), 0)
}

output "vmware_express_route_authorization_express_route_authorization_id" {
  description = "The ID of the Express Route Circuit Authorization."
  value       = element(concat(azurerm_vmware_express_route_authorization.vmware_express_route_authorization.*.express_route_authorization_id, [""]), 0)
}

output "vmware_express_route_authorization_express_route_authorization_key" {
  description = "The key of the Express Route Circuit Authorization."
  value       = element(concat(azurerm_vmware_express_route_authorization.vmware_express_route_authorization.*.express_route_authorization_key, [""]), 0)
}