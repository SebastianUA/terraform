# Work with STORAGEGATEWAY via terraform

A terraform module for making STORAGEGATEWAY.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "storagegateway" {
  source      = "../../modules/storagegateway"
  name        = "TEST"
  environment = "stage"

  # Enable storagegateway gateway
  enable_storagegateway_gateway     = true
  storagegateway_gateway_name       = ""
  storagegateway_gateway_timezone   = "GMT"
  storagegateway_gateway_ip_address = "1.2.3.4"
  storagegateway_gateway_type       = "STORED" # "CACHED", "VTL", "FILE_S3"

  depends_on = []
}

data "aws_storagegateway_local_disk" "storagegateway_local_disk" {
  disk_path   = "/dev/xvdb"
  gateway_arn = module.storagegateway.storagegateway_gateway_arn

  depends_on = [
    module.storagegateway
  ]
}

module "storagegateway_stored_iscsi_volume" {
  source      = "../../modules/storagegateway"
  name        = "TEST"
  environment = "stage"

  # Enable storagegateway stored iscsi volume
  enable_storagegateway_stored_iscsi_volume                 = true
  storagegateway_stored_iscsi_volume_name                   = ""
  storagegateway_stored_iscsi_volume_gateway_arn            = module.storagegateway.storagegateway_gateway_arn
  storagegateway_stored_iscsi_volume_network_interface_id   = "192.168.113.66"
  storagegateway_stored_iscsi_volume_target_name            = "example"
  storagegateway_stored_iscsi_volume_preserve_existing_data = false
  storagegateway_stored_iscsi_volume_disk_id                = data.aws_storagegateway_local_disk.storagegateway_local_disk.id

