# Work with FILE_STORAGE via terraform

A terraform module for making FILE_STORAGE.


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

module "file_storage" {
  source = "../../modules/file_storage"

  enable_file_storage_file_system = true

  file_storage_file_system_availability_domain = ""
  file_storage_file_system_compartment_id      = ""

  file_storage_file_system_display_name = ""

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_file_storage_file_system` - Enable file storage file system usages (`default = False`)
- `file_storage_file_system_availability_domain` - (Required) The availability domain to create the file system in. Example: Uocm:PHX-AD-1 (`default = null`)
- `file_storage_file_system_compartment_id` - (Required) (Updatable) The OCID of the compartment to create the file system in. (`default = null`)
- `file_storage_file_system_clone_attach_status` - (Optional) Specifies whether the clone file system is attached to its parent file system. If the value is set to 'DETACH', then the file system will be created, which is deep copied from the snapshot specified by sourceSnapshotId, else will remain attached to its parent. (`default = null`)
- `file_storage_file_system_display_name` - (Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My file system (`default = ""`)
- `file_storage_file_system_filesystem_snapshot_policy_id` - (Optional) (Updatable) The OCID of the associated file system snapshot policy, which controls the frequency of snapshot creation and retention period of the taken snapshots. (`default = ""`)
- `file_storage_file_system_kms_key_id` - (Optional) (Updatable) The OCID of KMS key used to encrypt the encryption keys associated with this file system. May be unset as a blank or deleted from the configuration to remove the KMS key. (`default = null`)
- `file_storage_file_system_source_snapshot_id` - (Optional) The OCID of the snapshot used to create a cloned file system. See Cloning a File System. (`default = null`)
- `file_storage_file_system_locks` - (Optional) Locks associated with this resource. (`default = []`)
- `file_storage_file_system_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'} (`default = {}`)
- `file_storage_file_system_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the File System * update - (Defaults to 20 minutes), when updating the File System * delete - (Defaults to 20 minutes), when destroying the File System (`default = {}`)
- `enable_file_storage_filesystem_snapshot_policy` - Enable file storage filesystem snapshot policy usages (`default = False`)
- `file_storage_filesystem_snapshot_policy_availability_domain` - (Required) The availability domain that the file system snapshot policy is in. Example: Uocm:PHX-AD-1 (`default = null`)
- `file_storage_filesystem_snapshot_policy_compartment_id` - (Required) (Updatable) The OCID of the compartment that contains the file system snapshot policy. (`default = null`)
- `file_storage_filesystem_snapshot_policy_display_name` - (Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: policy1 (`default = ""`)
- `file_storage_filesystem_snapshot_policy_policy_prefix` - (Optional) (Updatable) The prefix to apply to all snapshots created by this policy. Example: acme (`default = null`)
- `file_storage_filesystem_snapshot_policy_locks` - (Optional) Locks associated with this resource. (`default = []`)
- `file_storage_filesystem_snapshot_policy_schedules` - (Optional) (Updatable) The list of associated snapshot schedules. A maximum of 10 schedules can be associated with a policy. (`default = []`)
- `file_storage_filesystem_snapshot_policy_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `file_storage_filesystem_snapshot_policy_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Filesystem Snapshot Policy * update - (Defaults to 20 minutes), when updating the Filesystem Snapshot Policy * delete - (Defaults to 20 minutes), when destroying the Filesystem Snapshot Policy (`default = {}`)
- `enable_file_storage_mount_target` - Enable file storage mount target usages (`default = False`)
- `file_storage_mount_target_availability_domain` - (Required) The availability domain in which to create the mount target. Example: Uocm:PHX-AD-1 (`default = null`)
- `file_storage_mount_target_compartment_id` - (Required) (Updatable) The OCID of the compartment in which to create the mount target. (`default = null`)
- `file_storage_mount_target_subnet_id` - (Required) The OCID of the subnet in which to create the mount target. (`default = null`)
- `file_storage_mount_target_display_name` - (Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My mount target (`default = ""`)
- `file_storage_mount_target_hostname_label` - (Optional) The hostname for the mount target's IP address, used for DNS resolution. The value is the hostname portion of the private IP address's fully qualified domain name (FQDN). For example, files-1 in the FQDN files-1.subnet123.vcn1.oraclevcn.com. Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123. (`default = null`)
- `file_storage_mount_target_idmap_type` - (Optional) (Updatable) The method used to map a Unix UID to secondary groups, if any. (`default = null`)
- `file_storage_mount_target_ip_address` - (Optional) A private IP address of your choice. Must be an available IP address within the subnet's CIDR. If you don't specify a value, Oracle automatically assigns a private IP address from the subnet. Example: 10.0.3.3 (`default = null`)
- `file_storage_mount_target_is_lock_override` - (Optional) (Updatable) Whether to override locks (if any exist). (`default = null`)
- `file_storage_mount_target_nsg_ids` - (Optional) (Updatable) A list of Network Security Group OCIDs associated with this mount target. A maximum of 5 is allowed. Setting this to an empty array after the list is created removes the mount target from all NSGs. For more information about NSGs, see Security Rules. (`default = null`)
- `file_storage_mount_target_requested_throughput` - (Optional) (Updatable) Throughput for mount target in Gbps. Currently only 1 Gbps of requestedThroughput is supported during create MountTarget. Available shapes and corresponding throughput are listed at Mount Target Performance. (`default = null`)
- `file_storage_mount_target_kerberos` - (Optional) (Updatable) Kerberos details needed to create configuration. (`default = {}`)
- `file_storage_mount_target_ldap_idmap` - (Optional) (Updatable) Mount target details about the LDAP ID mapping configuration. (`default = {}`)
- `file_storage_mount_target_locks` - (Optional) Locks associated with this resource. (`default = []`)
- `file_storage_mount_target_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `file_storage_mount_target_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Mount Target * update - (Defaults to 20 minutes), when updating the Mount Target * delete - (Defaults to 20 minutes), when destroying the Mount Target (`default = {}`)
- `enable_file_storage_outbound_connector` - Enable file storage outbound connector usages (`default = False`)
- `file_storage_outbound_connector_availability_domain` - (Required) The availability domain the outbound connector is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1 (`default = null`)
- `file_storage_outbound_connector_bind_distinguished_name` - (Required) The LDAP Distinguished Name of the bind account. (`default = null`)
- `file_storage_outbound_connector_compartment_id` - (Required) (Updatable) The OCID of the compartment that contains the outbound connector. (`default = null`)
- `file_storage_outbound_connector_connector_type` - (Required) The account type of this outbound connector. (`default = null`)
- `file_storage_outbound_connector_endpoints` - (Required) Array of server endpoints to use when connecting with the LDAP bind account. (`default = []`)
- `file_storage_outbound_connector_display_name` - (Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My outbound connector (`default = ""`)
- `file_storage_outbound_connector_password_secret_id` - (Optional) The OCID of the password for the LDAP bind account in the Vault. (`default = null`)
- `file_storage_outbound_connector_password_secret_version` - (Optional) Version of the password secret in the Vault to use. (`default = null`)
- `file_storage_outbound_connector_locks` - (Optional) Locks associated with this resource. (`default = []`)
- `file_storage_outbound_connector_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `file_storage_outbound_connector_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Outbound Connector * update - (Defaults to 20 minutes), when updating the Outbound Connector * delete - (Defaults to 20 minutes), when destroying the Outbound Connector (`default = {}`)
- `enable_file_storage_replication` - Enable file storage replication usages (`default = False`)
- `file_storage_replication_compartment_id` - (Required) (Updatable) The OCID of the compartment that contains the replication. (`default = null`)
- `file_storage_replication_source_id` - (Required) The OCID of the source file system. (`default = null`)
- `file_storage_replication_target_id` - (Required) The OCID of the target file system. (`default = null`)
- `file_storage_replication_display_name` - (Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. An associated replication target will also created with the same displayName (`default = ""`)
- `file_storage_replication_replication_interval` - (Optional) (Updatable) Duration in minutes between replication snapshots. (`default = null`)
- `file_storage_replication_locks` - (Optional) Locks associated with this resource. (`default = []`)
- `file_storage_replication_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `file_storage_replication_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Replication * update - (Defaults to 20 minutes), when updating the Replication * delete - (Defaults to 20 minutes), when destroying the Replication (`default = {}`)
- `enable_file_storage_snapshot` - Enable file storage snapshot usages (`default = False`)
- `file_storage_snapshot_file_system_id` - The OCID of the file system to take a snapshot of. (`default = ""`)
- `file_storage_snapshot_name` - Name of the snapshot. This value is immutable. It must also be unique with respect to all other non-DELETED snapshots on the associated file system. (`default = ""`)
- `file_storage_snapshot_expiration_time` - (Optional) (Updatable) The time when this snapshot will be deleted. (`default = null`)
- `file_storage_snapshot_locks` - (Optional) Locks associated with this resource. (`default = []`)
- `file_storage_snapshot_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `file_storage_snapshot_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Snapshot * update - (Defaults to 20 minutes), when updating the Snapshot * delete - (Defaults to 20 minutes), when destroying the Snapshot (`default = {}`)
- `enable_file_storage_export` - Enable file storage export usages (`default = False`)
- `file_storage_export_export_set_id` - The OCID of this export's export set. (`default = ""`)
- `file_storage_export_file_system_id` - The OCID of this export's file system. (`default = ""`)
- `file_storage_export_path` - (Required) Path used to access the associated file system. (`default = null`)
- `file_storage_export_is_idmap_groups_for_sys_auth` - (Optional) (Updatable) Whether or not the export should use ID mapping for Unix groups rather than the group list provided within an NFS request's RPC header. When this flag is true the Unix UID from the RPC header is used to retrieve the list of secondary groups from a the ID mapping subsystem. The primary GID is always taken from the RPC header. If ID mapping is not configured, incorrectly configured, unavailable, or cannot be used to determine a list of secondary groups then an empty secondary group list is used for authorization. If the number of groups exceeds the limit of 256 groups, the list retrieved from LDAP is truncated to the first 256 groups read. (`default = null`)
- `file_storage_export_export_options` - (Optional) (Updatable) Export options for the new export. For exports of mount targets with IPv4 address, if client options are left unspecified, client options would default to (`default = []`)
- `file_storage_export_locks` - (Optional) Locks associated with this resource. (`default = []`)
- `file_storage_export_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Export * update - (Defaults to 20 minutes), when updating the Export * delete - (Defaults to 20 minutes), when destroying the Export (`default = {}`)
- `enable_file_storage_export_set` - Enable file storage export set usages (`default = False`)
- `file_storage_export_set_mount_target_id` - (Updatable) The OCID of the mount target that the export set is associated with (`default = ""`)
- `file_storage_export_set_display_name` - (Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My export set (`default = ""`)
- `file_storage_export_set_max_fs_stat_bytes` - (Optional) (Updatable) Controls the maximum tbytes, fbytes, and abytes, values reported by NFS FSSTAT calls through any associated mount targets. This is an advanced feature. For most applications, use the default value. The tbytes value reported by FSSTAT will be maxFsStatBytes. The value of fbytes and abytes will be maxFsStatBytes minus the metered size of the file system. If the metered size is larger than maxFsStatBytes, then fbytes and abytes will both be '0'. (`default = null`)
- `file_storage_export_set_max_fs_stat_files` - (Optional) (Updatable) Controls the maximum tfiles, ffiles, and afiles values reported by NFS FSSTAT calls through any associated mount targets. This is an advanced feature. For most applications, use the default value. The tfiles value reported by FSSTAT will be maxFsStatFiles. The value of ffiles and afiles will be maxFsStatFiles minus the metered size of the file system. If the metered size is larger than maxFsStatFiles, then ffiles and afiles will both be '0'. (`default = null`)
- `file_storage_export_set_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Export Set * update - (Defaults to 20 minutes), when updating the Export Set * delete - (Defaults to 20 minutes), when destroying the Export Set (`default = {}`)

## Module Output Variables
----------------------
- `file_storage_file_system_id` - The OCID of the file system.
- `file_storage_file_system_is_clone_parent` - Specifies whether the file system has been cloned. See Cloning a File System.
- `file_storage_file_system_is_hydrated` - Specifies whether the data has finished copying from the source to the clone. Hydration can take up to several hours to complete depending on the size of the source. The source and clone remain available during hydration, but there may be some performance impact. See Cloning a File System.
- `file_storage_file_system_is_targetable` - Specifies whether the file system can be used as a target file system for replication. The system sets this value to true if the file system is unexported, hasn't yet been specified as a target file system in any replication resource, and has no user snapshots. After the file system has been specified as a target in a replication, or if the file system contains user snapshots, the system sets this value to false. For more information, see Using Replication.
- `file_storage_file_system_kms_key_id` - The OCID of the KMS key used to encrypt the encryption keys associated with this file system.
- `file_storage_file_system_display_name` - A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My file system
- `file_storage_file_system_filesystem_snapshot_policy_id` - The OCID of the associated file system snapshot policy, which controls the frequency of snapshot creation and retention period of the taken snapshots.
- `file_storage_file_system_availability_domain` - The availability domain the file system is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1
- `file_storage_file_system_clone_attach_status` - Specifies whether the file system is attached to its parent file system.
- `file_storage_file_system_clone_count` - Specifies the total number of children of a file system.
- `file_storage_file_system_compartment_id` - The OCID of the compartment that contains the file system.
- `file_storage_file_system_state` - The current state of the file system.
- `file_storage_file_system_replication_target_id` - The OCID of the replication target associated with the file system. Empty if the file system is not being used as target in a replication.
- `file_storage_filesystem_snapshot_policy_id` - The OCID of the file system snapshot policy.
- `file_storage_filesystem_snapshot_policy_availability_domain` - The availability domain that the file system snapshot policy is in. May be unset using a blank or NULL value. Example: Uocm:PHX-AD-2
- `file_storage_filesystem_snapshot_policy_compartment_id` - The OCID of the compartment that contains the file system snapshot policy.
- `file_storage_filesystem_snapshot_policy_display_name` - A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My Filesystem Snapshot Policy
- `file_storage_filesystem_snapshot_policy_state` - The current state of this file system snapshot policy.
- `file_storage_filesystem_snapshot_policy_policy_prefix` - The prefix to apply to all snapshots created by this policy. Example: acme
- `file_storage_filesystem_snapshot_policy_locks` - Locks associated with this resource.
- `file_storage_filesystem_snapshot_policy_schedules` - The list of associated snapshot schedules. A maximum of 10 schedules can be associated with a policy.
- `file_storage_mount_target_id` - The OCID of the mount target.
- `file_storage_mount_target_idmap_type` - The method used to map a Unix UID to secondary groups. If NONE, the mount target will not use the Unix UID for ID mapping.
- `file_storage_mount_target_kerberos` - Allows administrator to configure a mount target to interact with the administrator's Kerberos infrastructure.
- `file_storage_mount_target_display_name` - A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My mount target
- `file_storage_mount_target_export_set_id` - The OCID of the associated export set. Controls what file systems will be exported through Network File System (NFS) protocol on this mount target.
- `file_storage_mount_target_ldap_idmap` - Mount target details about the LDAP ID mapping configuration
- `file_storage_mount_target_lifecycle_details` - Additional information about the current 'lifecycleState'.
- `file_storage_mount_target_locks` - Locks associated with this resource.
- `file_storage_mount_target_state` - The current state of the mount target.
- `file_storage_mount_target_subnet_id` - The OCID of the subnet the mount target is in.
- `file_storage_mount_target_nsg_ids` - A list of Network Security Group OCIDs associated with this mount target. A maximum of 5 is allowed. Setting this to an empty array after the list is created removes the mount target from all NSGs. For more information about NSGs, see Security Rules.
- `file_storage_mount_target_observed_throughput` - Current billed throughput for mount target in Gbps. This corresponds to shape of mount target. Available shapes and corresponding throughput are listed at Mount Target Performance.
- `file_storage_mount_target_private_ip_ids` - The OCIDs of the private IP addresses associated with this mount target.
- `file_storage_mount_target_availability_domain` - The availability domain the mount target is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1
- `file_storage_mount_target_compartment_id` - The OCID of the compartment that contains the mount target.
- `file_storage_outbound_connector_id` - The OCID of the outbound connector.
- `file_storage_outbound_connector_locks` - Locks associated with this resource
- `file_storage_outbound_connector_availability_domain` - The availability domain the outbound connector is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1
- `file_storage_outbound_connector_bind_distinguished_name` - The LDAP Distinguished Name of the account.
- `file_storage_outbound_connector_compartment_id` - The OCID of the compartment that contains the outbound connector.
- `file_storage_outbound_connector_connector_type` - The account type of this outbound connector.
- `file_storage_outbound_connector_display_name` - A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My outbound connector
- `file_storage_outbound_connector_endpoints` - Array of server endpoints to use when connecting with the LDAP bind account.
- `file_storage_outbound_connector_password_secret_id` - The OCID of the password for the LDAP bind account in the Vault.
- `file_storage_outbound_connector_password_secret_version` - Version of the password secret in the Vault to use.
- `file_storage_outbound_connector_state` - The current state of this outbound connector.
- `file_storage_replication_id` - The OCID of the replication.
- `file_storage_replication_availability_domain` - The availability domain the replication is in. The replication must be in the same availability domain as the source file system. Example: Uocm:PHX-AD-1
- `file_storage_replication_compartment_id` - The OCID of the compartment that contains the replication.
- `file_storage_replication_delta_progress` - Percentage progress of the current replication cycle.
- `file_storage_replication_delta_status` - The current state of the snapshot during replication operations.
- `file_storage_replication_display_name` - A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My replication
- `file_storage_replication_recovery_point_time` - The snapshotTime of the most recent recoverable replication snapshot in RFC 3339 timestamp format. Example: 2021-04-04T20:01:29.100Z
- `file_storage_replication_replication_interval` - Duration in minutes between replication snapshots.
- `file_storage_replication_replication_target_id` - The OCID of the ReplicationTarget.
- `file_storage_replication_source_id` - The OCID of the source file system.
- `file_storage_replication_state` - The current state of this replication. This resource can be in a FAILED state if replication target is deleted instead of the replication resource.
- `file_storage_replication_target_id` - The OCID of the target file system.
- `file_storage_replication_locks` - Locks associated with this resource
- `file_storage_snapshot_id` - The OCID of the snapshot.
- `file_storage_snapshot_is_clone_source` - Specifies whether the snapshot has been cloned. See Cloning a File System.
- `file_storage_snapshot_lifecycle_details` - Additional information about the current lifecycleState.
- `file_storage_snapshot_locks` - Locks associated with this resource.
- `file_storage_snapshot_expiration_time` - The time when this snapshot will be deleted.
- `file_storage_snapshot_file_system_id` - The OCID of the file system from which the snapshot was created.
- `file_storage_snapshot_filesystem_snapshot_policy_id` - The OCID of the file system snapshot policy that created this snapshot.
- `file_storage_snapshot_name` - Name of the snapshot. This value is immutable.
- `file_storage_snapshot_provenance_id` - An OCID identifying the parent from which this snapshot was cloned. If this snapshot was not cloned, then the provenanceId is the same as the snapshot id value. If this snapshot was cloned, then the provenanceId value is the parent's provenanceId. See Cloning a File System.
- `file_storage_snapshot_snapshot_type` - Specifies the generation type of the snapshot.
- `file_storage_snapshot_state` - The current state of the snapshot.
- `file_storage_export_id` - The OCID of this export.
- `file_storage_export_export_set_id` - The OCID of this export's export set.
- `file_storage_export_file_system_id` - The OCID of this export's file system.
- `file_storage_export_is_idmap_groups_for_sys_auth` - Whether or not the export should use ID mapping for Unix groups rather than the group list provided within an NFS request's RPC header. When this flag is true the Unix UID from the RPC header is used to retrieve the list of secondary groups from a the ID mapping subsystem. The primary GID is always taken from the RPC header. If ID mapping is not configured, incorrectly configured, unavailable, or cannot be used to determine a list of secondary groups then an empty secondary group list is used for authorization. If the number of groups exceeds the limit of 256 groups, the list retrieved from LDAP is truncated to the first 256 groups read.
- `file_storage_export_locks` - Locks associated with this resource.
- `file_storage_export_path` - Path used to access the associated file system.
- `file_storage_export_state` - The current state of this export.
- `file_storage_export_anonymous_gid` - GID value to remap to when squashing a client GID (see identitySquash for more details.) If unspecified defaults to 65534.
- `file_storage_export_anonymous_uid` - UID value to remap to when squashing a client UID (see identitySquash for more details.) If unspecified, defaults to 65534.
- `file_storage_export_identity_squash` - Used when clients accessing the file system through this export have their UID and GID remapped to 'anonymousUid' and 'anonymousGid'. If ALL, all users and groups are remapped; if ROOT, only the root user and group (UID/GID 0) are remapped; if NONE, no remapping is done. If unspecified, defaults to ROOT.
- `file_storage_export_is_anonymous_access_allowed` - Whether or not to enable anonymous access to the file system through this export in cases where a user isn't found in the LDAP server used for ID mapping. If true, and the user is not found in the LDAP directory, the operation uses the Squash UID and Squash GID.
- `file_storage_export_require_privileged_source_port` - If true, clients accessing the file system through this export must connect from a privileged source port. If unspecified, defaults to true.
- `file_storage_export_source` - Clients these options should apply to. Must be a either single IPv4 address or single IPv4 CIDR block.
- `file_storage_export_access` - Type of access to grant clients using the file system through this export. If unspecified defaults to READ_WRITE.
- `file_storage_export_allowed_auth` - Array of allowed NFS authentication types.
- `file_storage_export_set_id` - The OCID of the export set.
- `file_storage_export_set_availability_domain` - The availability domain the export set is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1
- `file_storage_export_set_compartment_id` - The OCID of the compartment that contains the export set.
- `file_storage_export_set_display_name` - A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My export set
- `file_storage_export_set_max_fs_stat_bytes` - Controls the maximum tbytes, fbytes, and abytes, values reported by NFS FSSTAT calls through any associated mount targets. This is an advanced feature. For most applications, use the default value. The tbytes value reported by FSSTAT will be maxFsStatBytes. The value of fbytes and abytes will be maxFsStatBytes minus the metered size of the file system. If the metered size is larger than maxFsStatBytes, then fbytes and abytes will both be '0'.
- `file_storage_export_set_max_fs_stat_files` - Controls the maximum tfiles, ffiles, and afiles values reported by NFS FSSTAT calls through any associated mount targets. This is an advanced feature. For most applications, use the default value. The tfiles value reported by FSSTAT will be maxFsStatFiles. The value of ffiles and afiles will be maxFsStatFiles minus the metered size of the file system. If the metered size is larger than maxFsStatFiles, then ffiles and afiles will both be '0'.
- `file_storage_export_set_state` - The current state of the export set.
- `file_storage_export_set_time_created` - The date and time the export set was created, expressed in RFC 3339 timestamp format. Example: 2016-08-25T21:10:29.600Z
- `file_storage_export_set_vcn_id` - The OCID of the virtual cloud network (VCN) the export set is in.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
