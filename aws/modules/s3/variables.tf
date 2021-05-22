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

#-----------------------------------------------------------
# S3 bucket
#-----------------------------------------------------------
variable "enable_s3_bucket" {
  description = "Enable to create S3 bucket by default"
  default     = false
}

variable "s3_bucket_name" {
  description = "Name for bucket name. Conflicts with s3_bucket_prefix."
  default     = null
}

variable "s3_bucket_prefix" {
  description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with s3_bucket_name."
  default     = null
}

variable "s3_bucket_acl" {
  description = "The canned ACL to apply. Defaults to 'private'."
  default     = null
}

variable "s3_bucket_policy" {
  description = "(Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  default     = null
}

variable "s3_bucket_force_destroy" {
  description = "(Optional) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = null
}

variable "s3_bucket_acceleration_status" {
  description = "(Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended."
  default     = null
}

variable "s3_bucket_request_payer" {
  description = "(Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information."
  default     = null
}

variable "s3_bucket_grant" {
  description = "(Optional) An ACL policy grant (documented below). Conflicts with acl"
  default     = []
}

variable "s3_bucket_website" {
  description = "(Optional) A website object "
  default     = {}
}

variable "s3_bucket_cors_rule" {
  description = "Cors rules"
  default     = []
}

variable "s3_bucket_versioning" {
  description = "(Optional) A state of versioning"
  default     = {}
}

variable "s3_bucket_logging" {
  description = "(Optional) A settings of bucket logging"
  default     = {}
}

variable "s3_bucket_lifecycle_rule" {
  description = "(Optional) A configuration of object lifecycle management"
  type        = any
  default     = []
}

variable "s3_bucket_replication_configuration" {
  description = "(Optional) A configuration of replication configuration"
  default     = {}
}

variable "s3_bucket_object_lock_configuration" {
  description = "(Optional) A configuration of S3 object locking"
  default     = {}
}

variable "s3_bucket_server_side_encryption_configuration" {
  description = "(Optional) A configuration of server-side encryption configuration"
  default     = {}
}

#-----------------------------------------------------------
# S3 bucket policy
#-----------------------------------------------------------
variable "enable_s3_bucket_policy" {
  description = "Enable s3 bucket policy usage"
  default     = false
}

variable "s3_bucket_policy_bucket" {
  description = "The name of the bucket to which to apply the policy."
  default     = ""
}

variable "s3_bucket_policy_policy" {
  description = "(Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  default     = ""
}

#-----------------------------------------------------------
# S3 bucket object
#-----------------------------------------------------------
variable "enable_s3_bucket_object" {
  description = "Enable s3 bucket object"
  default     = false
}

variable "s3_bucket_object_stack" {
  description = "Set properties for s3 bucket object"
  default     = []
}

// variable "mime_types" {
//   description = "Map of mine_types for S3 objects"
//   default = {
//     htm        = "text/html"
//     html       = "text/html"
//     shtml      = "text/html"
//     xml        = "text/xml"
//     xrm-ms     = "text/xml"
//     xsl        = "text/xml"
//     addin      = "text/xml"
//     dtsconfig  = "text/xml"
//     iss        = "text/plain"
//     txt        = "text/plain"
//     cd         = "text/plain"
//     cs         = "text/plain"
//     csproj     = "text/plain"
//     py         = "text/plain"
//     pyw        = "text/plain"
//     rc         = "text/plain"
//     rc2        = "text/plain"
//     rct        = "text/plain"
//     user       = "text/plain"
//     vb         = "text/plain"
//     vbproj     = "text/plain"
//     sln        = "text/plain"
//     vdp        = "text/plain"
//     vdproj     = "text/plain"
//     vspscc     = "text/plain"
//     vsscc      = "text/plain"
//     vssettings = "text/xml"
//     vssscc     = "text/plain"
//     vstemplate = "text/xml"
//     contact    = "text/x-ms-contact"
//     group      = "text/x-ms-group"
//     iqy        = "text/x-ms-iqy"
//     odc        = "text/x-ms-odc"
//     rqy        = "text/x-ms-rqy"
//     vcf        = "text/x-vcard"
//     htc        = "text/x-component"
//     wsc        = "text/scriptlet"
//     sct        = "text/scriptlet"
//     ics        = "text/calendar"
//     css        = "text/css"
//     log        = "text/x-log"
//     ico        = "image/vnd.microsoft.icon"
//     gif        = "image/gif"
//     jpg        = "image/jpeg"
//     png        = "image/png"
//     js         = "application/javascript"
//     json       = "application/json"
//     map        = "application/javascript"
//     zip        = "application/zip"
//     gzip       = "application/x-gzip"
//     gtar       = "application/x-gtar"
//     tgz        = "application/x-tgz"
//     rar        = "application/octet-stream"
//     "7z"       = "application/octet-stream"
//   }
// }

