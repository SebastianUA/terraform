#-----------------------------------------------------------
# file system
#-----------------------------------------------------------
output "file_storage_file_system_id" {
  description = "The OCID of the file system."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.id, [""]), 0)
}

output "file_storage_file_system_is_clone_parent" {
  description = "Specifies whether the file system has been cloned. See Cloning a File System."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.is_clone_parent, [""]), 0)
}

output "file_storage_file_system_is_hydrated" {
  description = "Specifies whether the data has finished copying from the source to the clone. Hydration can take up to several hours to complete depending on the size of the source. The source and clone remain available during hydration, but there may be some performance impact. See Cloning a File System."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.is_hydrated, [""]), 0)
}

output "file_storage_file_system_is_targetable" {
  description = "Specifies whether the file system can be used as a target file system for replication. The system sets this value to true if the file system is unexported, hasn't yet been specified as a target file system in any replication resource, and has no user snapshots. After the file system has been specified as a target in a replication, or if the file system contains user snapshots, the system sets this value to false. For more information, see Using Replication."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.is_targetable, [""]), 0)
}

output "file_storage_file_system_kms_key_id" {
  description = "The OCID of the KMS key used to encrypt the encryption keys associated with this file system."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.kms_key_id, [""]), 0)
}

output "file_storage_file_system_display_name" {
  description = "A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My file system"
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.display_name, [""]), 0)
}

output "file_storage_file_system_filesystem_snapshot_policy_id" {
  description = "The OCID of the associated file system snapshot policy, which controls the frequency of snapshot creation and retention period of the taken snapshots."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.filesystem_snapshot_policy_id, [""]), 0)
}

output "file_storage_file_system_availability_domain" {
  description = "The availability domain the file system is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.availability_domain, [""]), 0)
}

output "file_storage_file_system_clone_attach_status" {
  description = "Specifies whether the file system is attached to its parent file system."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.clone_attach_status, [""]), 0)
}

output "file_storage_file_system_clone_count" {
  description = "Specifies the total number of children of a file system."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.clone_count, [""]), 0)
}

output "file_storage_file_system_compartment_id" {
  description = "The OCID of the compartment that contains the file system."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.compartment_id, [""]), 0)
}

output "file_storage_file_system_state" {
  description = "The current state of the file system."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.state, [""]), 0)
}

output "file_storage_file_system_replication_target_id" {
  description = "The OCID of the replication target associated with the file system. Empty if the file system is not being used as target in a replication."
  value       = element(concat(oci_file_storage_file_system.file_storage_file_system.*.replication_target_id, [""]), 0)
}

#-----------------------------------------------------------
# filesystem snapshot policy
#-----------------------------------------------------------
output "file_storage_filesystem_snapshot_policy_id" {
  description = "The OCID of the file system snapshot policy."
  value       = element(concat(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.id, [""]), 0)
}

output "file_storage_filesystem_snapshot_policy_availability_domain" {
  description = "The availability domain that the file system snapshot policy is in. May be unset using a blank or NULL value. Example: Uocm:PHX-AD-2"
  value       = element(concat(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.availability_domain, [""]), 0)
}

output "file_storage_filesystem_snapshot_policy_compartment_id" {
  description = "The OCID of the compartment that contains the file system snapshot policy."
  value       = element(concat(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.compartment_id, [""]), 0)
}

output "file_storage_filesystem_snapshot_policy_display_name" {
  description = "A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My Filesystem Snapshot Policy"
  value       = element(concat(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.display_name, [""]), 0)
}

output "file_storage_filesystem_snapshot_policy_state" {
  description = "The current state of this file system snapshot policy."
  value       = element(concat(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.state, [""]), 0)
}

output "file_storage_filesystem_snapshot_policy_policy_prefix" {
  description = "The prefix to apply to all snapshots created by this policy. Example: acme"
  value       = element(concat(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.policy_prefix, [""]), 0)
}

output "file_storage_filesystem_snapshot_policy_locks" {
  description = "Locks associated with this resource."
  value       = concat(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.locks, [""])
}

output "file_storage_filesystem_snapshot_policy_schedules" {
  description = "The list of associated snapshot schedules. A maximum of 10 schedules can be associated with a policy."
  value       = concat(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.schedules, [""])
}

#-----------------------------------------------------------
# mount target
#-----------------------------------------------------------
output "file_storage_mount_target_id" {
  description = "The OCID of the mount target."
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.id, [""]), 0)
}

output "file_storage_mount_target_idmap_type" {
  description = "The method used to map a Unix UID to secondary groups. If NONE, the mount target will not use the Unix UID for ID mapping."
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.idmap_type, [""]), 0)
}

