#-----------------------------------------------------------
# core boot volume
#-----------------------------------------------------------
output "core_boot_volume_compartment_id" {
  description = "The OCID of the compartment that contains the boot volume."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.compartment_id, [""]), 0)
}

output "core_boot_volume_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.display_name, [""]), 0)
}

output "core_boot_volume_id" {
  description = "The boot volume's Oracle ID (OCID)."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.id, [""]), 0)
}

output "core_boot_volume_cluster_placement_group_id" {
  description = "The clusterPlacementGroup Id of the volume for volume placement."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.cluster_placement_group_id, [""]), 0)
}

output "core_boot_volume_availability_domain" {
  description = "The availability domain of the boot volume. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.availability_domain, [""]), 0)
}

output "core_boot_volume_boot_volume_replicas" {
  description = "The list of boot volume replicas of this boot volume"
  value       = concat(oci_core_boot_volume.core_boot_volume.*.boot_volume_replicas, [""])
}

output "core_boot_volume_auto_tuned_vpus_per_gb" {
  description = "The number of Volume Performance Units per GB that this boot volume is effectively tuned to."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.auto_tuned_vpus_per_gb, [""]), 0)
}

output "core_boot_volume_autotune_policies" {
  description = "The list of autotune policies enabled for this volume."
  value       = concat(oci_core_boot_volume.core_boot_volume.*.autotune_policies, [""])
}

output "core_boot_volume_volume_group_id" {
  description = "The OCID of the source volume group."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.volume_group_id, [""]), 0)
}

output "core_boot_volume_vpus_per_gb" {
  description = "The number of volume performance units (VPUs) that will be applied to this boot volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.vpus_per_gb, [""]), 0)
}

output "core_boot_volume_state" {
  description = "The current state of a boot volume."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.state, [""]), 0)
}

output "core_boot_volume_image_id" {
  description = "The image OCID used to create the boot volume."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.image_id, [""]), 0)
}

output "core_boot_volume_is_auto_tune_enabled" {
  description = "Specifies whether the auto-tune performance is enabled for this boot volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.is_auto_tune_enabled, [""]), 0)
}

output "core_boot_volume_is_hydrated" {
  description = "Specifies whether the boot volume's data has finished copying from the source boot volume or boot volume backup."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.is_hydrated, [""]), 0)
}

output "core_boot_volume_kms_key_id" {
  description = "The OCID of the Vault service master encryption key assigned to the boot volume."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.kms_key_id, [""]), 0)
}

output "core_boot_volume_size_in_gbs" {
  description = "The size of the boot volume in GBs."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.size_in_gbs, [""]), 0)
}

output "core_boot_volume_size_in_mbs" {
  description = "The size of the volume in MBs. The value must be a multiple of 1024. This field is deprecated. Please use size_in_gbs."
  value       = element(concat(oci_core_boot_volume.core_boot_volume.*.size_in_mbs, [""]), 0)
}

output "core_boot_volume_source_details" {
  description = "Output block of source details for Boot Volume"
  value       = concat(oci_core_boot_volume.core_boot_volume.*.source_details, [""])
}

#-----------------------------------------------------------
# core boot volume backup
#-----------------------------------------------------------
output "core_boot_volume_backup_id" {
  description = "The OCID of the boot volume backup."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.id, [""]), 0)
}

output "core_boot_volume_backup_image_id" {
  description = "The image OCID used to create the boot volume the backup is taken from."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.image_id, [""]), 0)
}

output "core_boot_volume_backup_kms_key_id" {
  description = "The OCID of the Vault service master encryption assigned to the boot volume backup. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.kms_key_id, [""]), 0)
}

output "core_boot_volume_backup_size_in_gbs" {
  description = "The size of the boot volume, in GBs."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.size_in_gbs, [""]), 0)
}

output "core_boot_volume_backup_source_boot_volume_backup_id" {
  description = "The OCID of the source boot volume backup."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.source_boot_volume_backup_id, [""]), 0)
}

output "core_boot_volume_backup_source_type" {
  description = "Specifies whether the backup was created manually, or via scheduled backup policy."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.source_type, [""]), 0)
}

output "core_boot_volume_backup_state" {
  description = "The current state of a boot volume backup."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.state, [""]), 0)
}

output "core_boot_volume_backup_type" {
  description = "The type of a volume backup. Supported values are 'FULL' or 'INCREMENTAL'."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.type, [""]), 0)
}

