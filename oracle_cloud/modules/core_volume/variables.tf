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
# core boot volume
#-----------------------------------------------------------
variable "enable_core_boot_volume" {
  description = "Enable core boot volume usages"
  default     = false
}

variable "core_boot_volume_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment that contains the boot volume."
  default     = null
}

variable "core_boot_volume_source_details" {
  description = "(Required) - Set list of boot volume source details"
  default     = []
}

variable "volume_source_details_type" {
  description = "(Optional) Specifies the volume source details for a new Block volume. The volume source is either another Block volume in the same Availability Domain or a Block volume backup. This is an optional field. If not specified or set to null, the new Block volume will be empty. When specified, the new Block volume will contain data from the source volume or backup."
  default     = []
}

variable "core_boot_volume_availability_domain" {
  description = "(Optional) The availability domain of the volume. Omissible for cloning a volume. The new volume will be created in the availability domain of the source volume. Example: Uocm:PHX-AD-1"
  default     = null
}

variable "core_boot_volume_backup_policy_id" {
  description = "(Optional) If provided, specifies the ID of the boot volume backup policy to assign to the newly created boot volume. If omitted, no policy will be assigned. This field is deprecated. Use the oci_core_volume_backup_policy_assignments instead to assign a backup policy to a boot volume."
  default     = null
}

variable "core_boot_volume_cluster_placement_group_id" {
  description = "(Optional) The clusterPlacementGroup Id of the volume for volume placement."
  default     = null
}

variable "core_boot_volume_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_boot_volume_is_auto_tune_enabled" {
  description = "(Optional) (Updatable) Specifies whether the auto-tune performance is enabled for this boot volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune."
  default     = null
}

variable "core_boot_volume_kms_key_id" {
  description = "(Optional) (Updatable) The OCID of the Vault service key to assign as the master encryption key for the boot volume."
  default     = null
}

variable "core_boot_volume_size_in_gbs" {
  description = "(Optional) (Updatable) The size of the volume in GBs."
  default     = null
}

variable "core_boot_volume_vpus_per_gb" {
  description = "(Optional) (Updatable) The number of volume performance units (VPUs) that will be applied to this volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information."
  default     = null
}

variable "core_boot_volume_xrc_kms_key_id" {
  description = "(Optional) The OCID of the Vault service key which is the master encryption key for the boot volume cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  default     = null
}

variable "core_boot_volume_boot_volume_replicas_deletion" {
  description = "Set boot volume replicas deletion usages"
  default     = null
}

variable "core_boot_volume_autotune_policies" {
  description = "(Optional) (Updatable) The list of autotune policies to be enabled for this volume."
  default     = []
}

variable "core_boot_volume_boot_volume_replicas" {
  description = "(Optional) (Updatable) The list of boot volume replicas to be enabled for this boot volume in the specified destination availability domains."
  default     = []
}

variable "core_boot_volume_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "core_boot_volume_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Boot Volume * update - (Defaults to 20 minutes), when updating the Boot Volume * delete - (Defaults to 20 minutes), when destroying the Boot Volume"
  default     = {}
}

#-----------------------------------------------------------
# core boot volume backup
#-----------------------------------------------------------
variable "enable_core_boot_volume_backup" {
  description = "Enable core boot volume backup usages"
  default     = false
}

variable "core_boot_volume_backup_boot_volume_id" {
  description = "The OCID of the source volume backup."
  default     = ""
}

variable "core_boot_volume_backup_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_boot_volume_backup_kms_key_id" {
  description = "(Optional) (Updatable) The OCID of the Vault service key which is the master encryption key for the volume backup. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  default     = null
}

variable "core_boot_volume_backup_type" {
  description = "(Optional) The type of backup to create. If omitted, defaults to incremental. Supported values are 'FULL' or 'INCREMENTAL'."
  default     = null
}

variable "core_boot_volume_backup_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_boot_volume_backup_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Boot Volume Backup * update - (Defaults to 20 minutes), when updating the Boot Volume Backup * delete - (Defaults to 20 minutes), when destroying the Boot Volume Backup"
  default     = {}
}

#-----------------------------------------------------------
# core volume
#-----------------------------------------------------------
variable "enable_core_volume" {
  description = "Enable core volume usages"
  default     = false
}

variable "core_volume_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment that contains the volume."
  default     = null
}

variable "core_volume_availability_domain" {
  description = "(Optional) The availability domain of the volume. Omissible for cloning a volume. The new volume will be created in the availability domain of the source volume. Example: Uocm:PHX-AD-1"
  default     = null
}

variable "core_volume_backup_policy_id" {
  description = "(Optional) If provided, specifies the ID of the volume backup policy to assign to the newly created volume. If omitted, no policy will be assigned. This field is deprecated. Use the oci_core_volume_backup_policy_assignments instead to assign a backup policy to a volume."
  default     = null
}

variable "core_volume_cluster_placement_group_id" {
  description = "(Optional) The clusterPlacementGroup Id of the volume for volume placement."
  default     = null
}

