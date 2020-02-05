#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
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

variable "bucket_name" {
    description = "Name for bucket name"
    default     = ""
}

variable "bucket_policy" {
  description   = "(Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  default       = null
}

variable "enable_s3_bucket_website" {
    description = "Enable to create S3 bucket with website"
    default     = false
}

variable "bucket_prefix" {
    description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
    default     = ""
}

variable "s3_bucket_acl" {
    description = "The canned ACL to apply. Defaults to 'private'."
    default     = "private"
}

variable "s3_bucket_versioning" {
    description = "(Optional) A state of versioning"
    default     = []
}

variable "s3_bucket_force_destroy" {
    description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
    default     = false
}

variable "s3_bucket_website" {
    description = "(Optional) A website object "
    default     = []
}

variable "s3_bucket_cors_rule" {
    description = "Cors rules"
    default     = []
}

variable "s3_bucket_logging" {
    description = "(Optional) A settings of bucket logging"
    default     = []
}

variable "enable_lifecycle_rule" {
    description = "Enable lifecycle rule"
    default     = false
}

variable "abort_incomplete_multipart_upload_days" {
  description   = "(Optional) Specifies the number of days after initiating a multipart upload when the multipart upload must be completed."
  default       = null
}

variable "lifecycle_rule_id" {
  description   = "(Optional) Unique identifier for the rule."
  default       = ""
}

variable "lifecycle_rule_prefix" {
    description = "Set prefix for lifecycle rule"
    default     = ""
}

variable "noncurrent_version_expiration_days" {
    description = "(Optional) Specifies when noncurrent object versions expire."
    default     = 90
}

variable "noncurrent_version_transition_days" {
    description = "(Optional) Specifies when noncurrent object versions transitions"
    default     = 30
}

variable "standard_transition_days" {
    description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
    default     = 30
}

variable "glacier_transition_days" {
    description = "Number of days after which to move the data to the glacier storage tier"
    default     = 60
}

variable "expiration_days" {
    description = "Number of days after which to expunge the objects"
    default     = 90
}

# variable "kms_master_key_id" {
#     description = "Set KMS master ket ID"
#     default     = null
# }

# variable "sse_algorithm" {
#   description   = "(required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
#   default       = null
# }

variable "acceleration_status" {
  description   = "(Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended."
  default       = null
}

variable "request_payer" {
  description   = "(Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information."
  default       = null
}

# variable "access_control_translation" {
#   description   = "(Optional) Specifies the overrides to use for object owners on replication. Must be used in conjunction with account_id owner override configuration."
#   default       = []
# }

# variable "object_lock_enabled" {
#   description   = "(Required) Indicates whether this bucket has an Object Lock configuration enabled. Valid value is Enabled."
#   default       = null
# }

# variable "default_retention_mode" {
#   description   = "(Required) The default Object Lock retention mode you want to apply to new objects placed in this bucket. Valid values are GOVERNANCE and COMPLIANCE"
#   default       = null
# }

# variable "default_retention_days" {
#   description   = "(Optional) The number of days that you want to specify for the default retention period."
#   default       = null
# }

# variable "default_retention_years" {
#   description   = "(Optional) The number of years that you want to specify for the default retention period."
#   default       = null
# }

# variable "replication_configuration_role" {
#   description   = "(Required) The ARN of the IAM role for Amazon S3 to assume when replicating the objects."
#   default       = null
# }

# variable "replication_configuration_id" {
#   description   = "(Optional) Unique identifier for the rule."
#   default       = null
# }

# variable "replication_configuration_priority" {
#   description   = "(Optional) The priority associated with the rule."
#   default       = null
# }

# variable "replication_configuration_prefix" {
#   description   = "(Optional) Object keyname prefix identifying one or more objects to which the rule applies."
#   default       = null
# }

# variable "replication_configuration_status" {
#   description   = "(Required) The status of the rule. Either Enabled or Disabled. The rule is ignored if status is not Enabled."
#   default       = null
# }