output "core_boot_volume_backup_unique_size_in_gbs" {
  description = "The size used by the backup, in GBs. It is typically smaller than sizeInGBs, depending on the space consumed on the boot volume and whether the backup is full or incremental."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.unique_size_in_gbs, [""]), 0)
}

output "core_boot_volume_backup_boot_volume_id" {
  description = "The OCID of the boot volume."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.boot_volume_id, [""]), 0)
}

output "core_boot_volume_backup_compartment_id" {
  description = "The OCID of the compartment that contains the boot volume backup."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.compartment_id, [""]), 0)
}

output "core_boot_volume_backup_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.display_name, [""]), 0)
}

output "core_boot_volume_backup_expiration_time" {
  description = "The date and time the volume backup will expire and be automatically deleted. Format defined by RFC3339. This parameter will always be present for backups that were created automatically by a scheduled-backup policy. For manually created backups, it will be absent, signifying that there is no expiration time and the backup will last forever until manually deleted."
  value       = element(concat(oci_core_boot_volume_backup.core_boot_volume_backup.*.expiration_time, [""]), 0)
}

#-----------------------------------------------------------
# core volume
#-----------------------------------------------------------
output "core_volume_id" {
  description = "The OCID of the volume."
  value       = element(concat(oci_core_volume.core_volume.*.id, [""]), 0)
}

output "core_volume_is_auto_tune_enabled" {
  description = "Specifies whether the auto-tune performance is enabled for this volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune."
  value       = element(concat(oci_core_volume.core_volume.*.is_auto_tune_enabled, [""]), 0)
}

output "core_volume_is_hydrated" {
  description = "Specifies whether the cloned volume's data has finished copying from the source volume or backup."
  value       = element(concat(oci_core_volume.core_volume.*.is_hydrated, [""]), 0)
}

output "core_volume_kms_key_id" {
  description = "The OCID of the Vault service key which is the master encryption key for the volume."
  value       = element(concat(oci_core_volume.core_volume.*.kms_key_id, [""]), 0)
}

output "core_volume_size_in_gbs" {
  description = "The size of the volume in GBs."
  value       = element(concat(oci_core_volume.core_volume.*.size_in_gbs, [""]), 0)
}

output "core_volume_size_in_mbs" {
  description = "The size of the volume in MBs. This field is deprecated. Use sizeInGBs instead."
  value       = element(concat(oci_core_volume.core_volume.*.size_in_mbs, [""]), 0)
}

output "core_volume_source_details" {
  description = "Output of source details"
  value       = concat(oci_core_volume.core_volume.*.source_details, [""])
}

output "core_volume_cluster_placement_group_id" {
  description = "The clusterPlacementGroup Id of the volume for volume placement."
  value       = element(concat(oci_core_volume.core_volume.*.cluster_placement_group_id, [""]), 0)
}

output "core_volume_compartment_id" {
  description = "The OCID of the compartment that contains the volume."
  value       = element(concat(oci_core_volume.core_volume.*.compartment_id, [""]), 0)
}

output "core_volume_availability_domain" {
  description = "The availability domain of the volume. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_volume.core_volume.*.availability_domain, [""]), 0)
}

output "core_volume_block_volume_replicas" {
  description = "The list of block volume replicas of this volume."
  value       = element(concat(oci_core_volume.core_volume.*.block_volume_replicas, [""]), 0)
}

output "core_volume_auto_tuned_vpus_per_gb" {
  description = "The number of Volume Performance Units per GB that this volume is effectively tuned to."
  value       = element(concat(oci_core_volume.core_volume.*.auto_tuned_vpus_per_gb, [""]), 0)
}

output "core_volume_autotune_policies" {
  description = "The list of autotune policies enabled for this volume."
  value       = concat(oci_core_volume.core_volume.*.autotune_policies, [""])
}

output "core_volume_state" {
  description = "The current state of a volume."
  value       = element(concat(oci_core_volume.core_volume.*.state, [""]), 0)
}

output "core_volume_volume_group_id" {
  description = "The OCID of the source volume group."
  value       = element(concat(oci_core_volume.core_volume.*.volume_group_id, [""]), 0)
}

output "core_volume_vpus_per_gb" {
  description = "The number of volume performance units (VPUs) that will be applied to this volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information."
  value       = element(concat(oci_core_volume.core_volume.*.vpus_per_gb, [""]), 0)
}

#-----------------------------------------------------------
# core volume group
#-----------------------------------------------------------
output "core_volume_group_id" {
  description = "The OCID for the volume group."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.id, [""]), 0)
}

