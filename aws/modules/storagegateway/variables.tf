#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS storagegateway gateway
#---------------------------------------------------
variable "enable_storagegateway_gateway" {
  description = "Enable storagegateway gateway usage"
  default     = false
}

variable "storagegateway_gateway_name" {
  description = "Name of the gateway."
  default     = ""
}

variable "storagegateway_gateway_timezone" {
  description = "(Required) Time zone for the gateway. The time zone is of the format 'GMT', 'GMT-hr:mm', or 'GMT+hr:mm'. For example, GMT-4:00 indicates the time is 4 hours behind GMT. The time zone is used, for example, for scheduling snapshots and your gateway's maintenance schedule."
  default     = null
}

variable "storagegateway_gateway_ip_address" {
  description = "(Optional) Gateway IP address to retrieve activation key during resource creation. Conflicts with activation_key. Gateway must be accessible on port 80 from where Terraform is running. Additional information is available in the Storage Gateway User Guide."
  default     = null
}

variable "storagegateway_gateway_type" {
  description = "(Optional) Type of the gateway. The default value is STORED. Valid values: CACHED, FILE_S3, STORED, VTL."
  default     = null
}

variable "storagegateway_gateway_vpc_endpoint" {
  description = "(Optional) VPC endpoint address to be used when activating your gateway. This should be used when your instance is in a private subnet. Requires HTTP access from client computer running terraform. More info on what ports are required by your VPC Endpoint Security group in Activating a Gateway in a Virtual Private Cloud."
  default     = null
}

variable "storagegateway_gateway_medium_changer_type" {
  description = "(Optional) Type of medium changer to use for tape gateway. Terraform cannot detect drift of this argument. Valid values: STK-L700, AWS-Gateway-VTL, IBM-03584L32-0402."
  default     = null
}

variable "storagegateway_gateway_tape_drive_type" {
  description = "(Optional) Type of tape drive to use for tape gateway. Terraform cannot detect drift of this argument. Valid values: IBM-ULT3580-TD5"
  default     = null
}

variable "storagegateway_gateway_activation_key" {
  description = "(Optional) Gateway activation key during resource creation. Conflicts with gateway_ip_address. Additional information is available in the Storage Gateway User Guide."
  default     = null
}

variable "storagegateway_gateway_cloudwatch_log_group_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the Amazon CloudWatch log group to use to monitor and log events in the gateway."
  default     = null
}

variable "storagegateway_gateway_average_download_rate_limit_in_bits_per_sec" {
  description = "(Optional) The average download bandwidth rate limit in bits per second. This is supported for the CACHED, STORED, and VTL gateway types."
  default     = null
}

variable "storagegateway_gateway_average_upload_rate_limit_in_bits_per_sec" {
  description = "(Optional) The average upload bandwidth rate limit in bits per second. This is supported for the CACHED, STORED, and VTL gateway types."
  default     = null
}

variable "storagegateway_gateway_smb_guest_password" {
  description = "(Optional) Guest password for Server Message Block (SMB) file shares. Only valid for FILE_S3 gateway type. Must be set before creating GuestAccess authentication SMB file shares. Terraform can only detect drift of the existence of a guest password, not its actual value from the gateway. Terraform can however update the password with changing the argument."
  default     = null
}

variable "storagegateway_gateway_smb_security_strategy" {
  description = "(Optional) Specifies the type of security strategy. Valid values are: ClientSpecified, MandatorySigning, and MandatoryEncryption. See Setting a Security Level for Your Gateway for more information."
  default     = null
}

variable "storagegateway_gateway_smb_file_share_visibility" {
  description = "(Optional) Specifies whether the shares on this gateway appear when listing shares."
  default     = null
}

variable "storagegateway_gateway_smb_active_directory_settings" {
  description = "(Optional) Nested argument with Active Directory domain join information for Server Message Block (SMB) file shares. Only valid for FILE_S3 gateway type. Must be set before creating ActiveDirectory authentication SMB file shares."
  default     = []
}

