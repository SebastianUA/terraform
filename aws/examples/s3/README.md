# Work with AWS S3 via terraform

A terraform module for working with S3.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                     = "us-west-2"
    profile                    = "default"
    shared_credentials_file    = pathexpand("~/.aws/credentials")
}

module "s3" {
    source                                  = "../../modules/s3"
    name                                    = "TEST"
    environment                             = "NonPROD"
    region                                  = "us-west-2"

    enable_s3_bucket                        = true
    s3_bucket_name                          = "natarov-test-bucket"
    s3_bucket_acl                           = "private"
    s3_bucket_cors_rule                     = []

    s3_bucket_versioning                    = []
    enable_lifecycle_rule                   = true
    
    # Add policy to the bucket
    enable_s3_bucket_policy                 = false

    # Add files to bucket
    enable_s3_bucket_object                 = true
    s3_bucket_object_source                 = ["additional_files/test.txt", "additional_files/test2.txt"]
    type_of_file                            = "txt"

}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default     = {}`).
- `enable_s3_bucket` - Enable to create S3 bucket by default (`default     = false`).
- `s3_bucket_name` - Name for bucket name. Conflicts with s3_bucket_prefix. (`default     = null`).
- `s3_bucket_prefix` - Creates a unique bucket name beginning with the specified prefix. Conflicts with s3_bucket_name. (`  default     = null`).
- `bucket_policy` - (Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. (`default       = null`).
- `enable_s3_bucket_website` - Enable to create S3 bucket with website (`default     = false`).
- `s3_bucket_acl` - The canned ACL to apply. Defaults to 'private'. (`default     = "private"`).
- `s3_bucket_versioning` - (Optional) A state of versioning (`  default     = []`).
- `s3_bucket_force_destroy` - A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. (`default     = false`).
- `s3_bucket_website` - (Optional) A website object  (`default     = []`).
- `s3_bucket_cors_rule` - Cors rules (`  default     = []`).
- `s3_bucket_logging` - (Optional) A settings of bucket logging (`  default     = []`).
- `enable_lifecycle_rule` - Enable lifecycle rule (`  default     = false`).
- `abort_incomplete_multipart_upload_days` - (Optional) Specifies the number of days after initiating a multipart upload when the multipart upload must be completed. (`default       = null`).
- `lifecycle_rule_id` - (Optional) Unique identifier for the rule. (`default       = ""`).
- `lifecycle_rule_prefix` - Set prefix for lifecycle rule (`default     = ""`).
- `noncurrent_version_expiration_days` - (Optional) Specifies when noncurrent object versions expire. (`default     = 90`).
- `noncurrent_version_transition_days` - (Optional) Specifies when noncurrent object versions transitions (`default     = 30`).
- `standard_transition_days` - Number of days to persist in the standard storage tier before moving to the infrequent access tier (`  default     = 30`).
- `glacier_transition_days` - Number of days after which to move the data to the glacier storage tier (`  default     = 60`).
- `expiration_days` - Number of days after which to expunge the objects (`  default     = 90`).
- `acceleration_status` - (Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended. (`default       = null`).
- `request_payer` - (Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information. (`default       = null`).
- `enable_s3_bucket_policy` - Enable s3 bucket policy usage (`  default     = false`).
- `s3_bucket_policy_bucket` - The name of the bucket to which to apply the policy. (`default     = ""`).
- `s3_bucket_policy` - (Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. (`default       = ""`).
- `enable_s3_bucket_object` - Enable s3 bucket object (`default     = false`).
- `s3_bucket_object_bucket` - The name of the bucket to put the file in. (`default     = ""`).
- `s3_bucket_object_key` - (Required) The name of the object once it is in the bucket. (`default     = ""`).
- `s3_bucket_object_source` - (Required unless content or content_base64 is set) The path to a file that will be read and uploaded as raw bytes for the object content. (`default     = null`).
- `s3_bucket_object_content_type` - (Optional) A standard MIME type describing the format of the object data, e.g. application/octet-stream. All Valid MIME Types are valid for this input. (`  default     = ""`).
- `s3_bucket_object_content` - (Optional, conflicts with source and content_base64) Literal string value to use as the object content, which will be uploaded as UTF-8-encoded text. (`default       = null`).
- `s3_bucket_object_content_base64` - (Optional, conflicts with source and content) Base64-encoded data that will be decoded and uploaded as raw bytes for the object content. This allows safely uploading non-UTF8 binary data, but is recommended only for small content such as the result of the gzipbase64 function with small text strings. For larger objects, use source to stream the content from a disk file. (`default       = null`).
- `s3_bucket_object_content_disposition` - (Optional) Specifies presentational information for the object. Read w3c content_disposition for further information. (`default       = null`).
- `s3_bucket_object_content_encoding` - (Optional) Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field. Read w3c content encoding for further information. (`default       = null`).
- `s3_bucket_object_content_language` - (Optional) The language the content is in e.g. en-US or en-GB. (`default       = null`).
- `mime_types` -  Set mine tile (`  default       = {}`).
- `type_of_file` - The type that will be used for mime_types (`  default     = "zip"`).
- `s3_bucket_object_server_side_encryption` - (Optional) Specifies server-side encryption of the object in S3. Valid values are 'AES256' and 'aws:kms'. (`  default     = null`).
- `s3_bucket_object_kms_key_id` - (Optional) Specifies the AWS KMS Key ARN to use for object encryption. This value is a fully qualified ARN of the KMS Key. If using aws_kms_key, use the exported arn attribute: kms_key_id = aws_kms_key.foo.arn (`default       = null`).
- `s3_bucket_object_acl` - (Optional) The canned ACL to apply. Defaults to 'private'. (`default       = "private"`).
- `s3_bucket_object_cache_control` - (Optional) Specifies caching behavior along the request/reply chain Read w3c cache_control for further details. (`default       = null`).
- `s3_bucket_object_website_redirect` - (Optional) Specifies a target URL for website redirect. (`default       = null`).
- `s3_bucket_object_storage_class` - (Optional) Specifies the desired Storage Class for the object. Can be either 'STANDARD', 'REDUCED_REDUNDANCY', 'ONEZONE_IA', 'INTELLIGENT_TIERING', 'GLACIER', 'DEEP_ARCHIVE', or 'STANDARD_IA'. Defaults to 'STANDARD'. (`default       = "STANDARD"`).
- `s3_bucket_object_etag` - (Optional) Used to trigger updates. The only meaningful value is filemd5('path/to/file'). This attribute is not compatible with KMS encryption, kms_key_id or server_side_encryption = 'aws:kms' (`default       = null`).
- `s3_bucket_object_metadata` - (Optional) A mapping of keys/values to provision metadata (will be automatically prefixed by x-amz-meta-, note that only lowercase label are currently supported by the AWS Go API). (`default       = null`).
- `s3_bucket_object_force_destroy` - (Optional) Allow the object to be deleted by removing any legal hold on any object version. Default is false. This value should be set to true only if the bucket has S3 object lock enabled. (`default       = false`).
- `s3_bucket_object_object_lock_legal_hold_status` - (Optional) The legal hold status that you want to apply to the specified object. Valid values are ON and OFF. (`default       = null`).
- `s3_bucket_object_object_lock_mode` - (Optional) The object lock retention mode that you want to apply to this object. Valid values are GOVERNANCE and COMPLIANCE. (`default       = null`).
- `s3_bucket_object_object_lock_retain_until_date` - (Optional) The date and time, in RFC3339 format, when this object's object lock will expire. (`default       = null`).
- `enable_s3_bucket_notification` - Enable s3 bucket notification usage (`  default     = false`).
- `s3_bucket_notification_bucket` - The name of the bucket to put notification configuration. (`default     = ""`).
- `s3_bucket_notification_topic` - (Optional) The notification configuration to SNS Topic (`  default     = []`).
- `s3_bucket_notification_queue` - (Optional) The notification configuration to SQS Queue (`default       = []`).
- `s3_bucket_notification_lambda_function` - (Optional, Multiple) Used to configure notifications to a Lambda Function (`default       = []`).
- `enable_s3_bucket_metric` - Enable S3 bucket metric usage (`default       = false`).
- `s3_bucket_metric_bucket` - The name of the bucket to put metric configuration. (`default     = ""`).
- `s3_bucket_metric_name` - Name for S3 bucket metric (`default     = ""`).
- `filter_prefix` - (Optional) Object prefix for filtering (singular). (`default       = null`).
- `s3_bucket_metric_filter` - (Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags (`default       = []`).
- `enable_s3_bucket_inventory` - Enable S3 bucket inventory usage (`default       = false`).
- `s3_bucket_inventory_bucket` - The name of the bucket to put metric configuration. (`default     = ""`).
- `s3_bucket_inventory_name` - Unique identifier of the inventory configuration for the bucket. (`default       = ""`).
- `included_object_versions` - (Required) Object versions to include in the inventory list. Valid values: All, Current. (`default       = "All"`).
- `s3_bucket_inventory_enabled` - (Optional, Default: true) Specifies whether the inventory is enabled or disabled. (`default       = true`).
- `s3_bucket_inventory_optional_fields` - (Optional) List of optional fields that are included in the inventory results. Valid values: Size, LastModifiedDate, StorageClass, ETag, IsMultipartUploaded, ReplicationStatus, EncryptionStatus, ObjectLockRetainUntilDate, ObjectLockMode, ObjectLockLegalHoldStatus, IntelligentTieringAccessTier. (`default       = []`).
- `schedule_frequency` - (Required) Specifies how frequently inventory results are produced. Valid values: Daily, Weekly. (`default       = null`).
- `s3_bucket_inventory_filter` - (Optional) Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria (`default       = []`).
- `destination_bucket_format` - (Required) Specifies the output format of the inventory results. Can be CSV, ORC or Parquet. (`default       = "ORC"`).
- `destination_bucket_bucket_arn` - (Required) The Amazon S3 bucket ARN of the destination. (`default       = ""`).
- `destination_bucket_account_id` - (Optional) The ID of the account that owns the destination bucket. Recommended to be set to prevent problems if the destination bucket ownership changes. (`default       = null`).
- `destination_bucket_prefix` - (Optional) The prefix that is prepended to all inventory results. (`default       = null`).
- `destination_bucket_encryption_sse_kms_key_id` - (Required) The ARN of the KMS customer master key (CMK) used to encrypt the inventory file. (`default       = null`).
- `destination_bucket_encryption_sse_s3` - (Optional) Specifies to use server-side encryption with Amazon S3-managed keys (SSE-S3) to encrypt the inventory file. (`default       = null`).
- `enable_s3_bucket_public_access_block` - Enable S3 bucket public access block usage (`default       = false`).
- `s3_bucket_public_access_block_bucket` - S3 Bucket to which this Public Access Block configuration should be applied. (`default     = ""`).
- `s3_bucket_public_access_block_block_public_acls` - (Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access; PUT Object calls will fail if the request includes an object ACL. (`default       = false`).
- `s3_bucket_public_access_block_block_public_policy` - (Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access. (`default       = false`).
- `s3_bucket_public_access_block_ignore_public_acls` - (Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains. (`default       = false`).
- `s3_bucket_public_access_block_restrict_public_buckets` - (Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy. (`default       = false`).
- `enable_s3_account_public_access_block` - Enable S3 account public access block usage (`default       = false`).
- `s3_account_public_access_block_account_id` - (Optional) AWS account ID to configure. Defaults to automatically determined account ID of the Terraform AWS provider. (`default     = null`).
- `s3_account_public_access_block_block_public_acls` - (Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access; PUT Object calls will fail if the request includes an object ACL. (`default       = false`).
- `s3_account_public_access_block_block_public_policy` - (Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access. (`default       = false`).
- `s3_account_public_access_block_ignore_public_acls` - (Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains. (`default       = false`).
- `s3_account_public_access_block_restrict_public_buckets` - (Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy. (`default       = false`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