output "core_volume_group_volume_ids" {
  description = "OCIDs for the current volumes in this volume group."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.volume_ids, [""]), 0)
}

output "core_volume_group_state" {
  description = "The current state of a volume group."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.state, [""]), 0)
}

output "core_volume_group_source_details" {
  description = "Specifies the source for a volume group."
  value       = concat(oci_core_volume_group.core_volume_group.*.source_details, [""])
}

output "core_volume_group_is_hydrated" {
  description = "Specifies whether the newly created cloned volume group's data has finished copying from the source volume group or backup."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.is_hydrated, [""]), 0)
}

output "core_volume_group_size_in_gbs" {
  description = "The aggregate size of the volume group in GBs."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.size_in_gbs, [""]), 0)
}

output "core_volume_group_size_in_mbs" {
  description = "The aggregate size of the volume group in MBs."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.size_in_mbs, [""]), 0)
}

output "core_volume_group_availability_domain" {
  description = "The availability domain of the volume group."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.availability_domain, [""]), 0)
}

output "core_volume_group_compartment_id" {
  description = "The OCID of the compartment that contains the volume group."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.compartment_id, [""]), 0)
}

output "core_volume_group_display_name" {
  description = "user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.display_name, [""]), 0)
}

#-----------------------------------------------------------
# core volume group backup
#-----------------------------------------------------------
output "core_volume_group_compartment_id" {
  description = "The OCID of the compartment that contains the volume group backup."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.compartment_id, [""]), 0)
}

output "core_volume_group_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.display_name, [""]), 0)
}

output "core_volume_group_expiration_time" {
  description = "The date and time the volume group backup will expire and be automatically deleted. Format defined by RFC3339. This parameter will always be present for volume group backups that were created automatically by a scheduled-backup policy. For manually created volume group backups, it will be absent, signifying that there is no expiration time and the backup will last forever until manually deleted."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.expiration_time, [""]), 0)
}

output "core_volume_group_id" {
  description = "The OCID of the volume group backup."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.id, [""]), 0)
}

output "core_volume_group_size_in_gbs" {
  description = "The aggregate size of the volume group backup, in GBs."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.size_in_gbs, [""]), 0)
}

output "core_volume_group_size_in_mbs" {
  description = "The aggregate size of the volume group backup, in MBs."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.size_in_mbs, [""]), 0)
}

output "core_volume_group_source_type" {
  description = "Specifies whether the volume group backup was created manually, or via scheduled backup policy."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.source_type, [""]), 0)
}

output "core_volume_group_source_volume_group_backup_id" {
  description = "The OCID of the source volume group backup."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.source_volume_group_backup_id, [""]), 0)
}

output "core_volume_group_state" {
  description = "The current state of a volume group backup."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.state, [""]), 0)
}

output "core_volume_group_time_request_received" {
  description = "The date and time the request to create the volume group backup was received. Format defined by RFC3339."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.time_request_received, [""]), 0)
}

output "core_volume_group_type" {
  description = "The type of backup."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.type, [""]), 0)
}

output "core_volume_group_unique_size_in_gbs" {
  description = "The aggregate size used by the volume group backup, in GBs. It is typically smaller than size_in_gbs, depending on the space consumed on the volume group and whether the volume backup is full or incremental."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.unique_size_in_gbs, [""]), 0)
}

output "core_volume_group_unique_size_in_mbs" {
  description = "The aggregate size used by the volume group backup, in MBs. It is typically smaller than size_in_mbs, depending on the space consumed on the volume group and whether the volume backup is full or incremental."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.unique_size_in_mbs, [""]), 0)
}

output "core_volume_group_volume_backup_ids" {
  description = "OCIDs for the volume backups in this volume group backup."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.volume_backup_ids, [""]), 0)
}

output "core_volume_group_volume_group_id" {
  description = "The OCID of the source volume group."
  value       = element(concat(oci_core_volume_group.core_volume_group.*.volume_group_id, [""]), 0)
}

#-----------------------------------------------------------
# core volume backup
#-----------------------------------------------------------
output "core_volume_backup_compartment_id" {
  description = "The OCID of the compartment that contains the volume backup."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.compartment_id, [""]), 0)
}

output "core_volume_backup_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.display_name, [""]), 0)
}

output "core_volume_backup_expiration_time" {
  description = "The date and time the volume backup will expire and be automatically deleted. Format defined by RFC3339. This parameter will always be present for backups that were created automatically by a scheduled-backup policy. For manually created backups, it will be absent, signifying that there is no expiration time and the backup will last forever until manually deleted."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.expiration_time, [""]), 0)
}