variable "storagegateway_gateway_timeouts" {
  description = "Set timeouts for storagegateway gateway"
  default     = {}
}

#---------------------------------------------------
# AWS storagegateway cached
#---------------------------------------------------
variable "enable_storagegateway_cache" {
  description = "Enable storagegateway cache usage"
  default     = false
}

variable "storagegateway_cache_gateway_arn" {
  description = "The Amazon Resource Name (ARN) of the gateway."
  default     = ""
}

variable "storagegateway_cache_disk_id" {
  description = "(Required) Local disk identifier. For example, pci-0000:03:00.0-scsi-0:0:0:0."
  default     = null
}

#---------------------------------------------------
# AWS storagegateway cached iscsi volume
#---------------------------------------------------
variable "enable_storagegateway_cached_iscsi_volume" {
  description = "Enable storagegateway cached iscsi volume usage"
  default     = false
}

variable "storagegateway_cached_iscsi_volume_gateway_arn" {
  description = "The Amazon Resource Name (ARN) of the gateway."
  default     = ""
}

variable "storagegateway_cached_iscsi_volume_network_interface_id" {
  description = "(Required) The network interface of the gateway on which to expose the iSCSI target. Only IPv4 addresses are accepted."
  default     = null
}

variable "storagegateway_cached_iscsi_volume_target_name" {
  description = "The name of the iSCSI target used by initiators to connect to the target and as a suffix for the target ARN. The target name must be unique across all volumes of a gateway."
  default     = ""
}

variable "storagegateway_cached_iscsi_volume_volume_size_in_bytes" {
  description = "(Required) The size of the volume in bytes."
  default     = null
}

variable "storagegateway_cached_iscsi_volume_snapshot_id" {
  description = "(Optional) The snapshot ID of the snapshot to restore as the new cached volume. e.g. snap-1122aabb"
  default     = null
}

variable "storagegateway_cached_iscsi_volume_source_volume_arn" {
  description = "(Optional) The ARN for an existing volume. Specifying this ARN makes the new volume into an exact copy of the specified existing volume's latest recovery point. The volume_size_in_bytes value for this new volume must be equal to or larger than the size of the existing volume, in bytes."
  default     = null
}

variable "storagegateway_cached_iscsi_volume_kms_encrypted" {
  description = "(Optional) Set to true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3."
  default     = null
}

variable "storagegateway_cached_iscsi_volume_kms_key" {
  description = "(Optional) The Amazon Resource Name (ARN) of the AWS KMS key used for Amazon S3 server side encryption. Is required when kms_encrypted is set."
  default     = null
}

#---------------------------------------------------
# AWS storagegateway nfs file share
#---------------------------------------------------
variable "enable_storagegateway_nfs_file_share" {
  description = "Enable storagegateway nfs file share usage"
  default     = false
}

variable "storagegateway_nfs_file_share_name" {
  description = "Set name for storagegateway nfs file share"
  default     = ""
}

variable "storagegateway_nfs_file_share_client_list" {
  description = "(Required) The list of clients that are allowed to access the file gateway. The list must contain either valid IP addresses or valid CIDR blocks. Set to ['0.0.0.0/0'] to not limit access. Minimum 1 item. Maximum 100 items."
  default     = []
}

variable "storagegateway_nfs_file_share_gateway_arn" {
  description = "Amazon Resource Name (ARN) of the file gateway."
  default     = ""
}

variable "storagegateway_nfs_file_share_location_arn" {
  description = "(Required) The ARN of the backed storage used for storing file data."
  default     = null
}

variable "storagegateway_nfs_file_share_role_arn" {
  description = "(Required) The ARN of the AWS Identity and Access Management (IAM) role that a file gateway assumes when it accesses the underlying storage."
  default     = null
}