output "file_storage_mount_target_kerberos" {
  description = "Allows administrator to configure a mount target to interact with the administrator's Kerberos infrastructure."
  value       = concat(oci_file_storage_mount_target.file_storage_mount_target.*.kerberos, [""])
}

output "file_storage_mount_target_display_name" {
  description = "A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My mount target"
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.display_name, [""]), 0)
}

output "file_storage_mount_target_export_set_id" {
  description = "The OCID of the associated export set. Controls what file systems will be exported through Network File System (NFS) protocol on this mount target."
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.export_set_id, [""]), 0)
}

output "file_storage_mount_target_ldap_idmap" {
  description = "Mount target details about the LDAP ID mapping configuration"
  value       = concat(oci_file_storage_mount_target.file_storage_mount_target.*.ldap_idmap, [""])
}

output "file_storage_mount_target_lifecycle_details" {
  description = "Additional information about the current 'lifecycleState'."
  value       = concat(oci_file_storage_mount_target.file_storage_mount_target.*.lifecycle_details, [""])
}

output "file_storage_mount_target_locks" {
  description = "Locks associated with this resource."
  value       = concat(oci_file_storage_mount_target.file_storage_mount_target.*.locks, [""])
}

output "file_storage_mount_target_state" {
  description = "The current state of the mount target."
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.state, [""]), 0)
}

output "file_storage_mount_target_subnet_id" {
  description = "The OCID of the subnet the mount target is in."
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.subnet_id, [""]), 0)
}

output "file_storage_mount_target_nsg_ids" {
  description = "A list of Network Security Group OCIDs associated with this mount target. A maximum of 5 is allowed. Setting this to an empty array after the list is created removes the mount target from all NSGs. For more information about NSGs, see Security Rules."
  value       = concat(oci_file_storage_mount_target.file_storage_mount_target.*.nsg_ids, [""])
}

output "file_storage_mount_target_observed_throughput" {
  description = "Current billed throughput for mount target in Gbps. This corresponds to shape of mount target. Available shapes and corresponding throughput are listed at Mount Target Performance."
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.observed_throughput, [""]), 0)
}

output "file_storage_mount_target_private_ip_ids" {
  description = "The OCIDs of the private IP addresses associated with this mount target."
  value       = concat(oci_file_storage_mount_target.file_storage_mount_target.*.private_ip_ids, [""])
}

output "file_storage_mount_target_availability_domain" {
  description = "The availability domain the mount target is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.availability_domain, [""]), 0)
}

output "file_storage_mount_target_compartment_id" {
  description = "The OCID of the compartment that contains the mount target."
  value       = element(concat(oci_file_storage_mount_target.file_storage_mount_target.*.compartment_id, [""]), 0)
}

#-----------------------------------------------------------
# outbound connector
#-----------------------------------------------------------
output "file_storage_outbound_connector_id" {
  description = "The OCID of the outbound connector."
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.id, [""]), 0)
}

output "file_storage_outbound_connector_locks" {
  description = "Locks associated with this resource"
  value       = concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.locks, [""])
}

output "file_storage_outbound_connector_availability_domain" {
  description = "The availability domain the outbound connector is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.availability_domain, [""]), 0)
}

output "file_storage_outbound_connector_bind_distinguished_name" {
  description = "The LDAP Distinguished Name of the account."
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.bind_distinguished_name, [""]), 0)
}

output "file_storage_outbound_connector_compartment_id" {
  description = "The OCID of the compartment that contains the outbound connector."
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.compartment_id, [""]), 0)
}

output "file_storage_outbound_connector_connector_type" {
  description = "The account type of this outbound connector."
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.connector_type, [""]), 0)
}

output "file_storage_outbound_connector_display_name" {
  description = "A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My outbound connector"
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.display_name, [""]), 0)
}

output "file_storage_outbound_connector_endpoints" {
  description = "Array of server endpoints to use when connecting with the LDAP bind account."
  value       = concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.endpoints, [""])
}

output "file_storage_outbound_connector_password_secret_id" {
  description = "The OCID of the password for the LDAP bind account in the Vault."
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.password_secret_id, [""]), 0)
}

output "file_storage_outbound_connector_password_secret_version" {
  description = "Version of the password secret in the Vault to use."
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.password_secret_version, [""]), 0)
}

output "file_storage_outbound_connector_state" {
  description = "The current state of this outbound connector."
  value       = element(concat(oci_file_storage_outbound_connector.file_storage_outbound_connector.*.state, [""]), 0)
}

#-----------------------------------------------------------
# replication
#-----------------------------------------------------------
output "file_storage_replication_id" {
  description = "The OCID of the replication."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.id, [""]), 0)
}