  depends_on = [
    module.storagegateway,
    data.aws_storagegateway_local_disk.storagegateway_local_disk
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_storagegateway_gateway` - Enable storagegateway gateway usage (`default = False`)
- `storagegateway_gateway_name` - Name of the gateway. (`default = ""`)
- `storagegateway_gateway_timezone` - (Required) Time zone for the gateway. The time zone is of the format 'GMT', 'GMT-hr:mm', or 'GMT+hr:mm'. For example, GMT-4:00 indicates the time is 4 hours behind GMT. The time zone is used, for example, for scheduling snapshots and your gateway's maintenance schedule. (`default = null`)
- `storagegateway_gateway_ip_address` - (Optional) Gateway IP address to retrieve activation key during resource creation. Conflicts with activation_key. Gateway must be accessible on port 80 from where Terraform is running. Additional information is available in the Storage Gateway User Guide. (`default = null`)
- `storagegateway_gateway_type` - (Optional) Type of the gateway. The default value is STORED. Valid values: CACHED, FILE_S3, STORED, VTL. (`default = null`)
- `storagegateway_gateway_vpc_endpoint` - (Optional) VPC endpoint address to be used when activating your gateway. This should be used when your instance is in a private subnet. Requires HTTP access from client computer running terraform. More info on what ports are required by your VPC Endpoint Security group in Activating a Gateway in a Virtual Private Cloud. (`default = null`)
- `storagegateway_gateway_medium_changer_type` - (Optional) Type of medium changer to use for tape gateway. Terraform cannot detect drift of this argument. Valid values: STK-L700, AWS-Gateway-VTL, IBM-03584L32-0402. (`default = null`)
- `storagegateway_gateway_tape_drive_type` - (Optional) Type of tape drive to use for tape gateway. Terraform cannot detect drift of this argument. Valid values: IBM-ULT3580-TD5 (`default = null`)
- `storagegateway_gateway_activation_key` - (Optional) Gateway activation key during resource creation. Conflicts with gateway_ip_address. Additional information is available in the Storage Gateway User Guide. (`default = null`)
- `storagegateway_gateway_cloudwatch_log_group_arn` - (Optional) The Amazon Resource Name (ARN) of the Amazon CloudWatch log group to use to monitor and log events in the gateway. (`default = null`)
- `storagegateway_gateway_average_download_rate_limit_in_bits_per_sec` - (Optional) The average download bandwidth rate limit in bits per second. This is supported for the CACHED, STORED, and VTL gateway types. (`default = null`)
- `storagegateway_gateway_average_upload_rate_limit_in_bits_per_sec` - (Optional) The average upload bandwidth rate limit in bits per second. This is supported for the CACHED, STORED, and VTL gateway types. (`default = null`)
- `storagegateway_gateway_smb_guest_password` - (Optional) Guest password for Server Message Block (SMB) file shares. Only valid for FILE_S3 gateway type. Must be set before creating GuestAccess authentication SMB file shares. Terraform can only detect drift of the existence of a guest password, not its actual value from the gateway. Terraform can however update the password with changing the argument. (`default = null`)
- `storagegateway_gateway_smb_security_strategy` - (Optional) Specifies the type of security strategy. Valid values are: ClientSpecified, MandatorySigning, and MandatoryEncryption. See Setting a Security Level for Your Gateway for more information. (`default = null`)
- `storagegateway_gateway_smb_file_share_visibility` - (Optional) Specifies whether the shares on this gateway appear when listing shares. (`default = null`)
- `storagegateway_gateway_smb_active_directory_settings` - (Optional) Nested argument with Active Directory domain join information for Server Message Block (SMB) file shares. Only valid for FILE_S3 gateway type. Must be set before creating ActiveDirectory authentication SMB file shares. (`default = []`)
- `storagegateway_gateway_timeouts` - Set timeouts for storagegateway gateway (`default = {}`)
- `enable_storagegateway_cache` - Enable storagegateway cache usage (`default = False`)
- `storagegateway_cache_gateway_arn` - The Amazon Resource Name (ARN) of the gateway. (`default = ""`)
- `storagegateway_cache_disk_id` - (Required) Local disk identifier. For example, pci-0000:03:00.0-scsi-0:0:0:0. (`default = null`)
- `enable_storagegateway_cached_iscsi_volume` - Enable storagegateway cached iscsi volume usage (`default = False`)
- `storagegateway_cached_iscsi_volume_gateway_arn` - The Amazon Resource Name (ARN) of the gateway. (`default = ""`)
- `storagegateway_cached_iscsi_volume_network_interface_id` - (Required) The network interface of the gateway on which to expose the iSCSI target. Only IPv4 addresses are accepted. (`default = null`)
- `storagegateway_cached_iscsi_volume_target_name` - The name of the iSCSI target used by initiators to connect to the target and as a suffix for the target ARN. The target name must be unique across all volumes of a gateway. (`default = ""`)
- `storagegateway_cached_iscsi_volume_volume_size_in_bytes` - (Required) The size of the volume in bytes. (`default = null`)
- `storagegateway_cached_iscsi_volume_snapshot_id` - (Optional) The snapshot ID of the snapshot to restore as the new cached volume. e.g. snap-1122aabb (`default = null`)
- `storagegateway_cached_iscsi_volume_source_volume_arn` - (Optional) The ARN for an existing volume. Specifying this ARN makes the new volume into an exact copy of the specified existing volume's latest recovery point. The volume_size_in_bytes value for this new volume must be equal to or larger than the size of the existing volume, in bytes. (`default = null`)
- `storagegateway_cached_iscsi_volume_kms_encrypted` - (Optional) Set to true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3. (`default = null`)
- `storagegateway_cached_iscsi_volume_kms_key` - (Optional) The Amazon Resource Name (ARN) of the AWS KMS key used for Amazon S3 server side encryption. Is required when kms_encrypted is set. (`default = null`)
- `enable_storagegateway_nfs_file_share` - Enable storagegateway nfs file share usage (`default = False`)
- `storagegateway_nfs_file_share_name` - Set name for storagegateway nfs file share (`default = ""`)
- `storagegateway_nfs_file_share_client_list` - (Required) The list of clients that are allowed to access the file gateway. The list must contain either valid IP addresses or valid CIDR blocks. Set to ['0.0.0.0/0'] to not limit access. Minimum 1 item. Maximum 100 items. (`default = []`)
- `storagegateway_nfs_file_share_gateway_arn` - Amazon Resource Name (ARN) of the file gateway. (`default = ""`)
- `storagegateway_nfs_file_share_location_arn` - (Required) The ARN of the backed storage used for storing file data. (`default = null`)
- `storagegateway_nfs_file_share_role_arn` - (Required) The ARN of the AWS Identity and Access Management (IAM) role that a file gateway assumes when it accesses the underlying storage. (`default = null`)
- `storagegateway_nfs_file_share_default_storage_class` - (Optional) The default storage class for objects put into an Amazon S3 bucket by the file gateway. Defaults to S3_STANDARD. Valid values: S3_STANDARD, S3_STANDARD_IA, S3_ONEZONE_IA. (`default = null`)
- `storagegateway_nfs_file_share_guess_mime_type_enabled` - (Optional) Boolean value that enables guessing of the MIME type for uploaded objects based on file extensions. Defaults to true. (`default = null`)
- `storagegateway_nfs_file_share_kms_encrypted` - (Optional) Boolean value if true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3. Defaults to false. (`default = null`)
- `storagegateway_nfs_file_share_kms_key_arn` - (Optional) Amazon Resource Name (ARN) for KMS key used for Amazon S3 server side encryption. This value can only be set when kms_encrypted is true. (`default = null`)
- `storagegateway_nfs_file_share_object_acl` - (Optional) Access Control List permission for S3 bucket objects. Defaults to private (`default = null`)
- `storagegateway_nfs_file_share_read_only` - (Optional) Boolean to indicate write status of file share. File share does not accept writes if true. Defaults to false. (`default = null`)
- `storagegateway_nfs_file_share_requester_pays` - (Optional) Boolean who pays the cost of the request and the data download from the Amazon S3 bucket. Set this value to true if you want the requester to pay instead of the bucket owner. Defaults to false. (`default = null`)
- `storagegateway_nfs_file_share_squash` - (Optional) Maps a user to anonymous user. Defaults to RootSquash. Valid values: RootSquash (only root is mapped to anonymous user), NoSquash (no one is mapped to anonymous user), AllSquash (everyone is mapped to anonymous user) (`default = null`)
- `storagegateway_nfs_file_share_file_share_name` - (Optional) The name of the file share. Must be set if an S3 prefix name is set in location_arn. (`default = null`)
- `storagegateway_nfs_file_share_notification_policy` - (Optional) The notification policy of the file share. For more information see the AWS Documentation. Default value is {}. (`default = null`)
- `storagegateway_nfs_file_share_nfs_file_share_defaults` - (Optional) Nested argument with file share default values. (`default = []`)
- `storagegateway_nfs_file_share_cache_attributes` - (Optional) Refresh cache information. see Cache Attributes for more details. (`default = []`)
- `storagegateway_nfs_file_share_timeouts` - Set timeouts for storagegateway nfs file share (`default = {}`)
- `enable_storagegateway_smb_file_share` - Enable storagegateway smb file share usage (`default = False`)
- `storagegateway_smb_file_share_name` - Set name for storagegateway smb file share (`default = ""`)
- `storagegateway_smb_file_share_gateway_arn` - Amazon Resource Name (ARN) of the file gateway. (`default = ""`)
- `storagegateway_smb_file_share_location_arn` - (Required) The ARN of the backed storage used for storing file data. (`default = null`)
- `storagegateway_smb_file_share_role_arn` - (Required) The ARN of the AWS Identity and Access Management (IAM) role that a file gateway assumes when it accesses the underlying storage. (`default = null`)
- `storagegateway_smb_file_share_authentication` - (Optional) The authentication method that users use to access the file share. Defaults to ActiveDirectory. Valid values: ActiveDirectory, GuestAccess. (`default = null`)
- `storagegateway_smb_file_share_admin_user_list` - (Optional) A list of users in the Active Directory that have admin access to the file share. Only valid if authentication is set to ActiveDirectory. (`default = null`)
- `storagegateway_smb_file_share_audit_destination_arn` - (Optional) The Amazon Resource Name (ARN) of the CloudWatch Log Group used for the audit logs. (`default = null`)
- `storagegateway_smb_file_share_default_storage_class` - (Optional) The default storage class for objects put into an Amazon S3 bucket by the file gateway. Defaults to S3_STANDARD. Valid values: S3_STANDARD, S3_STANDARD_IA, S3_ONEZONE_IA. (`default = null`)
- `storagegateway_smb_file_share_file_share_name` - (Optional) The name of the file share. Must be set if an S3 prefix name is set in location_arn. (`default = null`)
- `storagegateway_smb_file_share_guess_mime_type_enabled` - (Optional) Boolean value that enables guessing of the MIME type for uploaded objects based on file extensions. Defaults to true (`default = null`)
- `storagegateway_smb_file_share_invalid_user_list` - (Optional) A list of users in the Active Directory that are not allowed to access the file share. Only valid if authentication is set to ActiveDirectory. (`default = null`)
- `storagegateway_smb_file_share_kms_encrypted` - (Optional) Boolean value if true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3. Defaults to false. (`default = null`)
- `storagegateway_smb_file_share_kms_key_arn` - (Optional) Amazon Resource Name (ARN) for KMS key used for Amazon S3 server side encryption. This value can only be set when kms_encrypted is true. (`default = null`)
- `storagegateway_smb_file_share_object_acl` - (Optional) Access Control List permission for S3 bucket objects. Defaults to private. (`default = null`)
- `storagegateway_smb_file_share_read_only` - (Optional) Boolean to indicate write status of file share. File share does not accept writes if true. Defaults to false. (`default = null`)
- `storagegateway_smb_file_share_requester_pays` - (Optional) Boolean who pays the cost of the request and the data download from the Amazon S3 bucket. Set this value to true if you want the requester to pay instead of the bucket owner. Defaults to false (`default = null`)
- `storagegateway_smb_file_share_smb_acl_enabled` - (Optional) Set this value to true to enable ACL (access control list) on the SMB fileshare. Set it to false to map file and directory permissions to the POSIX permissions. This setting applies only to ActiveDirectory authentication type. (`default = null`)
- `storagegateway_smb_file_share_case_sensitivity` - (Optional) The case of an object name in an Amazon S3 bucket. For ClientSpecified, the client determines the case sensitivity. For CaseSensitive, the gateway determines the case sensitivity. The default value is ClientSpecified. (`default = null`)
- `storagegateway_smb_file_share_valid_user_list` - (Optional) A list of users in the Active Directory that are allowed to access the file share. Only valid if authentication is set to ActiveDirectory. (`default = null`)
- `storagegateway_smb_file_share_access_based_enumeration` -  (Optional) The files and folders on this share will only be visible to users with read access. Default value is false. (`default = null`)
- `storagegateway_smb_file_share_notification_policy` - (Optional) The notification policy of the file share. For more information see the AWS Documentation. Default value is {}. (`default = null`)
- `storagegateway_smb_file_share_cache_attributes` - (Optional) Refresh cache information. (`default = []`)
- `storagegateway_smb_file_share_timeouts` - Set timeouts for storagegateway smb file share (`default = {}`)
- `enable_storagegateway_stored_iscsi_volume` - Enable storagegateway stored iscsi volume usage (`default = False`)
- `storagegateway_stored_iscsi_volume_name` - Set name for storagegateway stored iscsi volume (`default = ""`)
- `storagegateway_stored_iscsi_volume_gateway_arn` - The Amazon Resource Name (ARN) of the gateway. (`default = ""`)
- `storagegateway_stored_iscsi_volume_network_interface_id` - (Required) The network interface of the gateway on which to expose the iSCSI target. Only IPv4 addresses are accepted. (`default = null`)
- `storagegateway_stored_iscsi_volume_target_name` - (Required) The name of the iSCSI target used by initiators to connect to the target and as a suffix for the target ARN. The target name must be unique across all volumes of a gateway. (`default = null`)
- `storagegateway_stored_iscsi_volume_preserve_existing_data` - (Required) Specify this field as true if you want to preserve the data on the local disk. Otherwise, specifying this field as false creates an empty volume. (`default = null`)
- `storagegateway_stored_iscsi_volume_disk_id` - (Required) The unique identifier for the gateway local disk that is configured as a stored volume. (`default = null`)
- `storagegateway_stored_iscsi_volume_snapshot_id` - (Optional) The snapshot ID of the snapshot to restore as the new stored volume. e.g. snap-1122aabb. (`default = null`)
- `storagegateway_stored_iscsi_volume_kms_encrypted` - (Optional) true to use Amazon S3 server side encryption with your own AWS KMS key, or false to use a key managed by Amazon S3. Optional. (`default = null`)
- `storagegateway_stored_iscsi_volume_kms_key` - (Optional) The Amazon Resource Name (ARN) of the AWS KMS key used for Amazon S3 server side encryption. This value can only be set when kms_encrypted is true. (`default = null`)
- `enable_storagegateway_tape_pool` - Enable storagegateway tape pool usage (`default = False`)
- `storagegateway_tape_pool_name` - Set name for storagegateway tape pool (`default = ""`)
- `storagegateway_tape_pool_storage_class` - (Required) The storage class that is associated with the new custom pool. When you use your backup application to eject the tape, the tape is archived directly into the storage class that corresponds to the pool. Possible values are DEEP_ARCHIVE or GLACIER. (`default = null`)
- `storagegateway_tape_pool_retention_lock_type` - (Required) Tape retention lock can be configured in two modes. When configured in governance mode, AWS accounts with specific IAM permissions are authorized to remove the tape retention lock from archived virtual tapes. When configured in compliance mode, the tape retention lock cannot be removed by any user, including the root AWS account. Possible values are COMPLIANCE, GOVERNANCE, and NONE. Default value is NONE. (`default = null`)
- `storagegateway_tape_pool_retention_lock_time_in_days` - (Optional) Tape retention lock time is set in days. Tape retention lock can be enabled for up to 100 years (36,500 days). Default value is 0. (`default = null`)
- `enable_storagegateway_upload_buffer` - Enable storagegateway upload buffer usage (`default = False`)
- `storagegateway_upload_buffer_gateway_arn` - The Amazon Resource Name (ARN) of the gateway. (`default = ""`)
- `storagegateway_upload_buffer_disk_id` - (Optional) Local disk identifier. For example, pci-0000:03:00.0-scsi-0:0:0:0. (`default = null`)
- `storagegateway_upload_buffer_disk_path` - (Optional) Local disk path. For example, /dev/nvme1n1. (`default = null`)
- `enable_storagegateway_working_storage` - Enable storagegateway working storage usage (`default = False`)
- `storagegateway_working_storage_gateway_arn` - (Required) The Amazon Resource Name (ARN) of the gateway. (`default = ""`)
- `storagegateway_working_storage_disk_id` - (Required) Local disk identifier. For example, pci-0000:03:00.0-scsi-0:0:0:0. (`default = null`)

## Module Output Variables
----------------------
- `storagegateway_gateway_id` - Amazon Resource Name (ARN) of the gateway.
- `storagegateway_gateway_arn` - Amazon Resource Name (ARN) of the gateway.
- `storagegateway_gateway_gateway_id` - Identifier of the gateway.
- `storagegateway_gateway_ec2_instance_id` - The ID of the Amazon EC2 instance that was used to launch the gateway.
- `storagegateway_gateway_endpoint_type` - The type of endpoint for your gateway.
- `storagegateway_gateway_host_environment` - The type of hypervisor environment used by the host.
- `storagegateway_gateway_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `storagegateway_gateway_gateway_network_interface` - An array that contains descriptions of the gateway network interfaces. See Gateway Network Interface.
- `storagegateway_cache_id` - Combined gateway Amazon Resource Name (ARN) and local disk identifier.
- `storagegateway_cache_gateway_arn` - Get gateway arn
- `storagegateway_cached_iscsi_volume_id` - Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678.
- `storagegateway_cached_iscsi_volume_arn` - Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678.
- `storagegateway_cached_iscsi_volume_chap_enabled` - Whether mutual CHAP is enabled for the iSCSI target.
- `storagegateway_cached_iscsi_volume_lun_number` - Logical disk number.
- `storagegateway_cached_iscsi_volume_network_interface_port` - The port used to communicate with iSCSI targets.
- `storagegateway_cached_iscsi_volume_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `storagegateway_cached_iscsi_volume_target_arn` - Target Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/target/iqn.1997-05.com.amazon:TargetName.
- `storagegateway_cached_iscsi_volume_volume_arn` - Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678.
- `storagegateway_cached_iscsi_volume_volume_id` - Volume ID, e.g. vol-12345678.
- `storagegateway_nfs_file_share_id` - Amazon Resource Name (ARN) of the NFS File Share.
- `storagegateway_nfs_file_share_arn` - Amazon Resource Name (ARN) of the NFS File Share.
- `storagegateway_nfs_file_share_fileshare_id` - ID of the NFS File Share.
- `storagegateway_nfs_file_share_path` - File share path used by the NFS client to identify the mount point.
- `storagegateway_nfs_file_share_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `storagegateway_smb_file_share_id` - Amazon Resource Name (ARN) of the SMB File Share.
- `storagegateway_smb_file_share_arn` - Amazon Resource Name (ARN) of the SMB File Share.
- `storagegateway_smb_file_share_fileshare_id` - ID of the SMB File Share.
- `storagegateway_smb_file_share_path` - File share path used by the NFS client to identify the mount point.
- `storagegateway_smb_file_share_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `storagegateway_stored_iscsi_volume_id` - Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678.
- `storagegateway_stored_iscsi_volume_arn` - Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678.
- `storagegateway_stored_iscsi_volume_chap_enabled` - Volume Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/volume/vol-12345678.
- `storagegateway_stored_iscsi_volume_lun_number` - Logical disk number.
- `storagegateway_stored_iscsi_volume_network_interface_port` - The port used to communicate with iSCSI targets.
- `storagegateway_stored_iscsi_volume_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `storagegateway_stored_iscsi_volume_target_arn` - Target Amazon Resource Name (ARN), e.g. arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/target/iqn.1997-05.com.amazon:TargetName.
- `storagegateway_stored_iscsi_volume_volume_id` - Volume ID, e.g. vol-12345678.
- `storagegateway_stored_iscsi_volume_volume_status` - indicates the state of the storage volume.
- `storagegateway_stored_iscsi_volume_volume_type` - indicates the type of the volume.
- `storagegateway_stored_iscsi_volume_volume_attachment_status` - A value that indicates whether a storage volume is attached to, detached from, or is in the process of detaching from a gateway.
- `storagegateway_stored_iscsi_volume_volume_size_in_bytes` - The size of the data stored on the volume in bytes.
- `storagegateway_tape_pool_id` - Volume Amazon Resource Name (ARN), e.g. aws_storagegateway_tape_pool.example arn:aws:storagegateway:us-east-1:123456789012:tapepool/pool-12345678.
- `storagegateway_tape_pool_arn` - Volume Amazon Resource Name (ARN), e.g. aws_storagegateway_tape_pool.example arn:aws:storagegateway:us-east-1:123456789012:tapepool/pool-12345678.
- `storagegateway_tape_pool_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `storagegateway_upload_buffer_id` - Combined gateway Amazon Resource Name (ARN) and local disk identifier.
- `storagegateway_working_storage_id` - Combined gateway Amazon Resource Name (ARN) and local disk identifier.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
