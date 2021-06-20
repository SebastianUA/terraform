#---------------------------------------------------
# AWS storagegateway gateway
#---------------------------------------------------
output "storagegateway_gateway_id" {
  description = "Amazon Resource Name (ARN) of the gateway."
  value       = element(concat(aws_storagegateway_gateway.storagegateway_gateway.*.id, [""]), 0)
}

output "storagegateway_gateway_arn" {
  description = "Amazon Resource Name (ARN) of the gateway."
  value       = element(concat(aws_storagegateway_gateway.storagegateway_gateway.*.arn, [""]), 0)
}

output "storagegateway_gateway_gateway_id" {
  description = "Identifier of the gateway."
  value       = element(concat(aws_storagegateway_gateway.storagegateway_gateway.*.gateway_id, [""]), 0)
}

output "storagegateway_gateway_ec2_instance_id" {
  description = "The ID of the Amazon EC2 instance that was used to launch the gateway."
  value       = element(concat(aws_storagegateway_gateway.storagegateway_gateway.*.ec2_instance_id, [""]), 0)
}

output "storagegateway_gateway_endpoint_type" {
  description = "The type of endpoint for your gateway."
  value       = element(concat(aws_storagegateway_gateway.storagegateway_gateway.*.endpoint_type, [""]), 0)
}

output "storagegateway_gateway_host_environment" {
  description = "The type of hypervisor environment used by the host."
  value       = element(concat(aws_storagegateway_gateway.storagegateway_gateway.*.host_environment, [""]), 0)
}

output "storagegateway_gateway_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_storagegateway_gateway.storagegateway_gateway.*.tags_all, [""])
}

output "storagegateway_gateway_gateway_network_interface" {
  description = "An array that contains descriptions of the gateway network interfaces. See Gateway Network Interface."
  value       = concat(aws_storagegateway_gateway.storagegateway_gateway.*.gateway_network_interface, [""])
}

#---------------------------------------------------
# AWS storagegateway cached
#---------------------------------------------------
output "storagegateway_cache_id" {
  description = "Combined gateway Amazon Resource Name (ARN) and local disk identifier."
  value       = element(concat(aws_storagegateway_cache.storagegateway_cache.*.id, [""]), 0)
}

output "storagegateway_cache_gateway_arn" {
  description = "Get gateway arn"
  value       = element(concat(aws_storagegateway_cache.storagegateway_cache.*.gateway_arn, [""]), 0)
}

#---------------------------------------------------
# AWS storagegateway cached iscsi volume
#---------------------------------------------------
output "storagegateway_cached_iscsi_volume_id" {
  description = "Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678."
  value       = element(concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.id, [""]), 0)
}

output "storagegateway_cached_iscsi_volume_arn" {
  description = "Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678."
  value       = element(concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.arn, [""]), 0)
}

output "storagegateway_cached_iscsi_volume_chap_enabled" {
  description = "Whether mutual CHAP is enabled for the iSCSI target."
  value       = element(concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.chap_enabled, [""]), 0)
}

output "storagegateway_cached_iscsi_volume_lun_number" {
  description = "Logical disk number."
  value       = element(concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.lun_number, [""]), 0)
}

output "storagegateway_cached_iscsi_volume_network_interface_port" {
  description = "The port used to communicate with iSCSI targets."
  value       = element(concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.network_interface_port, [""]), 0)
}

output "storagegateway_cached_iscsi_volume_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.tags_all, [""])
}

output "storagegateway_cached_iscsi_volume_target_arn" {
  description = "Target Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/target/iqn.1997-05.com.amazon:TargetName."
  value       = element(concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.target_arn, [""]), 0)
}

output "storagegateway_cached_iscsi_volume_volume_arn" {
  description = "Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678."
  value       = element(concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.volume_arn, [""]), 0)
}

output "storagegateway_cached_iscsi_volume_volume_id" {
  description = "Volume ID, e.g. vol-12345678."
  value       = element(concat(aws_storagegateway_cached_iscsi_volume.storagegateway_cached_iscsi_volume.*.volume_id, [""]), 0)
}

#---------------------------------------------------
# AWS storagegateway nfs file share
#---------------------------------------------------
output "storagegateway_nfs_file_share_id" {
  description = "Amazon Resource Name (ARN) of the NFS File Share."
  value       = element(concat(aws_storagegateway_nfs_file_share.storagegateway_nfs_file_share.*.id, [""]), 0)
}

output "storagegateway_nfs_file_share_arn" {
  description = "Amazon Resource Name (ARN) of the NFS File Share."
  value       = element(concat(aws_storagegateway_nfs_file_share.storagegateway_nfs_file_share.*.arn, [""]), 0)
}