variable "storagegateway_nfs_file_share_default_storage_class" {
  description = "(Optional) The default storage class for objects put into an Amazon S3 bucket by the file gateway. Defaults to S3_STANDARD. Valid values: S3_STANDARD, S3_STANDARD_IA, S3_ONEZONE_IA."
  default     = null
}

variable "storagegateway_nfs_file_share_guess_mime_type_enabled" {
  description = "(Optional) Boolean value that enables guessing of the MIME type for uploaded objects based on file extensions. Defaults to true."
  default     = null
}

variable "storagegateway_nfs_file_share_kms_encrypted" {
  description = "(Optional) Boolean value if true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3. Defaults to false."
  default     = null
}

variable "storagegateway_nfs_file_share_kms_key_arn" {
  description = "(Optional) Amazon Resource Name (ARN) for KMS key used for Amazon S3 server side encryption. This value can only be set when kms_encrypted is true."
  default     = null
}

variable "storagegateway_nfs_file_share_object_acl" {
  description = "(Optional) Access Control List permission for S3 bucket objects. Defaults to private"
  default     = null
}

variable "storagegateway_nfs_file_share_read_only" {
  description = "(Optional) Boolean to indicate write status of file share. File share does not accept writes if true. Defaults to false."
  default     = null
}

variable "storagegateway_nfs_file_share_requester_pays" {
  description = "(Optional) Boolean who pays the cost of the request and the data download from the Amazon S3 bucket. Set this value to true if you want the requester to pay instead of the bucket owner. Defaults to false."
  default     = null
}

variable "storagegateway_nfs_file_share_squash" {
  description = "(Optional) Maps a user to anonymous user. Defaults to RootSquash. Valid values: RootSquash (only root is mapped to anonymous user), NoSquash (no one is mapped to anonymous user), AllSquash (everyone is mapped to anonymous user)"
  default     = null
}

variable "storagegateway_nfs_file_share_file_share_name" {
  description = "(Optional) The name of the file share. Must be set if an S3 prefix name is set in location_arn."
  default     = null
}

variable "storagegateway_nfs_file_share_notification_policy" {
  description = "(Optional) The notification policy of the file share. For more information see the AWS Documentation. Default value is {}."
  default     = null
}

variable "storagegateway_nfs_file_share_nfs_file_share_defaults" {
  description = "(Optional) Nested argument with file share default values."
  default     = []
}

variable "storagegateway_nfs_file_share_cache_attributes" {
  description = "(Optional) Refresh cache information. see Cache Attributes for more details."
  default     = []
}

variable "storagegateway_nfs_file_share_timeouts" {
  description = "Set timeouts for storagegateway nfs file share"
  default     = {}
}

#---------------------------------------------------
# AWS storagegateway smb file share
#---------------------------------------------------
variable "enable_storagegateway_smb_file_share" {
  description = "Enable storagegateway smb file share usage"
  default     = false
}

variable "storagegateway_smb_file_share_name" {
  description = "Set name for storagegateway smb file share"
  default     = ""
}

variable "storagegateway_smb_file_share_gateway_arn" {
  description = "Amazon Resource Name (ARN) of the file gateway."
  default     = ""
}

variable "storagegateway_smb_file_share_location_arn" {
  description = "(Required) The ARN of the backed storage used for storing file data."
  default     = null
}

variable "storagegateway_smb_file_share_role_arn" {
  description = "(Required) The ARN of the AWS Identity and Access Management (IAM) role that a file gateway assumes when it accesses the underlying storage."
  default     = null
}

variable "storagegateway_smb_file_share_authentication" {
  description = "(Optional) The authentication method that users use to access the file share. Defaults to ActiveDirectory. Valid values: ActiveDirectory, GuestAccess."
  default     = null
}

variable "storagegateway_smb_file_share_admin_user_list" {
  description = "(Optional) A list of users in the Active Directory that have admin access to the file share. Only valid if authentication is set to ActiveDirectory."
  default     = null
}

variable "storagegateway_smb_file_share_audit_destination_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the CloudWatch Log Group used for the audit logs."
  default     = null
}