variable "core_volume_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_volume_is_auto_tune_enabled" {
  description = "(Optional) (Updatable) Specifies whether the auto-tune performance is enabled for this volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune."
  default     = null
}

variable "core_volume_kms_key_id" {
  description = "(Optional) (Updatable) The OCID of the Vault service key to assign as the master encryption key for the volume."
  default     = null
}

variable "core_volume_size_in_gbs" {
  description = "(Optional) (Updatable) The size of the volume in GBs."
  default     = null
}

variable "core_volume_size_in_mbs" {
  description = "(Optional) The size of the volume in MBs. The value must be a multiple of 1024. This field is deprecated. Use sizeInGBs instead."
  default     = null
}

variable "core_volume_vpus_per_gb" {
  description = "(Optional) (Updatable) The number of volume performance units (VPUs) that will be applied to this volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information."
  default     = null
}

variable "core_volume_xrc_kms_key_id" {
  description = "(Optional) The OCID of the Vault service key which is the master encryption key for the block volume cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  default     = null
}

variable "core_volume_block_volume_replicas_deletion" {
  description = "Set the replicas deletion for volume"
  default     = null
}

variable "core_volume_autotune_policies" {
  description = "(Optional) (Updatable) The list of autotune policies to be enabled for this volume."
  default     = []
}

variable "core_volume_block_volume_replicas" {
  description = "(Optional) (Updatable) The list of block volume replicas to be enabled for this volume in the specified destination availability domains."
  default     = []
}

variable "core_volume_source_details" {
  description = "(Optional) Specifies the volume source details for a new Block volume. The volume source is either another Block volume in the same Availability Domain or a Block volume backup. This is an optional field. If not specified or set to null, the new Block volume will be empty. When specified, the new Block volume will contain data from the source volume or backup."
  default     = []
}

variable "core_volume_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_volume_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume * update - (Defaults to 20 minutes), when updating the Volume * delete - (Defaults to 20 minutes), when destroying the Volume"
  default     = {}
}

#-----------------------------------------------------------
# core volume group
#-----------------------------------------------------------
variable "enable_core_volume_group" {
  description = "Enable core volume group usages"
  default     = false
}

variable "core_volume_group_availability_domain" {
  description = "(Required) The availability domain of the volume group."
  default     = null
}

variable "core_volume_group_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment that contains the volume group."
  default     = null
}

variable "core_volume_group_source_details" {
  description = "(Required) Specifies the source for a volume group."
  default     = []
}

variable "core_volume_group_backup_policy_id" {
  description = "(Optional) If provided, specifies the ID of the volume backup policy to assign to the newly created volume group. If omitted, no policy will be assigned. This field is deprecated. Use the oci_core_volume_backup_policy_assignments instead to assign a backup policy to a volume group."
  default     = null
}

variable "core_volume_group_cluster_placement_group_id" {
  description = "(Optional) The clusterPlacementGroup Id of the volume group for volume group placement."
  default     = null
}

variable "core_volume_group_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_volume_group_volume_ids" {
  description = "(Optional) (Updatable) Use this for update operation only. This field is not supported during creation. For create use volume_ids under source_details"
  default     = null
}

variable "core_volume_group_xrc_kms_key_id" {
  description = "(Optional) The OCID of the Vault service key which is the master encryption key for the volume's cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  default     = null
}

variable "core_volume_group_volume_group_replicas" {
  description = "(Optional) (Updatable) The list of volume group replicas that this volume group will be enabled to have in the specified destination availability domains."
  default     = []
}

variable "core_volume_group_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_volume_group_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Group * update - (Defaults to 20 minutes), when updating the Volume Group * delete - (Defaults to 20 minutes), when destroying the Volume Group"
  default     = {}
}

#-----------------------------------------------------------
# core volume group backup
#-----------------------------------------------------------
variable "enable_core_volume_group_backup" {
  description = "Enable core volume group backup usages"
  default     = false
}

variable "core_volume_group_backup_volume_group_id" {
  description = "(Required) The OCID of the volume group that needs to be backed up."
  default     = null
}

variable "core_volume_group_backup_compartment_id" {
  description = "(Optional) (Updatable) The OCID of the compartment that will contain the volume group backup. This parameter is optional, by default backup will be created in the same compartment and source volume group."
  default     = null
}

variable "core_volume_group_backup_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_volume_group_backup_type" {
  description = "(Optional) The type of backup to create. If omitted, defaults to incremental."
  default     = null
}

variable "core_volume_group_backup_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_volume_group_backup_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Group Backup * update - (Defaults to 20 minutes), when updating the Volume Group Backup * delete - (Defaults to 20 minutes), when destroying the Volume Group Backup"
  default     = {}
}

#-----------------------------------------------------------
# core volume backup
#-----------------------------------------------------------
variable "enable_core_volume_backup" {
  description = "Enable core volume backup usages"
  default     = false
}

variable "core_volume_backup_volume_id" {
  description = "(Optional) The OCID of the volume that needs to be backed up.**Note: To create the resource either volume_id or source_details is required to be set."
  default     = null
}