// variable "type_of_file" {
//   description = "The type that will be used for mime_types"
//   default     = "zip"
// }

#-----------------------------------------------------------
# S3 bucket notification
#-----------------------------------------------------------
variable "enable_s3_bucket_notification" {
  description = "Enable s3 bucket notification usage"
  default     = false
}

variable "s3_bucket_notification_bucket" {
  description = "The name of the bucket to put notification configuration."
  default     = ""
}

variable "s3_bucket_notification_topic" {
  description = "(Optional) The notification configuration to SNS Topic"
  default     = []
}

variable "s3_bucket_notification_queue" {
  description = "(Optional) The notification configuration to SQS Queue"
  default     = []
}

variable "s3_bucket_notification_lambda_function" {
  description = "(Optional, Multiple) Used to configure notifications to a Lambda Function"
  default     = []
}

#-----------------------------------------------------------
# S3 bucket metric
#-----------------------------------------------------------
variable "enable_s3_bucket_metric" {
  description = "Enable S3 bucket metric usage"
  default     = false
}

variable "s3_bucket_metric_bucket" {
  description = "The name of the bucket to put metric configuration."
  default     = ""
}

variable "s3_bucket_metric_name" {
  description = "Name for S3 bucket metric"
  default     = ""
}

variable "filter_prefix" {
  description = "(Optional) Object prefix for filtering (singular)."
  default     = null
}

variable "s3_bucket_metric_filter" {
  description = "(Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags"
  default     = []
}

#-----------------------------------------------------------
# S3 bucket inventory
#-----------------------------------------------------------
variable "enable_s3_bucket_inventory" {
  description = "Enable S3 bucket inventory usage"
  default     = false
}

variable "s3_bucket_inventory_name" {
  description = "Unique identifier of the inventory configuration for the bucket."
  default     = ""
}

variable "s3_bucket_inventory_bucket" {
  description = "The name of the bucket to put metric configuration."
  default     = ""
}

variable "s3_bucket_inventory_included_object_versions" {
  description = "(Required) Object versions to include in the inventory list. Valid values: All, Current."
  default     = "All"
}

variable "s3_bucket_inventory_enabled" {
  description = "(Optional, Default: true) Specifies whether the inventory is enabled or disabled."
  default     = null
}

variable "s3_bucket_inventory_optional_fields" {
  description = "(Optional) List of optional fields that are included in the inventory results. Valid values: Size, LastModifiedDate, StorageClass, ETag, IsMultipartUploaded, ReplicationStatus, EncryptionStatus, ObjectLockRetainUntilDate, ObjectLockMode, ObjectLockLegalHoldStatus, IntelligentTieringAccessTier."
  default     = []
}

variable "s3_bucket_inventory_schedule" {
  description = "(Required) Specifies the schedule for generating inventory results"
  default     = []
}

variable "s3_bucket_inventory_filter" {
  description = "(Optional) Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria"
  default     = []
}

variable "s3_bucket_inventory_destination" {
  description = "(Required) Contains information about where to publish the inventory results"
  default     = []
}

#---------------------------------------------------
# S3 bucket public access block
#---------------------------------------------------
variable "enable_s3_bucket_public_access_block" {
  description = "Enable S3 bucket public access block usage"
  default     = false
}