variable "storagegateway_smb_file_share_default_storage_class" {
  description = "(Optional) The default storage class for objects put into an Amazon S3 bucket by the file gateway. Defaults to S3_STANDARD. Valid values: S3_STANDARD, S3_STANDARD_IA, S3_ONEZONE_IA."
  default     = null
}

variable "storagegateway_smb_file_share_file_share_name" {
  description = "(Optional) The name of the file share. Must be set if an S3 prefix name is set in location_arn."
  default     = null
}

variable "storagegateway_smb_file_share_guess_mime_type_enabled" {
  description = "(Optional) Boolean value that enables guessing of the MIME type for uploaded objects based on file extensions. Defaults to true"
  default     = null
}

variable "storagegateway_smb_file_share_invalid_user_list" {
  description = "(Optional) A list of users in the Active Directory that are not allowed to access the file share. Only valid if authentication is set to ActiveDirectory."
  default     = null
}

variable "storagegateway_smb_file_share_kms_encrypted" {
  description = "(Optional) Boolean value if true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3. Defaults to false."
  default     = null
}

variable "storagegateway_smb_file_share_kms_key_arn" {
  description = "(Optional) Amazon Resource Name (ARN) for KMS key used for Amazon S3 server side encryption. This value can only be set when kms_encrypted is true."
  default     = null
}

variable "storagegateway_smb_file_share_object_acl" {
  description = "(Optional) Access Control List permission for S3 bucket objects. Defaults to private."
  default     = null
}

variable "storagegateway_smb_file_share_read_only" {
  description = "(Optional) Boolean to indicate write status of file share. File share does not accept writes if true. Defaults to false."
  default     = null
}

variable "storagegateway_smb_file_share_requester_pays" {
  description = "(Optional) Boolean who pays the cost of the request and the data download from the Amazon S3 bucket. Set this value to true if you want the requester to pay instead of the bucket owner. Defaults to false"
  default     = null
}

variable "storagegateway_smb_file_share_smb_acl_enabled" {
  description = "(Optional) Set this value to true to enable ACL (access control list) on the SMB fileshare. Set it to false to map file and directory permissions to the POSIX permissions. This setting applies only to ActiveDirectory authentication type."
  default     = null
}

variable "storagegateway_smb_file_share_case_sensitivity" {
  description = "(Optional) The case of an object name in an Amazon S3 bucket. For ClientSpecified, the client determines the case sensitivity. For CaseSensitive, the gateway determines the case sensitivity. The default value is ClientSpecified."
  default     = null
}

variable "storagegateway_smb_file_share_valid_user_list" {
  description = "(Optional) A list of users in the Active Directory that are allowed to access the file share. Only valid if authentication is set to ActiveDirectory."
  default     = null
}

variable "storagegateway_smb_file_share_access_based_enumeration" {
  description = " (Optional) The files and folders on this share will only be visible to users with read access. Default value is false."
  default     = null
}

variable "storagegateway_smb_file_share_notification_policy" {
  description = "(Optional) The notification policy of the file share. For more information see the AWS Documentation. Default value is {}."
  default     = null
}

variable "storagegateway_smb_file_share_cache_attributes" {
  description = "(Optional) Refresh cache information."
  default     = []
}

variable "storagegateway_smb_file_share_timeouts" {
  description = "Set timeouts for storagegateway smb file share"
  default     = {}
}

#---------------------------------------------------
# AWS storagegateway stored iscsi volume
#---------------------------------------------------
variable "enable_storagegateway_stored_iscsi_volume" {
  description = "Enable storagegateway stored iscsi volume usage"
  default     = false
}

variable "storagegateway_stored_iscsi_volume_name" {
  description = "Set name for storagegateway stored iscsi volume"
  default     = ""
}

variable "storagegateway_stored_iscsi_volume_gateway_arn" {
  description = "The Amazon Resource Name (ARN) of the gateway."
  default     = ""
}

