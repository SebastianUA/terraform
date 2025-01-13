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
# file system
#-----------------------------------------------------------
variable "enable_file_storage_file_system" {
  description = "Enable file storage file system usages"
  default     = false
}

variable "file_storage_file_system_availability_domain" {
  description = "(Required) The availability domain to create the file system in. Example: Uocm:PHX-AD-1"
  default     = null
}

variable "file_storage_file_system_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to create the file system in."
  default     = null
}

variable "file_storage_file_system_clone_attach_status" {
  description = "(Optional) Specifies whether the clone file system is attached to its parent file system. If the value is set to 'DETACH', then the file system will be created, which is deep copied from the snapshot specified by sourceSnapshotId, else will remain attached to its parent."
  default     = null
}

variable "file_storage_file_system_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My file system"
  default     = ""
}

variable "file_storage_file_system_filesystem_snapshot_policy_id" {
  description = "(Optional) (Updatable) The OCID of the associated file system snapshot policy, which controls the frequency of snapshot creation and retention period of the taken snapshots."
  default     = ""
}

variable "file_storage_file_system_kms_key_id" {
  description = "(Optional) (Updatable) The OCID of KMS key used to encrypt the encryption keys associated with this file system. May be unset as a blank or deleted from the configuration to remove the KMS key."
  default     = null
}

variable "file_storage_file_system_source_snapshot_id" {
  description = "(Optional) The OCID of the snapshot used to create a cloned file system. See Cloning a File System."
  default     = null
}

variable "file_storage_file_system_locks" {
  description = "(Optional) Locks associated with this resource."
  default     = []
}

variable "file_storage_file_system_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'}"
  default     = {}
}

variable "file_storage_file_system_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the File System * update - (Defaults to 20 minutes), when updating the File System * delete - (Defaults to 20 minutes), when destroying the File System"
  default     = {}
}

#-----------------------------------------------------------
# filesystem snapshot policy
#-----------------------------------------------------------
variable "enable_file_storage_filesystem_snapshot_policy" {
  description = "Enable file storage filesystem snapshot policy usages"
  default     = false
}

variable "file_storage_filesystem_snapshot_policy_availability_domain" {
  description = "(Required) The availability domain that the file system snapshot policy is in. Example: Uocm:PHX-AD-1"
  default     = null
}

variable "file_storage_filesystem_snapshot_policy_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment that contains the file system snapshot policy."
  default     = null
}

variable "file_storage_filesystem_snapshot_policy_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: policy1"
  default     = ""
}

variable "file_storage_filesystem_snapshot_policy_policy_prefix" {
  description = "(Optional) (Updatable) The prefix to apply to all snapshots created by this policy. Example: acme"
  default     = null
}

variable "file_storage_filesystem_snapshot_policy_locks" {
  description = "(Optional) Locks associated with this resource."
  default     = []
}

variable "file_storage_filesystem_snapshot_policy_schedules" {
  description = "(Optional) (Updatable) The list of associated snapshot schedules. A maximum of 10 schedules can be associated with a policy."
  type        = list(string) # Adjust the type based on your actual schedule object
  default     = []

  validation {
    condition     = length(var.file_storage_filesystem_snapshot_policy_schedules) <= 10
    error_message = "A maximum of 10 snapshot schedules can be associated with a policy."
  }
}

variable "file_storage_filesystem_snapshot_policy_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "file_storage_filesystem_snapshot_policy_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Filesystem Snapshot Policy * update - (Defaults to 20 minutes), when updating the Filesystem Snapshot Policy * delete - (Defaults to 20 minutes), when destroying the Filesystem Snapshot Policy"
  default     = {}
}

#-----------------------------------------------------------
# mount target
#-----------------------------------------------------------
variable "enable_file_storage_mount_target" {
  description = "Enable file storage mount target usages"
  default     = false
}

variable "file_storage_mount_target_availability_domain" {
  description = "(Required) The availability domain in which to create the mount target. Example: Uocm:PHX-AD-1"
  default     = null
}

variable "file_storage_mount_target_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment in which to create the mount target."
  default     = null
}

variable "file_storage_mount_target_subnet_id" {
  description = "(Required) The OCID of the subnet in which to create the mount target."
  default     = null
}

variable "file_storage_mount_target_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My mount target"
  default     = ""
}

variable "file_storage_mount_target_hostname_label" {
  description = "(Optional) The hostname for the mount target's IP address, used for DNS resolution. The value is the hostname portion of the private IP address's fully qualified domain name (FQDN). For example, files-1 in the FQDN files-1.subnet123.vcn1.oraclevcn.com. Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123."
  default     = null
}