output "storagegateway_nfs_file_share_fileshare_id" {
  description = "ID of the NFS File Share."
  value       = element(concat(aws_storagegateway_nfs_file_share.storagegateway_nfs_file_share.*.fileshare_id, [""]), 0)
}

output "storagegateway_nfs_file_share_path" {
  description = "File share path used by the NFS client to identify the mount point."
  value       = element(concat(aws_storagegateway_nfs_file_share.storagegateway_nfs_file_share.*.path, [""]), 0)
}

output "storagegateway_nfs_file_share_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_storagegateway_nfs_file_share.storagegateway_nfs_file_share.*.tags_all, [""])
}

#---------------------------------------------------
# AWS storagegateway smb file share
#---------------------------------------------------
output "storagegateway_smb_file_share_id" {
  description = "Amazon Resource Name (ARN) of the SMB File Share."
  value       = element(concat(aws_storagegateway_smb_file_share.storagegateway_smb_file_share.*.id, [""]), 0)
}

output "storagegateway_smb_file_share_arn" {
  description = "Amazon Resource Name (ARN) of the SMB File Share."
  value       = element(concat(aws_storagegateway_smb_file_share.storagegateway_smb_file_share.*.arn, [""]), 0)
}

output "storagegateway_smb_file_share_fileshare_id" {
  description = "ID of the SMB File Share."
  value       = element(concat(aws_storagegateway_smb_file_share.storagegateway_smb_file_share.*.fileshare_id, [""]), 0)
}

output "storagegateway_smb_file_share_path" {
  description = "File share path used by the NFS client to identify the mount point."
  value       = element(concat(aws_storagegateway_smb_file_share.storagegateway_smb_file_share.*.path, [""]), 0)
}

output "storagegateway_smb_file_share_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_storagegateway_smb_file_share.storagegateway_smb_file_share.*.tags_all, [""])
}

#---------------------------------------------------
# AWS storagegateway stored iscsi volume
#---------------------------------------------------
output "storagegateway_stored_iscsi_volume_id" {
  description = "Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.id, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_arn" {
  description = "Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.arn, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_chap_enabled" {
  description = "Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.chap_enabled, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_lun_number" {
  description = "Logical disk number."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.lun_number, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_network_interface_port" {
  description = "The port used to communicate with iSCSI targets."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.network_interface_port, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.tags_all, [""])
}

output "storagegateway_stored_iscsi_volume_target_arn" {
  description = "Target Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/target/iqn.1997-05.com.amazon:TargetName."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.target_arn, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_volume_id" {
  description = "Volume ID, e.g. vol-12345678."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.volume_id, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_volume_status" {
  description = "indicates the state of the storage volume."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.volume_status, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_volume_type" {
  description = "indicates the type of the volume."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.volume_type, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_volume_attachment_status" {
  description = "A value that indicates whether a storage volume is attached to, detached from, or is in the process of detaching from a gateway."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.volume_attachment_status, [""]), 0)
}

output "storagegateway_stored_iscsi_volume_volume_size_in_bytes" {
  description = "The size of the data stored on the volume in bytes."
  value       = element(concat(aws_storagegateway_stored_iscsi_volume.storagegateway_stored_iscsi_volume.*.volume_size_in_bytes, [""]), 0)
}

#---------------------------------------------------
# AWS storagegateway tape pool
#---------------------------------------------------
output "storagegateway_tape_pool_id" {
  description = "Volume Amazon Resource Name (ARN), e.g. aws_storagegateway_tape_pool.example arn:aws:storagegateway:us-east-1:123456789012:tapepool/pool-12345678."
  value       = element(concat(aws_storagegateway_tape_pool.storagegateway_tape_pool.*.id, [""]), 0)
}

output "storagegateway_tape_pool_arn" {
  description = "Volume Amazon Resource Name (ARN), e.g. aws_storagegateway_tape_pool.example arn:aws:storagegateway:us-east-1:123456789012:tapepool/pool-12345678."
  value       = element(concat(aws_storagegateway_tape_pool.storagegateway_tape_pool.*.arn, [""]), 0)
}

output "storagegateway_tape_pool_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_storagegateway_tape_pool.storagegateway_tape_pool.*.tags_all, [""])
}

#---------------------------------------------------
# AWS storagegateway upload buffer
#---------------------------------------------------
output "storagegateway_upload_buffer_id" {
  description = "Combined gateway Amazon Resource Name (ARN) and local disk identifier."
  value       = element(concat(aws_storagegateway_upload_buffer.storagegateway_upload_buffer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS storagegateway working storage
#---------------------------------------------------
output "storagegateway_working_storage_id" {
  description = "Combined gateway Amazon Resource Name (ARN) and local disk identifier."
  value       = element(concat(aws_storagegateway_working_storage.storagegateway_working_storage.*.id, [""]), 0)
}
