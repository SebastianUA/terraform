# Work with CORE_VOLUME via terraform

A terraform module for making CORE_VOLUME.


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

module "core_volume" {
  source = "../../modules/core_volume"

  enable_core_volume         = true
  core_volume_compartment_id = ""

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `compartment_id` - (Required) (Updatable) The OCID of the compartment to (`default = null`)
- `tags` - Add additional tags (`default = {}`)
- `enable_core_boot_volume` - Enable core boot volume usages (`default = False`)
- `core_boot_volume_source_details` - (Required) - Set list of boot volume source details (`default = []`)
- `volume_source_details_type` - (Optional) Specifies the volume source details for a new Block volume. The volume source is either another Block volume in the same Availability Domain or a Block volume backup. This is an optional field. If not specified or set to null, the new Block volume will be empty. When specified, the new Block volume will contain data from the source volume or backup. (`default = []`)
- `core_boot_volume_availability_domain` - (Optional) The availability domain of the volume. Omissible for cloning a volume. The new volume will be created in the availability domain of the source volume. Example: Uocm:PHX-AD-1 (`default = null`)
- `core_boot_volume_backup_policy_id` - (Optional) If provided, specifies the ID of the boot volume backup policy to assign to the newly created boot volume. If omitted, no policy will be assigned. This field is deprecated. Use the oci_core_volume_backup_policy_assignments instead to assign a backup policy to a boot volume. (`default = null`)
- `core_boot_volume_cluster_placement_group_id` - (Optional) The clusterPlacementGroup Id of the volume for volume placement. (`default = null`)
- `core_boot_volume_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_boot_volume_is_auto_tune_enabled` - (Optional) (Updatable) Specifies whether the auto-tune performance is enabled for this boot volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune. (`default = null`)
- `core_boot_volume_kms_key_id` - (Optional) (Updatable) The OCID of the Vault service key to assign as the master encryption key for the boot volume. (`default = null`)
- `core_boot_volume_size_in_gbs` - (Optional) (Updatable) The size of the volume in GBs. (`default = null`)
- `core_boot_volume_vpus_per_gb` - (Optional) (Updatable) The number of volume performance units (VPUs) that will be applied to this volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information. (`default = null`)
- `core_boot_volume_xrc_kms_key_id` - (Optional) The OCID of the Vault service key which is the master encryption key for the boot volume cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys. (`default = null`)
- `core_boot_volume_boot_volume_replicas_deletion` - Set boot volume replicas deletion usages (`default = null`)
- `core_boot_volume_autotune_policies` - (Optional) (Updatable) The list of autotune policies to be enabled for this volume. (`default = []`)
- `core_boot_volume_boot_volume_replicas` - (Optional) (Updatable) The list of boot volume replicas to be enabled for this boot volume in the specified destination availability domains. (`default = []`)
- `core_boot_volume_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `core_boot_volume_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Boot Volume * update - (Defaults to 20 minutes), when updating the Boot Volume * delete - (Defaults to 20 minutes), when destroying the Boot Volume (`default = {}`)
- `enable_core_boot_volume_backup` - Enable core boot volume backup usages (`default = False`)
- `core_boot_volume_backup_boot_volume_id` - The OCID of the source volume backup. (`default = ""`)
- `core_boot_volume_backup_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_boot_volume_backup_kms_key_id` - (Optional) (Updatable) The OCID of the Vault service key which is the master encryption key for the volume backup. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys. (`default = null`)
- `core_boot_volume_backup_type` - (Optional) The type of backup to create. If omitted, defaults to incremental. Supported values are 'FULL' or 'INCREMENTAL'. (`default = null`)
- `core_boot_volume_backup_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_boot_volume_backup_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Boot Volume Backup * update - (Defaults to 20 minutes), when updating the Boot Volume Backup * delete - (Defaults to 20 minutes), when destroying the Boot Volume Backup (`default = {}`)
- `enable_core_volume` - Enable core volume usages (`default = False`)
- `core_volume_availability_domain` - (Optional) The availability domain of the volume. Omissible for cloning a volume. The new volume will be created in the availability domain of the source volume. Example: Uocm:PHX-AD-1 (`default = null`)
- `core_volume_cluster_placement_group_id` - (Optional) The clusterPlacementGroup Id of the volume for volume placement. (`default = null`)
- `core_volume_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_volume_is_auto_tune_enabled` - (Optional) (Updatable) Specifies whether the auto-tune performance is enabled for this volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune. (`default = null`)
- `core_volume_kms_key_id` - (Optional) (Updatable) The OCID of the Vault service key to assign as the master encryption key for the volume. (`default = null`)
- `core_volume_size_in_gbs` - (Optional) (Updatable) The size of the volume in GBs. (`default = null`)
- `core_volume_vpus_per_gb` - (Optional) (Updatable) The number of volume performance units (VPUs) that will be applied to this volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information. (`default = null`)
- `core_volume_xrc_kms_key_id` - (Optional) The OCID of the Vault service key which is the master encryption key for the block volume cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys. (`default = null`)
- `core_volume_block_volume_replicas_deletion` - Set the replicas deletion for volume (`default = null`)
- `core_volume_autotune_policies` - (Optional) (Updatable) The list of autotune policies to be enabled for this volume. (`default = []`)
- `core_volume_block_volume_replicas` - (Optional) (Updatable) The list of block volume replicas to be enabled for this volume in the specified destination availability domains. (`default = []`)
- `core_volume_source_details` - (Optional) Specifies the volume source details for a new Block volume. The volume source is either another Block volume in the same Availability Domain or a Block volume backup. This is an optional field. If not specified or set to null, the new Block volume will be empty. When specified, the new Block volume will contain data from the source volume or backup. (`default = []`)
- `core_volume_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_volume_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume * update - (Defaults to 20 minutes), when updating the Volume * delete - (Defaults to 20 minutes), when destroying the Volume (`default = {}`)
- `enable_core_volume_group` - Enable core volume group usages (`default = False`)
- `core_volume_group_availability_domain` - (Required) The availability domain of the volume group. (`default = null`)
- `core_volume_group_source_details` - (Required) Specifies the source for a volume group. (`default = []`)
- `core_volume_group_backup_policy_id` - (Optional) If provided, specifies the ID of the volume backup policy to assign to the newly created volume group. If omitted, no policy will be assigned. This field is deprecated. Use the oci_core_volume_backup_policy_assignments instead to assign a backup policy to a volume group. (`default = null`)
- `core_volume_group_cluster_placement_group_id` - (Optional) The clusterPlacementGroup Id of the volume group for volume group placement. (`default = null`)
- `core_volume_group_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_volume_group_volume_ids` - (Optional) (Updatable) Use this for update operation only. This field is not supported during creation. For create use volume_ids under source_details (`default = null`)
- `core_volume_group_xrc_kms_key_id` - (Optional) The OCID of the Vault service key which is the master encryption key for the volume's cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys. (`default = null`)
- `core_volume_group_volume_group_replicas` - (Optional) (Updatable) The list of volume group replicas that this volume group will be enabled to have in the specified destination availability domains. (`default = []`)
- `core_volume_group_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_volume_group_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Group * update - (Defaults to 20 minutes), when updating the Volume Group * delete - (Defaults to 20 minutes), when destroying the Volume Group (`default = {}`)
- `enable_core_volume_group_backup` - Enable core volume group backup usages (`default = False`)
- `core_volume_group_backup_volume_group_id` - (Required) The OCID of the volume group that needs to be backed up. (`default = null`)
- `core_volume_group_backup_compartment_id` - (Optional) (Updatable) The OCID of the compartment that will contain the volume group backup. This parameter is optional, by default backup will be created in the same compartment and source volume group. (`default = null`)
- `core_volume_group_backup_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_volume_group_backup_type` - (Optional) The type of backup to create. If omitted, defaults to incremental. (`default = null`)
- `core_volume_group_backup_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_volume_group_backup_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Group Backup * update - (Defaults to 20 minutes), when updating the Volume Group Backup * delete - (Defaults to 20 minutes), when destroying the Volume Group Backup (`default = {}`)
- `enable_core_volume_backup` - Enable core volume backup usages (`default = False`)
- `core_volume_backup_volume_id` - (Optional) The OCID of the volume that needs to be backed up.**Note: To create the resource either volume_id or source_details is required to be set. (`default = null`)
- `core_volume_backup_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_volume_backup_kms_key_id` - (Optional) (Updatable) The OCID of the Vault service key which is the master encryption key for the volume backup. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys. (`default = null`)
- `core_volume_backup_type` - (Optional) The type of backup to create. If omitted, defaults to INCREMENTAL. Supported values are 'FULL' or 'INCREMENTAL'. (`default = null`)
- `core_volume_backup_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_volume_backup_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Backup * update - (Defaults to 20 minutes), when updating the Volume Backup * delete - (Defaults to 20 minutes), when destroying the Volume Backup (`default = {}`)
- `enable_core_volume_backup_policy` - Enable core volume backup policy usages (`default = False`)
- `core_volume_backup_policy_destination_region` - (Optional) (Updatable) The paired destination region for copying scheduled backups to. Example: us-ashburn-1. See Region Pairs for details about paired regions. (`default = null`)
- `core_volume_backup_policy_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_volume_backup_policy_schedules` - (Optional) (Updatable) The collection of schedules for the volume backup policy. See see Schedules in Policy-Based Backups for more information. (`default = []`)
- `core_volume_backup_policy_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_volume_backup_policy_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Backup Policy * update - (Defaults to 20 minutes), when updating the Volume Backup Policy * delete - (Defaults to 20 minutes), when destroying the Volume Backup Policy (`default = {}`)
- `enable_core_volume_backup_policy_assignment` - Enable core volume backup policy assignment usages (`default = False`)
- `core_volume_backup_policy_assignment_asset_id` - The OCID of the volume or volume group to assign the policy to. (`default = ""`)
- `core_volume_backup_policy_assignment_policy_id` - The OCID of the volume backup policy to assign to the volume. (`default = ""`)
- `core_volume_backup_policy_assignment_xrc_kms_key_id` - (Optional) The OCID of the Vault service key which is the master encryption key for the block / boot volume cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys. (`default = null`)
- `core_volume_backup_policy_assignment_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Backup Policy Assignment * update - (Defaults to 20 minutes), when updating the Volume Backup Policy Assignment * delete - (Defaults to 20 minutes), when destroying the Volume Backup Policy Assignment (`default = {}`)
- `enable_core_volume_attachment` - Enable core volume attachment usages (`default = False`)
- `core_volume_attachment_attachment_type` - (Required) The type of volume. The only supported values are 'iscsi' and 'paravirtualized'. (`default = null`)
- `core_volume_attachment_instance_id` - (Required) The OCID of the instance. (`default = null`)
- `core_volume_attachment_volume_id` - The OCID of the volume. (`default = ""`)
- `core_volume_attachment_device` - (Optional) The device name. To retrieve a list of devices for a given instance, see ListInstanceDevices. (`default = null`)
- `core_volume_attachment_display_name` - (Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_volume_attachment_encryption_in_transit_type` - (Applicable when attachment_type=iscsi) Refer the top-level definition of encryptionInTransitType. The default value is NONE. (`default = null`)
- `core_volume_attachment_is_agent_auto_iscsi_login_enabled` - (Applicable when attachment_type=iscsi) Whether to enable Oracle Cloud Agent to perform the iSCSI login and logout commands after the volume attach or detach operations for non multipath-enabled iSCSI attachments. (`default = null`)
- `core_volume_attachment_is_pv_encryption_in_transit_enabled` - (Applicable when attachment_type=paravirtualized) Whether to enable in-transit encryption for the data volume's paravirtualized attachment. The default value is false. (`default = null`)
- `core_volume_attachment_is_read_only` - (Optional) Whether the attachment was created in read-only mode. (`default = null`)
- `core_volume_attachment_is_shareable` - (Optional) Whether the attachment should be created in shareable mode. If an attachment is created in shareable mode, then other instances can attach the same volume, provided that they also create their attachments in shareable mode. Only certain volume types can be attached in shareable mode. Defaults to false if not specified. (`default = null`)
- `core_volume_attachment_use_chap` - (Applicable when attachment_type=iscsi) Whether to use CHAP authentication for the volume attachment. Defaults to false. (`default = null`)
- `core_volume_attachment_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Volume Attachment * update - (Defaults to 20 minutes), when updating the Volume Attachment * delete - (Defaults to 20 minutes), when destroying the Volume Attachment (`default = {}`)

## Module Output Variables
----------------------
- `core_boot_volume_compartment_id` - The OCID of the compartment that contains the boot volume.
- `core_boot_volume_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_boot_volume_id` - The boot volume's Oracle ID (OCID).
- `core_boot_volume_cluster_placement_group_id` - The clusterPlacementGroup Id of the volume for volume placement.
- `core_boot_volume_availability_domain` - The availability domain of the boot volume. Example: Uocm:PHX-AD-1
- `core_boot_volume_boot_volume_replicas` - The list of boot volume replicas of this boot volume
- `core_boot_volume_auto_tuned_vpus_per_gb` - The number of Volume Performance Units per GB that this boot volume is effectively tuned to.
- `core_boot_volume_autotune_policies` - The list of autotune policies enabled for this volume.
- `core_boot_volume_volume_group_id` - The OCID of the source volume group.
- `core_boot_volume_vpus_per_gb` - The number of volume performance units (VPUs) that will be applied to this boot volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information.
- `core_boot_volume_state` - The current state of a boot volume.
- `core_boot_volume_image_id` - The image OCID used to create the boot volume.
- `core_boot_volume_is_auto_tune_enabled` - Specifies whether the auto-tune performance is enabled for this boot volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune.
- `core_boot_volume_is_hydrated` - Specifies whether the boot volume's data has finished copying from the source boot volume or boot volume backup.
- `core_boot_volume_kms_key_id` - The OCID of the Vault service master encryption key assigned to the boot volume.
- `core_boot_volume_size_in_gbs` - The size of the boot volume in GBs.
- `core_boot_volume_size_in_mbs` - The size of the volume in MBs. The value must be a multiple of 1024. This field is deprecated. Please use size_in_gbs.
- `core_boot_volume_source_details` - Output block of source details for Boot Volume
- `core_boot_volume_backup_id` - The OCID of the boot volume backup.
- `core_boot_volume_backup_image_id` - The image OCID used to create the boot volume the backup is taken from.
- `core_boot_volume_backup_kms_key_id` - The OCID of the Vault service master encryption assigned to the boot volume backup. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys.
- `core_boot_volume_backup_size_in_gbs` - The size of the boot volume, in GBs.
- `core_boot_volume_backup_source_boot_volume_backup_id` - The OCID of the source boot volume backup.
- `core_boot_volume_backup_source_type` - Specifies whether the backup was created manually, or via scheduled backup policy.
- `core_boot_volume_backup_state` - The current state of a boot volume backup.
- `core_boot_volume_backup_type` - The type of a volume backup. Supported values are 'FULL' or 'INCREMENTAL'.
- `core_boot_volume_backup_unique_size_in_gbs` - The size used by the backup, in GBs. It is typically smaller than sizeInGBs, depending on the space consumed on the boot volume and whether the backup is full or incremental.
- `core_boot_volume_backup_boot_volume_id` - The OCID of the boot volume.
- `core_boot_volume_backup_compartment_id` - The OCID of the compartment that contains the boot volume backup.
- `core_boot_volume_backup_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_boot_volume_backup_expiration_time` - The date and time the volume backup will expire and be automatically deleted. Format defined by RFC3339. This parameter will always be present for backups that were created automatically by a scheduled-backup policy. For manually created backups, it will be absent, signifying that there is no expiration time and the backup will last forever until manually deleted.
- `core_volume_id` - The OCID of the volume.
- `core_volume_is_auto_tune_enabled` - Specifies whether the auto-tune performance is enabled for this volume. This field is deprecated. Use the DetachedVolumeAutotunePolicy instead to enable the volume for detached autotune.
- `core_volume_is_hydrated` - Specifies whether the cloned volume's data has finished copying from the source volume or backup.
- `core_volume_kms_key_id` - The OCID of the Vault service key which is the master encryption key for the volume.
- `core_volume_size_in_gbs` - The size of the volume in GBs.
- `core_volume_size_in_mbs` - The size of the volume in MBs. This field is deprecated. Use sizeInGBs instead.
- `core_volume_source_details` - Output of source details
- `core_volume_cluster_placement_group_id` - The clusterPlacementGroup Id of the volume for volume placement.
- `core_volume_compartment_id` - The OCID of the compartment that contains the volume.
- `core_volume_availability_domain` - The availability domain of the volume. Example: Uocm:PHX-AD-1
- `core_volume_block_volume_replicas` - The list of block volume replicas of this volume.
- `core_volume_auto_tuned_vpus_per_gb` - The number of Volume Performance Units per GB that this volume is effectively tuned to.
- `core_volume_autotune_policies` - The list of autotune policies enabled for this volume.
- `core_volume_state` - The current state of a volume.
- `core_volume_volume_group_id` - The OCID of the source volume group.
- `core_volume_vpus_per_gb` - The number of volume performance units (VPUs) that will be applied to this volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information.
- `core_volume_group_id` - The OCID for the volume group.
- `core_volume_group_volume_ids` - OCIDs for the current volumes in this volume group.
- `core_volume_group_state` - The current state of a volume group.
- `core_volume_group_source_details` - Specifies the source for a volume group.
- `core_volume_group_is_hydrated` - Specifies whether the newly created cloned volume group's data has finished copying from the source volume group or backup.
- `core_volume_group_size_in_gbs` - The aggregate size of the volume group in GBs.
- `core_volume_group_size_in_mbs` - The aggregate size of the volume group in MBs.
- `core_volume_group_availability_domain` - The availability domain of the volume group.
- `core_volume_group_compartment_id` - The OCID of the compartment that contains the volume group.
- `core_volume_group_display_name` - user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_volume_group_compartment_id` - The OCID of the compartment that contains the volume group backup.
- `core_volume_group_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_volume_group_expiration_time` - The date and time the volume group backup will expire and be automatically deleted. Format defined by RFC3339. This parameter will always be present for volume group backups that were created automatically by a scheduled-backup policy. For manually created volume group backups, it will be absent, signifying that there is no expiration time and the backup will last forever until manually deleted.
- `core_volume_group_id` - The OCID of the volume group backup.
- `core_volume_group_size_in_gbs` - The aggregate size of the volume group backup, in GBs.
- `core_volume_group_size_in_mbs` - The aggregate size of the volume group backup, in MBs.
- `core_volume_group_source_type` - Specifies whether the volume group backup was created manually, or via scheduled backup policy.
- `core_volume_group_source_volume_group_backup_id` - The OCID of the source volume group backup.
- `core_volume_group_state` - The current state of a volume group backup.
- `core_volume_group_time_request_received` - The date and time the request to create the volume group backup was received. Format defined by RFC3339.
- `core_volume_group_type` - The type of backup.
- `core_volume_group_unique_size_in_gbs` - The aggregate size used by the volume group backup, in GBs. It is typically smaller than size_in_gbs, depending on the space consumed on the volume group and whether the volume backup is full or incremental.
- `core_volume_group_unique_size_in_mbs` - The aggregate size used by the volume group backup, in MBs. It is typically smaller than size_in_mbs, depending on the space consumed on the volume group and whether the volume backup is full or incremental.
- `core_volume_group_volume_backup_ids` - OCIDs for the volume backups in this volume group backup.
- `core_volume_group_volume_group_id` - The OCID of the source volume group.
- `core_volume_backup_compartment_id` - The OCID of the compartment that contains the volume backup.
- `core_volume_backup_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_volume_backup_expiration_time` - The date and time the volume backup will expire and be automatically deleted. Format defined by RFC3339. This parameter will always be present for backups that were created automatically by a scheduled-backup policy. For manually created backups, it will be absent, signifying that there is no expiration time and the backup will last forever until manually deleted.
- `core_volume_backup_id` - The OCID of the volume backup.
- `core_volume_backup_kms_key_id` - The OCID of the Vault service key which is the master encryption key for the volume backup. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys.
- `core_volume_backup_size_in_gbs` - The size of the volume, in GBs.
- `core_volume_backup_size_in_mbs` - The size of the volume in MBs. The value must be a multiple of 1024. This field is deprecated. Please use size_in_gbs.
- `core_volume_backup_source_type` - Specifies whether the backup was created manually, or via scheduled backup policy.
- `core_volume_backup_source_volume_backup_id` - The OCID of the source volume backup.
- `core_volume_backup_state` - The current state of a volume backup.
- `core_volume_backup_time_request_received` - The date and time the request to create the volume backup was received. Format defined by [RFC3339]https://tools.ietf.org/html/rfc3339.
- `core_volume_backup_type` - The type of a volume backup. Supported values are 'FULL' or 'INCREMENTAL'.
- `core_volume_backup_unique_size_in_gbs` - The size used by the backup, in GBs. It is typically smaller than sizeInGBs, depending on the space consumed on the volume and whether the backup is full or incremental.
- `core_volume_backup_unique_size_in_mbs` - The size used by the backup, in MBs. It is typically smaller than sizeInMBs, depending on the space consumed on the volume and whether the backup is full or incremental. This field is deprecated. Please use uniqueSizeInGBs.
- `core_volume_backup_volume_id` - The OCID of the volume.
- `core_volume_backup_policy_compartment_id` - The OCID of the compartment that contains the volume backup.
- `core_volume_backup_policy_destination_region` - The paired destination region for copying scheduled backups to. Example us-ashburn-1. See Region Pairs for details about paired regions.
- `core_volume_backup_policy_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_volume_backup_policy_id` - The OCID of the volume backup policy.
- `core_volume_backup_policy_schedules` - The collection of schedules that this policy will apply.
- `core_volume_backup_policy_assignment_asset_id` - The OCID of the volume or volume group the policy has been assigned to.
- `core_volume_backup_policy_assignment_id` - The OCID of the volume backup policy assignment.
- `core_volume_backup_policy_assignment_policy_id` - The OCID of the volume backup policy that has been assigned to the volume or volume group. For a volume group, only the user defined policy is allowed to use. For more information, see Policy-Based Backups.
- `core_volume_backup_policy_assignment_xrc_kms_key_id` - The OCID of the Vault service key which is the master encryption key for the block / boot volume cross region backups, which will be used in the destination region to encrypt the backup's encryption keys. For more information about the Vault service and encryption keys, see Overview of Vault service and Using Keys.
- `core_volume_attachment_port` - The volume's iSCSI port, usually port 860 or 3260. Example: 3260
- `core_volume_attachment_state` - The current state of the volume attachment.
- `core_volume_attachment_volume_id` - The OCID of the volume.
- `core_volume_attachment_is_multipath` - Whether the Iscsi or Paravirtualized attachment is multipath or not, it is not applicable to NVMe attachment.
- `core_volume_attachment_is_pv_encryption_in_transit_enabled` - Whether in-transit encryption for the data volume's paravirtualized attachment is enabled or not.
- `core_volume_attachment_is_read_only` - Whether the attachment was created in read-only mode.
- `core_volume_attachment_iscsi_login_state` - The iscsi login state of the volume attachment. For a Iscsi volume attachment, all iscsi sessions need to be all logged-in or logged-out to be in logged-in or logged-out state.
- `core_volume_attachment_is_volume_created_during_launch` - Flag indicating if this volume was created for the customer as part of a simplified launch. Used to determine whether the volume requires deletion on instance termination.
- `core_volume_attachment_iscsi_login_state` - The iscsi login state of the volume attachment. For a Iscsi volume attachment, all iscsi sessions need to be all logged-in or logged-out to be in logged-in or logged-out state.
- `core_volume_attachment_chap_secret` - The Challenge-Handshake-Authentication-Protocol (CHAP) secret valid for the associated CHAP user name.
- `core_volume_attachment_chap_username` - The volume's system-generated Challenge-Handshake-Authentication-Protocol (CHAP) user name. See RFC 1994 for more on CHAP. Example: ocid1.volume.oc1.phx.<unique_ID>
- `core_volume_attachment_compartment_id` - The OCID of the compartment.
- `core_volume_attachment_device` - The device name.
- `core_volume_attachment_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_volume_attachment_encryption_in_transit_type` - Refer the top-level definition of encryptionInTransitType. The default value is NONE.
- `core_volume_attachment_id` - The OCID of the volume attachment.
- `core_volume_attachment_instance_id` - The OCID of the instance the volume is attached to.
- `core_volume_attachment_ipv4` - The volume's iSCSI IP address. Example: 169.254.0.2
- `core_volume_attachment_iqn` - The target volume's iSCSI Qualified Name in the format defined by RFC 3720. Example: iqn.2015-12.us.oracle.com:<CHAP_username>
- `core_volume_attachment_is_agent_auto_iscsi_login_enabled` - Whether Oracle Cloud Agent is enabled perform the iSCSI login and logout commands after the volume attach or detach operations for non multipath-enabled iSCSI attachments.
- `core_volume_attachment_attachment_type` - The type of volume attachment.
- `core_volume_attachment_availability_domain` - The availability domain of an instance. Example: Uocm:PHX-AD-1


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