output "file_storage_replication_availability_domain" {
  description = "The availability domain the replication is in. The replication must be in the same availability domain as the source file system. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.availability_domain, [""]), 0)
}

output "file_storage_replication_compartment_id" {
  description = "The OCID of the compartment that contains the replication."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.compartment_id, [""]), 0)
}

output "file_storage_replication_delta_progress" {
  description = "Percentage progress of the current replication cycle."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.delta_progress, [""]), 0)
}

output "file_storage_replication_delta_status" {
  description = "The current state of the snapshot during replication operations."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.delta_status, [""]), 0)
}

output "file_storage_replication_display_name" {
  description = "A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My replication"
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.display_name, [""]), 0)
}

output "file_storage_replication_recovery_point_time" {
  description = "The snapshotTime of the most recent recoverable replication snapshot in RFC 3339 timestamp format. Example: 2021-04-04T20:01:29.100Z"
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.recovery_point_time, [""]), 0)
}

output "file_storage_replication_replication_interval" {
  description = "Duration in minutes between replication snapshots."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.replication_interval, [""]), 0)
}

output "file_storage_replication_replication_target_id" {
  description = "The OCID of the ReplicationTarget."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.replication_target_id, [""]), 0)
}

output "file_storage_replication_source_id" {
  description = "The OCID of the source file system."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.source_id, [""]), 0)
}

output "file_storage_replication_state" {
  description = "The current state of this replication. This resource can be in a FAILED state if replication target is deleted instead of the replication resource."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.state, [""]), 0)
}

output "file_storage_replication_target_id" {
  description = "The OCID of the target file system."
  value       = element(concat(oci_file_storage_replication.file_storage_replication.*.target_id, [""]), 0)
}

output "file_storage_replication_locks" {
  description = "Locks associated with this resource"
  value       = concat(oci_file_storage_replication.file_storage_replication.*.locks, [""])
}

#-----------------------------------------------------------
# snapshot
#-----------------------------------------------------------
output "file_storage_snapshot_id" {
  description = "The OCID of the snapshot."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.id, [""]), 0)
}

output "file_storage_snapshot_is_clone_source" {
  description = "Specifies whether the snapshot has been cloned. See Cloning a File System."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.is_clone_source, [""]), 0)
}

output "file_storage_snapshot_lifecycle_details" {
  description = "Additional information about the current lifecycleState."
  value       = concat(oci_file_storage_snapshot.file_storage_snapshot.*.lifecycle_details, [""])
}

output "file_storage_snapshot_locks" {
  description = "Locks associated with this resource."
  value       = concat(oci_file_storage_snapshot.file_storage_snapshot.*.locks, [""])
}

output "file_storage_snapshot_expiration_time" {
  description = "The time when this snapshot will be deleted."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.expiration_time, [""]), 0)
}

output "file_storage_snapshot_file_system_id" {
  description = "The OCID of the file system from which the snapshot was created."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.file_system_id, [""]), 0)
}

output "file_storage_snapshot_filesystem_snapshot_policy_id" {
  description = "The OCID of the file system snapshot policy that created this snapshot."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.filesystem_snapshot_policy_id, [""]), 0)
}

output "file_storage_snapshot_name" {
  description = "Name of the snapshot. This value is immutable."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.name, [""]), 0)
}

output "file_storage_snapshot_provenance_id" {
  description = "An OCID identifying the parent from which this snapshot was cloned. If this snapshot was not cloned, then the provenanceId is the same as the snapshot id value. If this snapshot was cloned, then the provenanceId value is the parent's provenanceId. See Cloning a File System."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.provenance_id, [""]), 0)
}

output "file_storage_snapshot_snapshot_type" {
  description = "Specifies the generation type of the snapshot."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.snapshot_type, [""]), 0)
}

output "file_storage_snapshot_state" {
  description = "The current state of the snapshot."
  value       = element(concat(oci_file_storage_snapshot.file_storage_snapshot.*.state, [""]), 0)
}

#-----------------------------------------------------------
# export
#-----------------------------------------------------------
output "file_storage_export_id" {
  description = "The OCID of this export."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.id, [""]), 0)
}

output "file_storage_export_export_set_id" {
  description = "The OCID of this export's export set."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.export_set_id, [""]), 0)
}

output "file_storage_export_file_system_id" {
  description = "The OCID of this export's file system."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.file_system_id, [""]), 0)
}

output "file_storage_export_is_idmap_groups_for_sys_auth" {
  description = "Whether or not the export should use ID mapping for Unix groups rather than the group list provided within an NFS request's RPC header. When this flag is true the Unix UID from the RPC header is used to retrieve the list of secondary groups from a the ID mapping subsystem. The primary GID is always taken from the RPC header. If ID mapping is not configured, incorrectly configured, unavailable, or cannot be used to determine a list of secondary groups then an empty secondary group list is used for authorization. If the number of groups exceeds the limit of 256 groups, the list retrieved from LDAP is truncated to the first 256 groups read."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.is_idmap_groups_for_sys_auth, [""]), 0)
}