variable "file_storage_mount_target_idmap_type" {
  description = "(Optional) (Updatable) The method used to map a Unix UID to secondary groups, if any."
  default     = null
}

variable "file_storage_mount_target_ip_address" {
  description = "(Optional) A private IP address of your choice. Must be an available IP address within the subnet's CIDR. If you don't specify a value, Oracle automatically assigns a private IP address from the subnet. Example: 10.0.3.3"
  default     = null
}

variable "file_storage_mount_target_is_lock_override" {
  description = "(Optional) (Updatable) Whether to override locks (if any exist)."
  default     = null
}

variable "file_storage_mount_target_nsg_ids" {
  description = "(Optional) (Updatable) A list of Network Security Group OCIDs associated with this mount target. A maximum of 5 is allowed. Setting this to an empty array after the list is created removes the mount target from all NSGs. For more information about NSGs, see Security Rules."
  default     = null
}

variable "file_storage_mount_target_requested_throughput" {
  description = "(Optional) (Updatable) Throughput for mount target in Gbps. Currently only 1 Gbps of requestedThroughput is supported during create MountTarget. Available shapes and corresponding throughput are listed at Mount Target Performance."
  default     = null
}

variable "file_storage_mount_target_kerberos" {
  description = "(Optional) (Updatable) Kerberos details needed to create configuration."
  default     = {}
}

variable "file_storage_mount_target_ldap_idmap" {
  description = "(Optional) (Updatable) Mount target details about the LDAP ID mapping configuration."
  default     = {}
}

variable "file_storage_mount_target_locks" {
  description = "(Optional) Locks associated with this resource."
  default     = []
}

variable "file_storage_mount_target_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "file_storage_mount_target_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Mount Target * update - (Defaults to 20 minutes), when updating the Mount Target * delete - (Defaults to 20 minutes), when destroying the Mount Target"
  default     = {}
}

#-----------------------------------------------------------
# outbound connector
#-----------------------------------------------------------
variable "enable_file_storage_outbound_connector" {
  description = "Enable file storage outbound connector usages"
  default     = false
}

variable "file_storage_outbound_connector_availability_domain" {
  description = "(Required) The availability domain the outbound connector is in. May be unset as a blank or NULL value. Example: Uocm:PHX-AD-1"
  default     = null
}

variable "file_storage_outbound_connector_bind_distinguished_name" {
  description = "(Required) The LDAP Distinguished Name of the bind account."
  default     = null
}

variable "file_storage_outbound_connector_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment that contains the outbound connector."
  default     = null
}

variable "file_storage_outbound_connector_connector_type" {
  description = "(Required) The account type of this outbound connector."
  default     = null
}

variable "file_storage_outbound_connector_endpoints" {
  description = "(Required) Array of server endpoints to use when connecting with the LDAP bind account."
  default     = []
}

variable "file_storage_outbound_connector_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My outbound connector"
  default     = ""
}

variable "file_storage_outbound_connector_password_secret_id" {
  description = "(Optional) The OCID of the password for the LDAP bind account in the Vault."
  default     = null
}

variable "file_storage_outbound_connector_password_secret_version" {
  description = "(Optional) Version of the password secret in the Vault to use."
  default     = null
}

variable "file_storage_outbound_connector_locks" {
  description = "(Optional) Locks associated with this resource."
  default     = []
}

variable "file_storage_outbound_connector_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "file_storage_outbound_connector_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Outbound Connector * update - (Defaults to 20 minutes), when updating the Outbound Connector * delete - (Defaults to 20 minutes), when destroying the Outbound Connector"
  default     = {}
}

#-----------------------------------------------------------
# replication
#-----------------------------------------------------------
variable "enable_file_storage_replication" {
  description = "Enable file storage replication usages"
  default     = false
}

variable "file_storage_replication_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment that contains the replication."
  default     = null
}

variable "file_storage_replication_source_id" {
  description = "(Required) The OCID of the source file system."
  default     = null
}

variable "file_storage_replication_target_id" {
  description = "(Required) The OCID of the target file system."
  default     = null
}

variable "file_storage_replication_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. An associated replication target will also created with the same displayName"
  default     = ""
}

variable "file_storage_replication_replication_interval" {
  description = "(Optional) (Updatable) Duration in minutes between replication snapshots."
  default     = null
}

variable "file_storage_replication_locks" {
  description = "(Optional) Locks associated with this resource."
  default     = []
}