# variable "replication_configuration_destination_bucket" {
#   description   = "(Required) The ARN of the S3 bucket where you want Amazon S3 to store replicas of the object identified by the rule."
#   default       = null
# }

# variable "replication_configuration_destination_storage_class" {
#   description   = "(Optional) The class of storage used to store the object. Can be STANDARD, REDUCED_REDUNDANCY, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE."
#   default       = null
# }

# variable "replication_configuration_destination_replica_kms_key_id" {
#   description   = "(Optional) Destination KMS encryption key ARN for SSE-KMS replication. Must be used in conjunction with sse_kms_encrypted_objects source selection criteria."
#   default       = null
# }

# variable "replication_configuration_destination_access_control_translation" {
#   description   = "(Optional) Specifies the overrides to use for object owners on replication. Must be used in conjunction with account_id owner override configuration."
#   default       = null
# }

# variable "replication_configuration_destination_account_id" {
#   description   = "(Optional) The Account ID to use for overriding the object owner on replication. Must be used in conjunction with access_control_translation override configuration."
#   default       = null
# }

# variable "sse_kms_encrypted_objects_enabled" {
#   description   = "(Required) Boolean which indicates if this criteria is enabled."
#   default       = null
# }

# variable "replication_configuration_filter_prefix" {
#   description   = "(Optional) Object keyname prefix that identifies subset of objects to which the rule applies."
#   default       = null
# }

#-----------------------------------------------------------
# S3 bucket policy 
#-----------------------------------------------------------
variable "enable_s3_bucket_policy" {
    description = "Enable s3 bucket policy usage"
    default     = false
}

variable "s3_bucket_policy" {
  description   = "(Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  default       = null
}

#-----------------------------------------------------------
# S3 bucket object
#-----------------------------------------------------------
variable "enable_s3_bucket_object" {
    description = "Enable s3 bucket object" 
    default     = false
}

variable "s3_bucket_object_key" {
    description = "(Required) The name of the object once it is in the bucket."
    default     = ""
}

variable "s3_bucket_object_source" {
    description = "(Required unless content or content_base64 is set) The path to a file that will be read and uploaded as raw bytes for the object content."
    default     = null
}

variable "s3_bucket_object_content_type" {
    description = "(Optional) A standard MIME type describing the format of the object data, e.g. application/octet-stream. All Valid MIME Types are valid for this input."
    default     = ""
}

variable "s3_bucket_object_content" {
  description   = "(Optional, conflicts with source and content_base64) Literal string value to use as the object content, which will be uploaded as UTF-8-encoded text."
  default       = null
}

variable "s3_bucket_object_content_base64" {
  description   = "(Optional, conflicts with source and content) Base64-encoded data that will be decoded and uploaded as raw bytes for the object content. This allows safely uploading non-UTF8 binary data, but is recommended only for small content such as the result of the gzipbase64 function with small text strings. For larger objects, use source to stream the content from a disk file."
  default       = null
}

variable "s3_bucket_object_content_disposition" {
  description   = "(Optional) Specifies presentational information for the object. Read w3c content_disposition for further information."
  default       = null
}

variable "s3_bucket_object_content_encoding" {
  description   = "(Optional) Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field. Read w3c content encoding for further information."
  default       = null
}

variable "s3_bucket_object_content_language" {
  description   = "(Optional) The language the content is in e.g. en-US or en-GB."
  default       = null
}

variable "mime_types" {
    description   = ""
    default       = {
        htm     = "text/html"
        html    = "text/html"
        css     = "text/css"
        txt     = "text/plain"
        js      = "application/javascript"
        map     = "application/javascript"
        json    = "application/json"
        zip     = "application/zip"
    }
}

variable "type_of_file" {
    description = "The type that will be used for mime_types"
    default     = "zip"
}