output "core_volume_backup_id" {
  description = "The OCID of the volume backup."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.id, [""]), 0)
}

output "core_volume_backup_kms_key_id" {
  description = "The OCID of the Vault service key which is the master encryption key for the volume backup. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.kms_key_id, [""]), 0)
}

output "core_volume_backup_size_in_gbs" {
  description = "The size of the volume, in GBs."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.size_in_gbs, [""]), 0)
}

output "core_volume_backup_size_in_mbs" {
  description = "The size of the volume in MBs. The value must be a multiple of 1024. This field is deprecated. Please use size_in_gbs."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.size_in_mbs, [""]), 0)
}

output "core_volume_backup_source_type" {
  description = "Specifies whether the backup was created manually, or via scheduled backup policy."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.source_type, [""]), 0)
}

output "core_volume_backup_source_volume_backup_id" {
  description = "The OCID of the source volume backup."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.source_volume_backup_id, [""]), 0)
}

output "core_volume_backup_state" {
  description = "The current state of a volume backup."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.state, [""]), 0)
}

output "core_volume_backup_time_request_received" {
  description = "The date and time the request to create the volume backup was received. Format defined by [RFC3339]https://tools.ietf.org/html/rfc3339."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.time_request_received, [""]), 0)
}

output "core_volume_backup_type" {
  description = "The type of a volume backup. Supported values are 'FULL' or 'INCREMENTAL'."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.type, [""]), 0)
}

output "core_volume_backup_unique_size_in_gbs" {
  description = "The size used by the backup, in GBs. It is typically smaller than sizeInGBs, depending on the space consumed on the volume and whether the backup is full or incremental."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.unique_size_in_gbs, [""]), 0)
}

output "core_volume_backup_unique_size_in_mbs" {
  description = "The size used by the backup, in MBs. It is typically smaller than sizeInMBs, depending on the space consumed on the volume and whether the backup is full or incremental. This field is deprecated. Please use uniqueSizeInGBs."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.unique_size_in_mbs, [""]), 0)
}

output "core_volume_backup_volume_id" {
  description = "The OCID of the volume."
  value       = element(concat(oci_core_volume_backup.core_volume_backup.*.volume_id, [""]), 0)
}

#-----------------------------------------------------------
# core volume_ backup policy
#-----------------------------------------------------------
output "core_volume_backup_policy_compartment_id" {
  description = "The OCID of the compartment that contains the volume backup."
  value       = element(concat(oci_core_volume_backup_policy.core_volume_backup_policy.*.compartment_id, [""]), 0)
}

output "core_volume_backup_policy_destination_region" {
  description = "The paired destination region for copying scheduled backups to. Example us-ashburn-1. See Region Pairs for details about paired regions."
  value       = element(concat(oci_core_volume_backup_policy.core_volume_backup_policy.*.destination_region, [""]), 0)
}

output "core_volume_backup_policy_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_volume_backup_policy.core_volume_backup_policy.*.display_name, [""]), 0)
}

output "core_volume_backup_policy_id" {
  description = "The OCID of the volume backup policy."
  value       = element(concat(oci_core_volume_backup_policy.core_volume_backup_policy.*.id, [""]), 0)
}

output "core_volume_backup_policy_schedules" {
  description = "The collection of schedules that this policy will apply."
  value       = concat(oci_core_volume_backup_policy.core_volume_backup_policy.*.schedules, [""])
}

#-----------------------------------------------------------
# core volume backup policy assignment
#-----------------------------------------------------------
output "core_volume_backup_policy_assignment_asset_id" {
  description = "The OCID of the volume or volume group the policy has been assigned to."
  value       = element(concat(oci_core_volume_backup_policy_assignment.core_volume_backup_policy_assignment.*.asset_id, [""]), 0)
}

output "core_volume_backup_policy_assignment_id" {
  description = "The OCID of the volume backup policy assignment."
  value       = element(concat(oci_core_volume_backup_policy_assignment.core_volume_backup_policy_assignment.*.id, [""]), 0)
}

output "core_volume_backup_policy_assignment_policy_id" {
  description = "The OCID of the volume backup policy that has been assigned to the volume or volume group. For a volume group, only the user defined policy is allowed to use. For more information, see Policy-Based Backups."
  value       = element(concat(oci_core_volume_backup_policy_assignment.core_volume_backup_policy_assignment.*.policy_id, [""]), 0)
}