variable "file_storage_replication_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "file_storage_replication_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Replication * update - (Defaults to 20 minutes), when updating the Replication * delete - (Defaults to 20 minutes), when destroying the Replication"
  default     = {}
}

#-----------------------------------------------------------
# snapshot
#-----------------------------------------------------------
variable "enable_file_storage_snapshot" {
  description = "Enable file storage snapshot usages"
  default     = false
}

variable "file_storage_snapshot_file_system_id" {
  description = "The OCID of the file system to take a snapshot of."
  default     = ""
}

variable "file_storage_snapshot_name" {
  description = "Name of the snapshot. This value is immutable. It must also be unique with respect to all other non-DELETED snapshots on the associated file system."
  default     = ""
}

variable "file_storage_snapshot_expiration_time" {
  description = "(Optional) (Updatable) The time when this snapshot will be deleted."
  default     = null
}

variable "file_storage_snapshot_locks" {
  description = "(Optional) Locks associated with this resource."
  default     = []
}

variable "file_storage_snapshot_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "file_storage_snapshot_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Snapshot * update - (Defaults to 20 minutes), when updating the Snapshot * delete - (Defaults to 20 minutes), when destroying the Snapshot"
  default     = {}
}

#-----------------------------------------------------------
# export
#-----------------------------------------------------------
variable "enable_file_storage_export" {
  description = "Enable file storage export usages"
  default     = false
}

variable "file_storage_export_export_set_id" {
  description = "The OCID of this export's export set."
  default     = ""
}

variable "file_storage_export_file_system_id" {
  description = "The OCID of this export's file system."
  default     = ""
}

variable "file_storage_export_path" {
  description = "(Required) Path used to access the associated file system."
  default     = null
}

variable "file_storage_export_is_idmap_groups_for_sys_auth" {
  description = "(Optional) (Updatable) Whether or not the export should use ID mapping for Unix groups rather than the group list provided within an NFS request's RPC header. When this flag is true the Unix UID from the RPC header is used to retrieve the list of secondary groups from a the ID mapping subsystem. The primary GID is always taken from the RPC header. If ID mapping is not configured, incorrectly configured, unavailable, or cannot be used to determine a list of secondary groups then an empty secondary group list is used for authorization. If the number of groups exceeds the limit of 256 groups, the list retrieved from LDAP is truncated to the first 256 groups read."
  default     = null
}

variable "file_storage_export_export_options" {
  description = "(Optional) (Updatable) Export options for the new export. For exports of mount targets with IPv4 address, if client options are left unspecified, client options would default to"
  default     = []
}

variable "file_storage_export_locks" {
  description = "(Optional) Locks associated with this resource."
  default     = []
}

variable "file_storage_export_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Export * update - (Defaults to 20 minutes), when updating the Export * delete - (Defaults to 20 minutes), when destroying the Export"
  default     = {}
}

#-----------------------------------------------------------
# export set
#-----------------------------------------------------------
variable "enable_file_storage_export_set" {
  description = "Enable file storage export set usages"
  default     = false
}

variable "file_storage_export_set_mount_target_id" {
  description = "(Updatable) The OCID of the mount target that the export set is associated with"
  default     = ""
}

variable "file_storage_export_set_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: My export set"
  default     = ""
}

variable "file_storage_export_set_max_fs_stat_bytes" {
  description = "(Optional) (Updatable) Controls the maximum tbytes, fbytes, and abytes, values reported by NFS FSSTAT calls through any associated mount targets. This is an advanced feature. For most applications, use the default value. The tbytes value reported by FSSTAT will be maxFsStatBytes. The value of fbytes and abytes will be maxFsStatBytes minus the metered size of the file system. If the metered size is larger than maxFsStatBytes, then fbytes and abytes will both be '0'."
  default     = null
}

variable "file_storage_export_set_max_fs_stat_files" {
  description = "(Optional) (Updatable) Controls the maximum tfiles, ffiles, and afiles values reported by NFS FSSTAT calls through any associated mount targets. This is an advanced feature. For most applications, use the default value. The tfiles value reported by FSSTAT will be maxFsStatFiles. The value of ffiles and afiles will be maxFsStatFiles minus the metered size of the file system. If the metered size is larger than maxFsStatFiles, then ffiles and afiles will both be '0'."
  default     = null
}

variable "file_storage_export_set_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Export Set * update - (Defaults to 20 minutes), when updating the Export Set * delete - (Defaults to 20 minutes), when destroying the Export Set"
  default     = {}
}