variable "s3_bucket_object_server_side_encryption" {
    description = "(Optional) Specifies server-side encryption of the object in S3. Valid values are 'AES256' and 'aws:kms'."
    default     = null
}

variable "s3_bucket_object_kms_key_id" {
  description   = "(Optional) Specifies the AWS KMS Key ARN to use for object encryption. This value is a fully qualified ARN of the KMS Key. If using aws_kms_key, use the exported arn attribute: kms_key_id = aws_kms_key.foo.arn"
  default       = null
}

variable "s3_bucket_object_acl" {
  description   = "(Optional) The canned ACL to apply. Defaults to 'private'."
  default       = "private"
}

variable "s3_bucket_object_cache_control" {
  description   = "(Optional) Specifies caching behavior along the request/reply chain Read w3c cache_control for further details."
  default       = null
}

variable "s3_bucket_object_website_redirect" {
  description   = "(Optional) Specifies a target URL for website redirect."
  default       = null
}

variable "s3_bucket_object_storage_class" {
  description   = "(Optional) Specifies the desired Storage Class for the object. Can be either 'STANDARD', 'REDUCED_REDUNDANCY', 'ONEZONE_IA', 'INTELLIGENT_TIERING', 'GLACIER', 'DEEP_ARCHIVE', or 'STANDARD_IA'. Defaults to 'STANDARD'."
  default       = "STANDARD"
}

variable "s3_bucket_object_etag" {
  description   = "(Optional) Used to trigger updates. The only meaningful value is filemd5('path/to/file'). This attribute is not compatible with KMS encryption, kms_key_id or server_side_encryption = 'aws:kms'"
  default       = null
}

variable "s3_bucket_object_metadata" {
  description   = "(Optional) A mapping of keys/values to provision metadata (will be automatically prefixed by x-amz-meta-, note that only lowercase label are currently supported by the AWS Go API)."
  default       = null
}

variable "s3_bucket_object_force_destroy" {
  description   = "(Optional) Allow the object to be deleted by removing any legal hold on any object version. Default is false. This value should be set to true only if the bucket has S3 object lock enabled."
  default       = false
}

variable "s3_bucket_object_object_lock_legal_hold_status" {
  description   = "(Optional) The legal hold status that you want to apply to the specified object. Valid values are ON and OFF."
  default       = null
}

variable "s3_bucket_object_object_lock_mode" {
  description   = "(Optional) The object lock retention mode that you want to apply to this object. Valid values are GOVERNANCE and COMPLIANCE."
  default       = null
}

variable "s3_bucket_object_object_lock_retain_until_date" {
  description   = "(Optional) The date and time, in RFC3339 format, when this object's object lock will expire."
  default       = null
}

#-----------------------------------------------------------
# S3 bucket notification 
#-----------------------------------------------------------
variable "enable_s3_bucket_notification" {
    description = "Enable s3 bucket notification usage"
    default     = false
}

variable "s3_bucket_notification_topic" {
    description = "(Optional) The notification configuration to SNS Topic"
    default     = []
}

variable "s3_bucket_notification_queue" {
  description   = "(Optional) The notification configuration to SQS Queue"
  default       = []
}

variable "s3_bucket_notification_lambda_function" {
  description   = "(Optional, Multiple) Used to configure notifications to a Lambda Function"
  default       = []
}

#-----------------------------------------------------------
# S3 bucket metric 
#-----------------------------------------------------------
variable "enable_s3_bucket_metric" {
  description   = "Enable S3 bucket metric usage"
  default       = false
}

variable "s3_bucket_metric_name" {
  description = "Name for S3 bucket metric"
  default     = ""
}

variable "filter_prefix" {
  description   = "(Optional) Object prefix for filtering (singular)."
  default       = null
}

variable "s3_bucket_metric_filter" {
  description   = "(Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags"
  default       = []
}