variable "storagegateway_stored_iscsi_volume_network_interface_id" {
  description = "(Required) The network interface of the gateway on which to expose the iSCSI target. Only IPv4 addresses are accepted."
  default     = null
}

variable "storagegateway_stored_iscsi_volume_target_name" {
  description = "(Required) The name of the iSCSI target used by initiators to connect to the target and as a suffix for the target ARN. The target name must be unique across all volumes of a gateway."
  default     = null
}

variable "storagegateway_stored_iscsi_volume_preserve_existing_data" {
  description = "(Required) Specify this field as true if you want to preserve the data on the local disk. Otherwise, specifying this field as false creates an empty volume."
  default     = null
}

variable "storagegateway_stored_iscsi_volume_disk_id" {
  description = "(Required) The unique identifier for the gateway local disk that is configured as a stored volume."
  default     = null
}

variable "storagegateway_stored_iscsi_volume_snapshot_id" {
  description = "(Optional) The snapshot ID of the snapshot to restore as the new stored volume. e.g. snap-1122aabb."
  default     = null
}

variable "storagegateway_stored_iscsi_volume_kms_encrypted" {
  description = "(Optional) true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3. Optional."
  default     = null
}

variable "storagegateway_stored_iscsi_volume_kms_key" {
  description = "(Optional) The Amazon Resource Name (ARN) of the AWS KMS key used for Amazon S3 server side encryption. This value can only be set when kms_encrypted is true."
  default     = null
}

#---------------------------------------------------
# AWS storagegateway tape pool
#---------------------------------------------------
variable "enable_storagegateway_tape_pool" {
  description = "Enable storagegateway tape pool usage"
  default     = false
}

variable "storagegateway_tape_pool_name" {
  description = "Set name for storagegateway tape pool"
  default     = ""
}

variable "storagegateway_tape_pool_storage_class" {
  description = "(Required) The storage class that is associated with the new custom pool. When you use your backup application to eject the tape, the tape is archived directly into the storage class that corresponds to the pool. Possible values are DEEP_ARCHIVE or GLACIER."
  default     = null
}

variable "storagegateway_tape_pool_retention_lock_type" {
  description = "(Required) Tape retention lock can be configured in two modes. When configured in governance mode, AWS accounts with specific IAM permissions are authorized to remove the tape retention lock from archived virtual tapes. When configured in compliance mode, the tape retention lock cannot be removed by any user, including the root AWS account. Possible values are COMPLIANCE, GOVERNANCE, and NONE. Default value is NONE."
  default     = null
}

variable "storagegateway_tape_pool_retention_lock_time_in_days" {
  description = "(Optional) Tape retention lock time is set in days. Tape retention lock can be enabled for up to 100 years (36,500 days). Default value is 0."
  default     = null
}

#---------------------------------------------------
# AWS storagegateway upload buffer
#---------------------------------------------------
variable "enable_storagegateway_upload_buffer" {
  description = "Enable storagegateway upload buffer usage"
  default     = false
}

variable "storagegateway_upload_buffer_gateway_arn" {
  description = "The Amazon Resource Name (ARN) of the gateway."
  default     = ""
}

variable "storagegateway_upload_buffer_disk_id" {
  description = "(Optional) Local disk identifier. For example, pci-0000:03:00.0-scsi-0:0:0:0."
  default     = null
}

variable "storagegateway_upload_buffer_disk_path" {
  description = "(Optional) Local disk path. For example, /dev/nvme1n1."
  default     = null
}

#---------------------------------------------------
# AWS storagegateway working storage
#---------------------------------------------------
variable "enable_storagegateway_working_storage" {
  description = "Enable storagegateway working storage usage"
  default     = false
}

variable "storagegateway_working_storage_gateway_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the gateway."
  default     = ""
}

variable "storagegateway_working_storage_disk_id" {
  description = "(Required) Local disk identifier. For example, pci-0000:03:00.0-scsi-0:0:0:0."
  default     = null
}