output "file_storage_export_locks" {
  description = "Locks associated with this resource."
  value       = concat(oci_file_storage_export.file_storage_export.*.locks, [""])
}

output "file_storage_export_path" {
  description = "Path used to access the associated file system."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.path, [""]), 0)
}

output "file_storage_export_state" {
  description = "The current state of this export."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.state, [""]), 0)
}

output "file_storage_export_anonymous_gid" {
  description = "GID value to remap to when squashing a client GID (see identitySquash for more details.) If unspecified defaults to 65534."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.anonymous_gid, [""]), 0)
}

output "file_storage_export_anonymous_uid" {
  description = "UID value to remap to when squashing a client UID (see identitySquash for more details.) If unspecified, defaults to 65534."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.anonymous_uid, [""]), 0)
}

output "file_storage_export_identity_squash" {
  description = "Used when clients accessing the file system through this export have their UID and GID remapped to 'anonymousUid' and 'anonymousGid'. If ALL, all users and groups are remapped; if ROOT, only the root user and group (UID/GID 0) are remapped; if NONE, no remapping is done. If unspecified, defaults to ROOT."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.identity_squash, [""]), 0)
}

output "file_storage_export_is_anonymous_access_allowed" {
  description = "Whether or not to enable anonymous access to the file system through this export in cases where a user isn't found in the LDAP server used for ID mapping. If true, and the user is not found in the LDAP directory, the operation uses the Squash UID and Squash GID."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.is_anonymous_access_allowed, [""]), 0)
}

output "file_storage_export_require_privileged_source_port" {
  description = "If true, clients accessing the file system through this export must connect from a privileged source port. If unspecified, defaults to true."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.require_privileged_source_port, [""]), 0)
}

output "file_storage_export_source" {
  description = "Clients these options should apply to. Must be a either single IPv4 address or single IPv4 CIDR block."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.source, [""]), 0)
}

output "file_storage_export_access" {
  description = "Type of access to grant clients using the file system through this export. If unspecified defaults to READ_WRITE."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.access, [""]), 0)
}

output "file_storage_export_allowed_auth" {
  description = "Array of allowed NFS authentication types."
  value       = element(concat(oci_file_storage_export.file_storage_export.*.allowed_auth, [""]), 0)
}

#-----------------------------------------------------------
# export set
#-----------------------------------------------------------
output "file_storage_export_set_id" {
  description = "The OCID of the export set."
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.id, [""]), 0)
}

output "file_storage_export_set_availability_domain" {
  description = "The availability domain the export set is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.availability_domain, [""]), 0)
}

output "file_storage_export_set_compartment_id" {
  description = "The OCID of the compartment that contains the export set."
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.compartment_id, [""]), 0)
}

output "file_storage_export_set_display_name" {
  description = "A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My export set"
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.display_name, [""]), 0)
}

output "file_storage_export_set_max_fs_stat_bytes" {
  description = "Controls the maximum tbytes, fbytes, and abytes, values reported by NFS FSSTAT calls through any associated mount targets. This is an advanced feature. For most applications, use the default value. The tbytes value reported by FSSTAT will be maxFsStatBytes. The value of fbytes and abytes will be maxFsStatBytes minus the metered size of the file system. If the metered size is larger than maxFsStatBytes, then fbytes and abytes will both be '0'."
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.max_fs_stat_bytes, [""]), 0)
}

output "file_storage_export_set_max_fs_stat_files" {
  description = "Controls the maximum tfiles, ffiles, and afiles values reported by NFS FSSTAT calls through any associated mount targets. This is an advanced feature. For most applications, use the default value. The tfiles value reported by FSSTAT will be maxFsStatFiles. The value of ffiles and afiles will be maxFsStatFiles minus the metered size of the file system. If the metered size is larger than maxFsStatFiles, then ffiles and afiles will both be '0'."
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.max_fs_stat_files, [""]), 0)
}

output "file_storage_export_set_state" {
  description = "The current state of the export set."
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.state, [""]), 0)
}

output "file_storage_export_set_time_created" {
  description = "The date and time the export set was created, expressed in RFC 3339 timestamp format. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.time_created, [""]), 0)
}

output "file_storage_export_set_vcn_id" {
  description = "The OCID of the virtual cloud network (VCN) the export set is in."
  value       = element(concat(oci_file_storage_export_set.file_storage_export_set.*.vcn_id, [""]), 0)
}