#-----------------------------------------------------------
# S3 bucket inventory 
#-----------------------------------------------------------
variable "enable_s3_bucket_inventory" {
  description   = "Enable S3 bucket inventory usage"
  default       = false
}

variable "s3_bucket_inventory_name" {
  description   = "Unique identifier of the inventory configuration for the bucket."
  default       = ""
}

variable "included_object_versions" {
  description   = "(Required) Object versions to include in the inventory list. Valid values: All, Current."
  default       = "All"
}

variable "s3_bucket_inventory_enabled" {
  description   = "(Optional, Default: true) Specifies whether the inventory is enabled or disabled."
  default       = true
}

variable "s3_bucket_inventory_optional_fields" {
  description   = "(Optional) List of optional fields that are included in the inventory results. Valid values: Size, LastModifiedDate, StorageClass, ETag, IsMultipartUploaded, ReplicationStatus, EncryptionStatus, ObjectLockRetainUntilDate, ObjectLockMode, ObjectLockLegalHoldStatus, IntelligentTieringAccessTier."
  default       = []
}

variable "schedule_frequency" {
  description   = "(Required) Specifies how frequently inventory results are produced. Valid values: Daily, Weekly."
  default       = null
}

variable "s3_bucket_inventory_filter" {
  description   = "(Optional) Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria"
  default       = []
}

variable "destination_bucket_format" {
  description   = "(Required) Specifies the output format of the inventory results. Can be CSV, ORC or Parquet."
  default       = "ORC"
}

variable "destination_bucket_bucket_arn" {
  description   = "(Required) The Amazon S3 bucket ARN of the destination."
  default       = ""
}

variable "destination_bucket_account_id" {
  description   = "(Optional) The ID of the account that owns the destination bucket. Recommended to be set to prevent problems if the destination bucket ownership changes."
  default       = null
}

variable "destination_bucket_prefix" {
  description   = "(Optional) The prefix that is prepended to all inventory results."
  default       = null
}

variable "destination_bucket_encryption_sse_kms_key_id" {
  description   = "(Required) The ARN of the KMS customer master key (CMK) used to encrypt the inventory file."
  default       = null
}

variable "destination_bucket_encryption_sse_s3" {
  description   = "(Optional) Specifies to use server-side encryption with Amazon S3-managed keys (SSE-S3) to encrypt the inventory file."
  default       = null
}

#---------------------------------------------------
# S3 bucket public access block
#---------------------------------------------------
variable "enable_s3_bucket_public_access_block" {
  description   = "Enable S3 bucket public access block usage"
  default       = false
}

variable "s3_bucket_public_access_block_block_public_acls" {
  description   = "(Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access; PUT Object calls will fail if the request includes an object ACL."
  default       = false
}

variable "s3_bucket_public_access_block_block_public_policy" {
  description   = "(Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access."
  default       = false
}

variable "s3_bucket_public_access_block_ignore_public_acls" {
  description   = "(Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains."
  default       = false
}

variable "s3_bucket_public_access_block_restrict_public_buckets" {
  description   = "(Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy."
  default       = false
}

#---------------------------------------------------
# S3 account public access block
#---------------------------------------------------
variable "enable_s3_account_public_access_block" {
  description   = "Enable S3 account public access block usage"
  default       = false
}

variable "s3_account_public_access_block_account_id" {
  description = "(Optional) AWS account ID to configure. Defaults to automatically determined account ID of the Terraform AWS provider."
  default     = null
}

variable "s3_account_public_access_block_block_public_acls" {
  description   = "(Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access; PUT Object calls will fail if the request includes an object ACL."
  default       = false
}

variable "s3_account_public_access_block_block_public_policy" {
  description   = "(Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access."
  default       = false
}

variable "s3_account_public_access_block_ignore_public_acls" {
  description   = "(Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains."
  default       = false
}

variable "s3_account_public_access_block_restrict_public_buckets" {
  description   = "(Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy."
  default       = false
}