output "core_volume_backup_policy_assignment_xrc_kms_key_id" {
  description = "The OCID of the Vault service key which is the master encryption key for the block / boot volume cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  value       = element(concat(oci_core_volume_backup_policy_assignment.core_volume_backup_policy_assignment.*.xrc_kms_key_id, [""]), 0)
}

#-----------------------------------------------------------
# core volume attachment
#-----------------------------------------------------------
output "core_volume_attachment_port" {
  description = "The volume's iSCSI port, usually port 860 or 3260. Example: 3260"
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.port, [""]), 0)
}

output "core_volume_attachment_state" {
  description = "The current state of the volume attachment."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.state, [""]), 0)
}

output "core_volume_attachment_volume_id" {
  description = "The OCID of the volume."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.volume_id, [""]), 0)
}

output "core_volume_attachment_is_multipath" {
  description = "Whether the Iscsi or Paravirtualized attachment is multipath or not, it is not applicable to NVMe attachment."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.is_multipath, [""]), 0)
}

output "core_volume_attachment_is_pv_encryption_in_transit_enabled" {
  description = "Whether in-transit encryption for the data volume's paravirtualized attachment is enabled or not."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.is_pv_encryption_in_transit_enabled, [""]), 0)
}

output "core_volume_attachment_is_read_only" {
  description = "Whether the attachment was created in read-only mode."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.is_read_only, [""]), 0)
}

output "core_volume_attachment_iscsi_login_state" {
  description = "The iscsi login state of the volume attachment. For a Iscsi volume attachment, all iscsi sessions need to be all logged-in or logged-out to be in logged-in or logged-out state."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.iscsi_login_state, [""]), 0)
}

output "core_volume_attachment_is_volume_created_during_launch" {
  description = "Flag indicating if this volume was created for the customer as part of a simplified launch. Used to determine whether the volume requires deletion on instance termination."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.is_volume_created_during_launch, [""]), 0)
}

output "core_volume_attachment_iscsi_login_state" {
  description = "The iscsi login state of the volume attachment. For a Iscsi volume attachment, all iscsi sessions need to be all logged-in or logged-out to be in logged-in or logged-out state."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.iscsi_login_state, [""]), 0)
}

output "core_volume_attachment_chap_secret" {
  description = "The Challenge-Handshake-Authentication-Protocol (CHAP) secret valid for the associated CHAP user name."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.chap_secret, [""]), 0)
}

output "core_volume_attachment_chap_username" {
  description = "The volume's system-generated Challenge-Handshake-Authentication-Protocol (CHAP) user name. See RFC 1994 for more on CHAP. Example: ocid1.volume.oc1.phx.<unique_ID>"
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.chap_username, [""]), 0)
}

output "core_volume_attachment_compartment_id" {
  description = "The OCID of the compartment."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.compartment_id, [""]), 0)
}

output "core_volume_attachment_device" {
  description = "The device name."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.device, [""]), 0)
}

output "core_volume_attachment_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.display_name, [""]), 0)
}

output "core_volume_attachment_encryption_in_transit_type" {
  description = "Refer the top-level definition of encryptionInTransitType. The default value is NONE."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.encryption_in_transit_type, [""]), 0)
}

output "core_volume_attachment_id" {
  description = "The OCID of the volume attachment."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.id, [""]), 0)
}

output "core_volume_attachment_instance_id" {
  description = "The OCID of the instance the volume is attached to."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.instance_id, [""]), 0)
}

output "core_volume_attachment_ipv4" {
  description = "The volume's iSCSI IP address. Example: 169.254.0.2"
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.ipv4, [""]), 0)
}

output "core_volume_attachment_iqn" {
  description = "The target volume's iSCSI Qualified Name in the format defined by RFC 3720. Example: iqn.2015-12.us.oracle.com:<CHAP_username>"
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.iqn, [""]), 0)
}

output "core_volume_attachment_is_agent_auto_iscsi_login_enabled" {
  description = "Whether Oracle Cloud Agent is enabled perform the iSCSI login and logout commands after the volume attach or detach operations for non multipath-enabled iSCSI attachments."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.is_agent_auto_iscsi_login_enabled, [""]), 0)
}

output "core_volume_attachment_attachment_type" {
  description = "The type of volume attachment."
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.attachment_type, [""]), 0)
}

output "core_volume_attachment_availability_domain" {
  description = "The availability domain of an instance. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_volume_attachment.core_volume_attachment.*.availability_domain, [""]), 0)
}
