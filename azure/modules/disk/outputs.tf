#-----------------------------------------------------------
# Azure disk pool
#-----------------------------------------------------------
output "disk_pool_id" {
  description = "The ID of the Disk Pool."
  value       = element(concat(azurerm_disk_pool.disk_pool.*.id, [""]), 0)
}

output "disk_pool_name" {
  description = "The name of the Disk Pool."
  value       = element(concat(azurerm_disk_pool.disk_pool.*.name, [""]), 0)
}

#-----------------------------------------------------------
# Azure disk pool managed disk attachment
#-----------------------------------------------------------
output "disk_pool_managed_disk_attachment_id" {
  description = "The ID of the Disk Pool Managed Disk Attachment."
  value       = element(concat(azurerm_disk_pool_managed_disk_attachment.disk_pool_managed_disk_attachment.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure disk pool iscsi target
#-----------------------------------------------------------
output "disk_pool_iscsi_target_id" {
  description = "The ID of the iSCSI Target."
  value       = element(concat(azurerm_disk_pool_iscsi_target.disk_pool_iscsi_target.*.id, [""]), 0)
}

output "disk_pool_iscsi_target_endpoints" {
  description = "List of private IPv4 addresses to connect to the iSCSI Target."
  value       = azurerm_disk_pool_iscsi_target.disk_pool_iscsi_target.*.endpoints
}

output "disk_pool_iscsi_target_port" {
  description = "The port used by iSCSI Target portal group."
  value       = element(concat(azurerm_disk_pool_iscsi_target.disk_pool_iscsi_target.*.port, [""]), 0)
}

#-----------------------------------------------------------
# Azure disk pool iscsi target lun
#-----------------------------------------------------------
output "disk_pool_iscsi_target_lun_id" {
  description = "The ID of the iSCSI Target LUN."
  value       = element(concat(azurerm_disk_pool_iscsi_target_lun.disk_pool_iscsi_target_lun.*.id, [""]), 0)
}

output "disk_pool_iscsi_target_lun_lun" {
  description = "The Logical Unit Number of the iSCSI Target LUN."
  value       = element(concat(azurerm_disk_pool_iscsi_target_lun.disk_pool_iscsi_target_lun.*.lun, [""]), 0)
}