variable "s3_bucket_public_access_block_bucket" {
  description = "S3 Bucket to which this Public Access Block configuration should be applied."
  default     = ""
}

variable "s3_bucket_public_access_block_block_public_acls" {
  description = "(Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access; PUT Object calls will fail if the request includes an object ACL."
  default     = null
}

variable "s3_bucket_public_access_block_block_public_policy" {
  description = "(Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access."
  default     = null
}

variable "s3_bucket_public_access_block_ignore_public_acls" {
  description = "(Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains."
  default     = null
}

variable "s3_bucket_public_access_block_restrict_public_buckets" {
  description = "(Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy."
  default     = null
}

#---------------------------------------------------
# S3 account public access block
#---------------------------------------------------
variable "enable_s3_account_public_access_block" {
  description = "Enable S3 account public access block usage"
  default     = false
}

variable "s3_account_public_access_block_account_id" {
  description = "(Optional) AWS account ID to configure. Defaults to automatically determined account ID of the Terraform AWS provider."
  default     = null
}

variable "s3_account_public_access_block_block_public_acls" {
  description = "(Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access; PUT Object calls will fail if the request includes an object ACL."
  default     = null
}

variable "s3_account_public_access_block_block_public_policy" {
  description = "(Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access."
  default     = null
}

variable "s3_account_public_access_block_ignore_public_acls" {
  description = "(Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains."
  default     = null
}

variable "s3_account_public_access_block_restrict_public_buckets" {
  description = "(Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy."
  default     = null
}

#---------------------------------------------------
# AWS S3 access point
#---------------------------------------------------
variable "enable_s3_access_point" {
  description = "Enable s3 access point usage"
  default     = false
}

variable "s3_access_point_bucket" {
  description = "The name of an AWS Partition S3 Bucket or the Amazon Resource Name (ARN) of S3 on Outposts Bucket that you want to associate this access point with."
  default     = ""
}

variable "s3_access_point_name" {
  description = "The name you want to assign to this access point."
  default     = ""
}

variable "s3_access_point_account_id" {
  description = "(Optional) The AWS account ID for the owner of the bucket for which you want to create an access point. Defaults to automatically determined account ID of the Terraform AWS provider."
  default     = null
}

variable "s3_access_point_policy" {
  description = "(Optional) A valid JSON document that specifies the policy that you want to apply to this access point."
  default     = null
}

variable "s3_access_point_public_access_block_configuration" {
  description = "(Optional) Configuration block to manage the PublicAccessBlock configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination."
  default     = []
}

variable "s3_access_point_vpc_configuration" {
  description = "(Optional) Configuration block to restrict access to this access point to requests from the specified Virtual Private Cloud (VPC). Required for S3 on Outposts."
  default     = []
}

#---------------------------------------------------
# AWS S3 bucket analytics configuration
#---------------------------------------------------
variable "enable_s3_bucket_analytics_configuration" {
  description = "Enable s3 bucket analytics configuration usage"
  default     = false
}

variable "s3_bucket_analytics_configuration_bucket" {
  description = "The name of the bucket this analytics configuration is associated with."
  default     = ""
}

variable "s3_bucket_analytics_configuration_name" {
  description = "Unique identifier of the analytics configuration for the bucket."
  default     = ""
}

variable "s3_bucket_analytics_configuration_filter" {
  description = "(Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags"
  default     = []
}

variable "s3_bucket_analytics_configuration_storage_class_analysis" {
  description = "(Optional) Configuration for the analytics data export"
  default     = []
}

#---------------------------------------------------
# AWS S3 bucket ownership controls
#---------------------------------------------------
variable "enable_s3_bucket_ownership_controls" {
  description = "Enable s3 bucket ownership controls usage"
  default     = false
}

variable "s3_bucket_ownership_controls_bucket" {
  description = "The name of the bucket that you want to associate this access point with."
  default     = ""
}

variable "s3_bucket_ownership_controls_rule" {
  description = "(Required) Configuration block(s) with Ownership Controls rules."
  default     = []
}

#
#
#
variable "AAAA" {
  description = "AAAA"
  default     = null
}