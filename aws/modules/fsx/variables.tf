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
# AWS fsx lustre file system
#---------------------------------------------------
variable "enable_fsx_lustre_file_system" {
  description = "Enable fsx lustre file system usage"
  default     = false
}

variable "fsx_lustre_file_system_storage_capacity" {
  description = "(Required) The storage capacity (GiB) of the file system. Minimum of 1200. Storage capacity is provisioned in increments of 3,600 GiB."
  default     = 1200
}

variable "fsx_lustre_file_system_subnet_ids" {
  description = "(Required) A list of IDs for the subnets that the file system will be accessible from. File systems currently support only one subnet. The file server is also launched in that subnet's Availability Zone."
  default     = []
}

variable "fsx_lustre_file_system_export_path" {
  description = "(Optional) S3 URI (with optional prefix) where the root of your Amazon FSx file system is exported. Can only be specified with import_path argument and the path must use the same Amazon S3 bucket as specified in import_path. Set equal to import_path to overwrite files on export. Default to s3://{IMPORT BUCKET}/FSxLustre{CREATION TIMESTAMP}"
  default     = null
}

variable "fsx_lustre_file_system_import_path" {
  description = "(Optional) S3 URI (with optional prefix) that you're using as the data repository for your FSx for Lustre file system. For example, s3://example-bucket/optional-prefix/"
  default     = null
}

variable "fsx_lustre_file_system_imported_file_chunk_size" {
  description = "(Optional) For files imported from a data repository, this value determines the stripe count and maximum amount of data per file (in MiB) stored on a single physical disk. Can only be specified with import_path argument. Defaults to 1024. Minimum of 1 and maximum of 512000"
  default     = 1024
}

variable "fsx_lustre_file_system_security_group_ids" {
  description = "(Optional) A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces."
  default     = null
}

variable "fsx_lustre_file_system_weekly_maintenance_start_time" {
  description = "(Optional) The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone."
  default     = null
}

variable "fsx_lustre_file_system_timeouts" {
  description = "Set timeouts for resource"
  default     = {}
}

variable "fsx_lustre_file_system_name" {
  description = "Set name for fsx lustre file system"
  default     = ""
}

#---------------------------------------------------
# AWS fsx windows file system
#---------------------------------------------------
variable "enable_fsx_windows_file_system" {
  description = "Enable fsx windows file system usage"
  default     = false
}

variable "fsx_windows_file_system_storage_capacity" {
  description = "(Required) Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536."
  default     = 32
}

variable "fsx_windows_file_system_subnet_ids" {
  description = "(Required) A list of IDs for the subnets that the file system will be accessible from. File systems support only one subnet. The file server is also launched in that subnet's Availability Zone."
  default     = []
}

variable "fsx_windows_file_system_throughput_capacity" {
  description = "(Required) Throughput (megabytes per second) of the file system in power of 2 increments. Minimum of 8 and maximum of 2048."
  default     = 8
}

variable "fsx_windows_file_system_active_directory_id" {
  description = "(Optional) The ID for an existing Microsoft Active Directory instance that the file system should join when it's created. Cannot be specified with self_managed_active_directory"
  default     = null
}

variable "fsx_windows_file_system_automatic_backup_retention_days" {
  description = "(Optional) The number of days to retain automatic backups. Minimum of 0 and maximum of 35. Defaults to 7. Set to 0 to disable."
  default     = 7
}

variable "fsx_windows_file_system_copy_tags_to_backups" {
  description = "(Optional) A boolean flag indicating whether tags on the file system should be copied to backups. Defaults to false."
  default     = false
}

variable "fsx_windows_file_system_daily_automatic_backup_start_time" {
  description = "(Optional) The preferred time (in HH:MM format) to take daily automatic backups, in the UTC time zone."
  default     = null
}

variable "fsx_windows_file_system_kms_key_id" {
  description = "(Optional) ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key."
  default     = null
}

variable "fsx_windows_file_system_security_group_ids" {
  description = "(Optional) A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces."
  default     = null
}

variable "fsx_windows_file_system_skip_final_backup" {
  description = "(Optional) When enabled, will skip the default final backup taken when the file system is deleted. This configuration must be applied separately before attempting to delete the resource to have the desired behavior. Defaults to false."
  default     = false
}

variable "fsx_windows_file_system_weekly_maintenance_start_time" {
  description = "(Optional) The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone."
  default     = null
}

variable "fsx_windows_file_system_self_managed_active_directory" {
  description = "(Optional) Configuration block that Amazon FSx uses to join the Windows File Server instance to your self-managed (including on-premises) Microsoft Active Directory (AD) directory. Cannot be specified with active_directory_id"
  default     = []
}

variable "fsx_windows_file_system_timeouts" {
  description = "Set timeouts for fsx windows file system"
  default     = {}
}

variable "fsx_windows_file_system_name" {
  description = "Set name for fsx windows file system"
  default     = ""
}