variable "core_volume_backup_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_volume_backup_kms_key_id" {
  description = "(Optional) (Updatable) The OCID of the Vault service key which is the master encryption key for the volume backup. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  default     = null
}

variable "core_volume_backup_type" {
  description = "(Optional) The type of backup to create. If omitted, defaults to INCREMENTAL. Supported values are 'FULL' or 'INCREMENTAL'."
  default     = null
}

variable "core_volume_backup_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_volume_backup_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Backup * update - (Defaults to 20 minutes), when updating the Volume Backup * delete - (Defaults to 20 minutes), when destroying the Volume Backup"
  default     = {}
}

#-----------------------------------------------------------
# core volume_ backup policy
#-----------------------------------------------------------
variable "enable_core_volume_backup_policy" {
  description = "Enable core volume backup policy usages"
  default     = false
}

variable "core_volume_backup_policy_compartment_id" {
  description = "(Required) The OCID of the compartment."
  default     = null
}

variable "core_volume_backup_policy_destination_region" {
  description = "(Optional) (Updatable) The paired destination region for copying scheduled backups to. Example: us-ashburn-1. See Region Pairs for details about paired regions."
  default     = null
}

variable "core_volume_backup_policy_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_volume_backup_policy_schedules" {
  description = "(Optional) (Updatable) The collection of schedules for the volume backup policy. See see Schedules in Policy-Based Backups for more information."
  default     = []
}

variable "core_volume_backup_policy_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_volume_backup_policy_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Backup Policy * update - (Defaults to 20 minutes), when updating the Volume Backup Policy * delete - (Defaults to 20 minutes), when destroying the Volume Backup Policy"
  default     = {}
}

#-----------------------------------------------------------
# core volume backup policy assignment
#-----------------------------------------------------------
variable "enable_core_volume_backup_policy_assignment" {
  description = "Enable core volume backup policy assignment usages"
  default     = false
}

variable "core_volume_backup_policy_assignment_asset_id" {
  description = "The OCID of the volume or volume group to assign the policy to."
  default     = ""
}

variable "core_volume_backup_policy_assignment_policy_id" {
  description = "The OCID of the volume backup policy to assign to the volume."
  default     = ""
}

variable "core_volume_backup_policy_assignment_xrc_kms_key_id" {
  description = "(Optional) The OCID of the Vault service key which is the master encryption key for the block / boot volume cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys."
  default     = null
}

variable "core_volume_backup_policy_assignment_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Backup Policy Assignment * update - (Defaults to 20 minutes), when updating the Volume Backup Policy Assignment * delete - (Defaults to 20 minutes), when destroying the Volume Backup Policy Assignment"
  default     = {}
}

#-----------------------------------------------------------
# core volume attachment
#-----------------------------------------------------------
variable "enable_core_volume_attachment" {
  description = "Enable core volume attachment usages"
  default     = false
}

variable "core_volume_attachment_attachment_type" {
  description = "(Required) The type of volume. The only supported values are 'iscsi' and 'paravirtualized'."
  default     = null
}

variable "core_volume_attachment_instance_id" {
  description = "(Required) The OCID of the instance."
  default     = null
}

variable "core_volume_attachment_volume_id" {
  description = "The OCID of the volume."
  default     = ""
}

variable "core_volume_attachment_device" {
  description = "(Optional) The device name. To retrieve a list of devices for a given instance, see ListInstanceDevices."
  default     = null
}

variable "core_volume_attachment_display_name" {
  description = "(Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_volume_attachment_encryption_in_transit_type" {
  description = "(Applicable when attachment_type=iscsi) Refer the top-level definition of encryptionInTransitType. The default value is NONE."
  default     = null
}

variable "core_volume_attachment_is_agent_auto_iscsi_login_enabled" {
  description = "(Applicable when attachment_type=iscsi) Whether to enable Oracle Cloud Agent to perform the iSCSI login and logout commands after the volume attach or detach operations for non multipath-enabled iSCSI attachments."
  default     = null
}

variable "core_volume_attachment_is_pv_encryption_in_transit_enabled" {
  description = "(Applicable when attachment_type=paravirtualized) Whether to enable in-transit encryption for the data volume's paravirtualized attachment. The default value is false."
  default     = null
}

variable "core_volume_attachment_is_read_only" {
  description = "(Optional) Whether the attachment was created in read-only mode."
  default     = null
}

variable "core_volume_attachment_is_shareable" {
  description = "(Optional) Whether the attachment should be created in shareable mode. If an attachment is created in shareable mode, then other instances can attach the same volume, provided that they also create their attachments in shareable mode. Only certain volume types can be attached in shareable mode. Defaults to false if not specified."
  default     = null
}

variable "core_volume_attachment_use_chap" {
  description = "(Applicable when attachment_type=iscsi) Whether to use CHAP authentication for the volume attachment. Defaults to false."
  default     = null
}

variable "core_volume_attachment_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Attachment * update - (Defaults to 20 minutes), when updating the Volume Attachment * delete - (Defaults to 20 minutes), when destroying the Volume Attachment"
  default     = {}
}
