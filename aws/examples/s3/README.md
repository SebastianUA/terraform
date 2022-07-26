# Work with S3 via terraform

A terraform module for making S3.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
  }

}

provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "default"
}

module "s3_private_bucket" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket1"

  // Enable S3 bucket ACL
  enable_s3_bucket_acl = true
  s3_bucket_acl_acl    = "private"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  // AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket2"

  // Enable versioning for S3 bucket
  enable_s3_bucket_versioning = true
  s3_bucket_versioning_versioning_configuration = {
    status = "Enabled"
  }

  // Enable S3 bucket CORS configuration
  enable_s3_bucket_cors_configuration = true
  s3_bucket_cors_configuration_cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://s3-website-test.hashicorp.com"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    },
    {
      allowed_headers = ["tmp"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://s3-website.hashicorp.com"]
      expose_headers  = ["ETag"]
      max_age_seconds = 300
    }
  ]

  // Enable S3 bucket logging
  enable_s3_bucket_logging        = true
  s3_bucket_logging_target_prefix = "logs/"
  s3_bucket_logging_target_bucket = "log_bucket_here"
  s3_bucket_logging_target_grant  = []


  // Enable S3 bucket server side encryption configuration
  enable_s3_bucket_server_side_encryption_configuration = false
  s3_bucket_server_side_encryption_configuration_rule = [
    {
      kms_master_key_id = "kms_key_arn_here"

      sse_algorithm = "aws:kms"
    }
  ]

  // Enable S3 bucket ACL
  enable_s3_bucket_acl = true
  s3_bucket_acl_acl    = "private"


  // Enable S3 bucket website configuration
  enable_s3_bucket_website_configuration = true
  s3_bucket_website_configuration_index_document = {
    suffix = "index.tml"
  }
  s3_bucket_website_configuration_error_document = {
    key = "error.tml"
  }

  s3_bucket_website_configuration_routing_rule = [
    {
      condition = {
        key_prefix_equals = "docs/"
      }
      redirect = {
        replace_key_prefix_with = "documents/"
      }
    }
  ]


  // Enable S3 bucket lifecycle configuration
  enable_s3_bucket_lifecycle_configuration = true
  s3_bucket_lifecycle_configuration_rule = [
    {
      id     = "log"
      status = "Enabled"

      filter = {
        and = [
          {
            prefix = "log/"
            tags = {
              rule      = "log"
              autoclean = "true"
            }
          }
        ]
      }

      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "GLACIER"
        }
      ]

      expiration = {
        days = 90
      }

      noncurrent_version_expiration = {
        days = 30
      }

      noncurrent_version_transition = [
        {
          days          = 60
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "ONEZONE_IA"
        },
        {
          days          = 180
          storage_class = "GLACIER"
        }
      ]

    }
  ]

  // Add files to bucket
  enable_s3_object = true
  s3_object_stack = [
    {
      key = "additional_files/test.txt"
    },
    {
      key                 = "additional_files/test2.txt"
      source              = null
      content_type        = null
      content             = null
      content_base64      = null
      content_disposition = null
      content_encoding    = null
      content_language    = null

      acl              = null
      cache_control    = null
      website_redirect = null
      storage_class    = null
      etag             = null
      metadata         = null
      force_destroy    = null

      server_side_encryption = null
      kms_key_id             = null

      object_lock_legal_hold_status = null
      object_lock_mode              = null
      object_lock_retain_until_date = null
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "s3_bucket_public_access_block" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket3"

  # Enable S3 bucket ACL
  enable_s3_bucket_acl = true
  s3_bucket_acl_acl    = "private"

  # AWS S3 bucket public access block
  enable_s3_bucket_public_access_block = true

  s3_bucket_public_access_block_block_public_acls       = true
  s3_bucket_public_access_block_block_public_policy     = true
  s3_bucket_public_access_block_ignore_public_acls      = true
  s3_bucket_public_access_block_restrict_public_buckets = true

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_s3_bucket` - Enable to create S3 bucket by default (`default = False`)
- `s3_bucket_name` - Name for bucket name. Conflicts with s3_bucket_prefix. (`default = null`)
- `s3_bucket_prefix` - Creates a unique bucket name beginning with the specified prefix. Conflicts with s3_bucket_name. (`default = null`)
- `s3_bucket_force_destroy` - (Optional) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. (`default = null`)
- `s3_bucket_object_lock_enabled` - (Optional, Default:false, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. (`default = null`)
- `enable_s3_bucket_policy` - Enable s3 bucket policy usage (`default = False`)
- `s3_bucket_policy_bucket` - The name of the bucket to which to apply the policy. (`default = ""`)
- `s3_bucket_policy_policy` - (Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. (`default = ""`)
- `enable_s3_object` - Enable s3 object usage (`default = False`)
- `s3_object_stack` - Set properties for s3 object (`default = []`)
- `enable_s3_bucket_object_copy` - Enable s3 bucket object copy (`default = False`)
- `s3_bucket_object_copy_stack` - Set s3 bucket object copy stack (`default = []`)
- `enable_s3_bucket_notification` - Enable s3 bucket notification usage (`default = False`)
- `s3_bucket_notification_bucket` - The name of the bucket to put notification configuration. (`default = ""`)
- `s3_bucket_notification_topic` - (Optional) The notification configuration to SNS Topic (`default = []`)
- `s3_bucket_notification_queue` - (Optional) The notification configuration to SQS Queue (`default = []`)
- `s3_bucket_notification_lambda_function` - (Optional, Multiple) Used to configure notifications to a Lambda Function (`default = []`)
- `s3_bucket_notification_eventbridge` - (Optional) Whether to enable Amazon EventBridge notifications. (`default = null`)
- `enable_s3_bucket_metric` - Enable S3 bucket metric usage (`default = False`)
- `s3_bucket_metric_bucket` - The name of the bucket to put metric configuration. (`default = ""`)
- `s3_bucket_metric_name` - Name for S3 bucket metric (`default = ""`)
- `filter_prefix` - (Optional) Object prefix for filtering (singular). (`default = null`)
- `s3_bucket_metric_filter` - (Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags (`default = []`)
- `enable_s3_bucket_inventory` - Enable S3 bucket inventory usage (`default = False`)
- `s3_bucket_inventory_name` - Unique identifier of the inventory configuration for the bucket. (`default = ""`)
- `s3_bucket_inventory_bucket` - The name of the bucket to put metric configuration. (`default = ""`)
- `s3_bucket_inventory_included_object_versions` - (Required) Object versions to include in the inventory list. Valid values: All, Current. (`default = All`)
- `s3_bucket_inventory_enabled` - (Optional, Default: true) Specifies whether the inventory is enabled or disabled. (`default = null`)
- `s3_bucket_inventory_optional_fields` - (Optional) List of optional fields that are included in the inventory results. Valid values: Size, LastModifiedDate, StorageClass, ETag, IsMultipartUploaded, ReplicationStatus, EncryptionStatus, ObjectLockRetainUntilDate, ObjectLockMode, ObjectLockLegalHoldStatus, IntelligentTieringAccessTier. (`default = []`)
- `s3_bucket_inventory_schedule` - (Required) Specifies the schedule for generating inventory results (`default = []`)
- `s3_bucket_inventory_filter` - (Optional) Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria (`default = []`)
- `s3_bucket_inventory_destination` - (Required) Contains information about where to publish the inventory results (`default = []`)
- `enable_s3_bucket_public_access_block` - Enable S3 bucket public access block usage (`default = False`)
- `s3_bucket_public_access_block_bucket` - S3 Bucket to which this Public Access Block configuration should be applied. (`default = ""`)
- `s3_bucket_public_access_block_block_public_acls` - (Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access; PUT Object calls will fail if the request includes an object ACL. (`default = null`)
- `s3_bucket_public_access_block_block_public_policy` - (Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access. (`default = null`)
- `s3_bucket_public_access_block_ignore_public_acls` - (Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains. (`default = null`)
- `s3_bucket_public_access_block_restrict_public_buckets` - (Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy. (`default = null`)
- `enable_s3_account_public_access_block` - Enable S3 account public access block usage (`default = False`)
- `s3_account_public_access_block_account_id` - (Optional) AWS account ID to configure. Defaults to automatically determined account ID of the Terraform AWS provider. (`default = null`)
- `s3_account_public_access_block_block_public_acls` - (Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access; PUT Object calls will fail if the request includes an object ACL. (`default = null`)
- `s3_account_public_access_block_block_public_policy` - (Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access. (`default = null`)
- `s3_account_public_access_block_ignore_public_acls` - (Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains. (`default = null`)
- `s3_account_public_access_block_restrict_public_buckets` - (Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy. (`default = null`)
- `enable_s3_access_point` - Enable s3 access point usage (`default = False`)
- `s3_access_point_bucket` - The name of an AWS Partition S3 Bucket or the Amazon Resource Name (ARN) of S3 on Outposts Bucket that you want to associate this access point with. (`default = ""`)
- `s3_access_point_name` - The name you want to assign to this access point. (`default = ""`)
- `s3_access_point_account_id` - (Optional) The AWS account ID for the owner of the bucket for which you want to create an access point. Defaults to automatically determined account ID of the Terraform AWS provider. (`default = null`)
- `s3_access_point_policy` - (Optional) A valid JSON document that specifies the policy that you want to apply to this access point. (`default = null`)
- `s3_access_point_public_access_block_configuration` - (Optional) Configuration block to manage the PublicAccessBlock configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination. (`default = {}`)
- `s3_access_point_vpc_configuration` - (Optional) Configuration block to restrict access to this access point to requests from the specified Virtual Private Cloud (VPC). Required for S3 on Outposts. (`default = []`)
- `enable_s3_bucket_analytics_configuration` - Enable s3 bucket analytics configuration usage (`default = False`)
- `s3_bucket_analytics_configuration_bucket` - The name of the bucket this analytics configuration is associated with. (`default = ""`)
- `s3_bucket_analytics_configuration_name` - Unique identifier of the analytics configuration for the bucket. (`default = ""`)
- `s3_bucket_analytics_configuration_filter` - (Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags (`default = []`)
- `s3_bucket_analytics_configuration_storage_class_analysis` - (Optional) Configuration for the analytics data export (`default = []`)
- `enable_s3_bucket_ownership_controls` - Enable s3 bucket ownership controls usage (`default = False`)
- `s3_bucket_ownership_controls_bucket` - The name of the bucket that you want to associate this access point with. (`default = ""`)
- `s3_bucket_ownership_controls_rule` - (Required) Configuration block(s) with Ownership Controls rules. (`default = []`)
- `enable_s3_bucket_request_payment_configuration` - Enable s3 bucket request payment configuration usage (`default = False`)
- `s3_bucket_request_payment_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_request_payment_configuration_payer` - (Required) Specifies who pays for the download and request fees. Valid values: BucketOwner, Requester (`default = null`)
- `s3_bucket_request_payment_configuration_expected_bucket_owner` - (Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `enable_s3_bucket_versioning` - Enable s3 bucket versioning usage (`default = False`)
- `s3_bucket_versioning_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_versioning_expected_bucket_owner` - (Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `s3_bucket_versioning_mfa` - (Optional, Required if versioning_configuration mfa_delete is enabled) The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device. (`default = null`)
- `s3_bucket_versioning_versioning_configuration` - (Required) Configuration block for the versioning parameters (`default = {}`)
- `enable_s3_bucket_accelerate_configuration` - Enable s3 bucket accelerate configuration usage (`default = False`)
- `s3_bucket_accelerate_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_accelerate_configuration_status` - (Required) The transfer acceleration state of the bucket. Valid values: Enabled, Suspended (`default = null`)
- `s3_bucket_accelerate_configuration_expected_bucket_owner` - (Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `enable_s3_bucket_cors_configuration` - Enable s3 bucket cors configuration usage (`default = False`)
- `s3_bucket_cors_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_cors_configuration_expected_bucket_owner` - (Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `s3_bucket_cors_configuration_cors_rule` - (Required) Set of origins and methods (cross-origin access that you want to allow) documented below. You can configure up to 100 rules. (`default = []`)
- `enable_s3_bucket_intelligent_tiering_configuration` - Enable s3 bucket intelligent tiering configuration usage (`default = False`)
- `s3_bucket_intelligent_tiering_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_intelligent_tiering_configuration_name` - The unique name used to identify the S3 Intelligent-Tiering configuration for the bucket. (`default = ""`)
- `s3_bucket_intelligent_tiering_configuration_status` - (Optional) Specifies the status of the configuration. Valid values: Enabled, Disabled. (`default = null`)
- `s3_bucket_intelligent_tiering_configuration_filter` - (Optional) A bucket filter. The configuration only includes objects that meet the filter's criteria (`default = []`)
- `s3_bucket_intelligent_tiering_configuration_tiering` - (Required) The S3 Intelligent-Tiering storage class tiers of the configuration (`default = []`)
- `enable_s3_bucket_object_lock_configuration` - Enable s3 bucket object lock configuration usage (`default = False`)
- `s3_bucket_object_lock_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_object_lock_configuration_rule` - (Required) Configuration block for specifying the Object Lock rule for the specified object (`default = []`)
- `s3_bucket_object_lock_configuration_expected_bucket_owner` - (Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `s3_bucket_object_lock_configuration_object_lock_enabled` - (Optional, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. Defaults to Enabled. Valid values: Enabled (`default = null`)
- `s3_bucket_object_lock_configuration_token` - (Optional) A token to allow Object Lock to be enabled for an existing bucket. You must contact AWS support for the bucket's 'Object Lock token'. The token is generated in the back-end when versioning is enabled on a bucket. For more details on versioning, see the aws_s3_bucket_versioning resource. (`default = null`)
- `enable_s3_bucket_server_side_encryption_configuration` - Enable s3 bucket server side encryption configuration usage (`default = False`)
- `s3_bucket_server_side_encryption_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_server_side_encryption_configuration_rule` - (Required) Set of server-side encryption configuration rules. documented below. Currently, only a single rule is supported. (`default = []`)
- `s3_bucket_server_side_encryption_configuration_expected_bucket_owner` - Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `enable_s3_bucket_logging` - Enable s3 bucket logging usage (`default = False`)
- `s3_bucket_logging_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_logging_target_bucket` - (Required) The name of the bucket where you want Amazon S3 to store server access logs. (`default = null`)
- `s3_bucket_logging_target_prefix` - (Required) A prefix for all log object keys. (`default = null`)
- `s3_bucket_logging_expected_bucket_owner` - (Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `s3_bucket_logging_target_grant` - (Optional) Set of configuration blocks with information for granting permissions (`default = []`)
- `enable_s3_bucket_acl` - Enable s3 bucket acl usage (`default = False`)
- `s3_bucket_acl_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_acl_expected_bucket_owner` - (Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `s3_bucket_acl_acl` - (Optional, Conflicts with access_control_policy) The canned ACL to apply to the bucket. (`default = null`)
- `s3_bucket_acl_access_control_policy` - (Optional, Conflicts with acl) A configuration block that sets the ACL permissions for an object per grantee (`default = []`)
- `enable_s3_bucket_replication_configuration` - Enable s3 bucket replication configuration usage (`default = False`)
- `s3_bucket_replication_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_replication_configuration_role` - (Required) The ARN of the IAM role for Amazon S3 to assume when replicating the objects. (`default = null`)
- `s3_bucket_replication_configuration_token` - (Optional) A token to allow replication to be enabled on an Object Lock-enabled bucket. You must contact AWS support for the bucket's 'Object Lock token'. For more details, see Using S3 Object Lock with replication. (`default = null`)
- `s3_bucket_replication_configuration_rule` - (Required) List of configuration blocks describing the rules managing the replication (`default = []`)
- `enable_s3_bucket_website_configuration` - Enable s3 bucket website configuration usage (`default = False`)
- `s3_bucket_website_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_website_configuration_index_document` - (Optional, Required if redirect_all_requests_to is not specified) The name of the index document for the website (`default = {}`)
- `s3_bucket_website_configuration_error_document` - (Optional, Conflicts with redirect_all_requests_to) The name of the error document for the website (`default = {}`)
- `s3_bucket_website_configuration_routing_rule` - (Optional, Conflicts with redirect_all_requests_to) List of rules that define when a redirect is applied and the redirect behavior (`default = []`)
- `s3_bucket_website_configuration_expected_bucket_owner` - (Optional, Forces new resource) The account ID of the expected bucket owner. (`default = null`)
- `s3_bucket_website_configuration_redirect_all_requests_to` - (Optional, Required if index_document is not specified) The redirect behavior for every request to this bucket's website endpoint detailed below. Conflicts with error_document, index_document, and routing_rule (`default = []`)
- `enable_s3_bucket_lifecycle_configuration` - Enable s3 bucket lifecycle configuration usage (`default = False`)
- `s3_bucket_lifecycle_configuration_bucket` - The name of the bucket (`default = ""`)
- `s3_bucket_lifecycle_configuration_rule` - (Required) List of configuration blocks describing the rules managing the replication (`default = []`)
- `s3_bucket_lifecycle_configuration_expected_bucket_owner` - (Optional) The account ID of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP 403 (Access Denied) error. (`default = null`)

## Module Output Variables
----------------------
- `s3_bucket_id` - The name of the bucket.
- `s3_bucket_arn` - The ARN of the bucket. Will be of format arn:aws:s3:::bucketname.
- `s3_bucket_bucket_domain_name` - The bucket domain name. Will be of format bucketname.s3.amazonaws.com.
- `s3_bucket_bucket_bucket_regional_domain_name` - The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL.
- `s3_bucket_bucket_hosted_zone_id` - The Route 53 Hosted Zone ID for this bucket's region.
- `s3_bucket_bucket_region` - The AWS region this bucket resides in.
- `s3_bucket_bucket_website_endpoint` - The website endpoint, if the bucket is configured with a website. If not, this will be an empty string.
- `s3_bucket_bucket_website_domain` - The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records.
- `s3_object_id` - The key of the resource supplied above
- `s3_object_etag` - The ETag generated for the object (an MD5 sum of the object content). For plaintext objects or objects encrypted with an AWS-managed key, the hash is an MD5 digest of the object data. For objects encrypted with a KMS key or objects created by either the Multipart Upload or Part Copy operation, the hash is not an MD5 digest, regardless of the method of encryption.
- `s3_object_version_id` - A unique version ID value for the object, if bucket versioning is enabled.
- `s3_object_copy_id` - The key of the resource supplied above.
- `s3_object_copy_etag` - The ETag generated for the object (an MD5 sum of the object content). For plaintext objects or objects encrypted with an AWS-managed key, the hash is an MD5 digest of the object data. For objects encrypted with a KMS key or objects created by either the Multipart Upload or Part Copy operation, the hash is not an MD5 digest, regardless of the method of encryption. More information on possible values can be found on Common Response Headers.
- `s3_object_copy_version_id` - Version ID of the newly created copy.
- `s3_object_copy_expiration` - If the object expiration is configured, this attribute will be set.
- `s3_object_copy_last_modified` - Returns the date that the object was last modified, in RFC3339 format.
- `s3_object_copy_request_charged` - If present, indicates that the requester was successfully charged for the request.
- `s3_object_copy_source_version_id` - Version of the copied object in the source bucket.
- `s3_object_copy_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block
- `s3_bucket_policy_id` - ID of S3 bucket policy
- `s3_bucket_notification_id` - ID of S3 bucket notification
- `s3_bucket_metric_id` - ID of S3 bucket metric
- `s3_bucket_inventory_id` - ID of S3 bucket inventory
- `s3_bucket_public_access_block_id` - Name of the S3 bucket the configuration is attached to
- `s3_account_public_access_block_id` - Name of the S3 bucket the configuration is attached to
- `s3_access_point_id` - For Access Point of an AWS Partition S3 Bucket, the AWS account ID and access point name separated by a colon (:). For S3 on Outposts Bucket, the Amazon Resource Name (ARN) of the Access Point.
- `s3_access_point_arn` - Amazon Resource Name (ARN) of the S3 Access Point.
- `s3_access_point_domain_name` - The DNS domain name of the S3 Access Point in the format name-account_id.s3-accesspoint.region.amazonaws.com. Note: S3 access points only support secure access by HTTPS. HTTP isn't supported.
- `s3_access_point_has_public_access_policy` - Indicates whether this access point currently has a policy that allows public access.
- `s3_access_point_network_origin` - Indicates whether this access point allows access from the public Internet. Values are VPC (the access point doesn't allow access from the public Internet) and Internet (the access point allows access from the public Internet, subject to the access point and bucket access policies).
- `s3_access_point_alias` - The alias of the S3 Access Point.
- `s3_access_point_endpoints` - The VPC endpoints for the S3 Access Point.
- `s3_bucket_analytics_configuration_id` - The ID of s3 bucket analytics configuration
- `s3_bucket_ownership_controls_id` - The ID of s3 bucket ownership controls
- `s3_bucket_request_payment_configuration_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_versioning_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_accelerate_configuration_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_cors_configuration_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_intelligent_tiering_configuration_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_object_lock_configuration_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_logging_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_acl_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_replication_configuration_id` - The S3 source bucket name.
- `s3_bucket_website_configuration_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.
- `s3_bucket_website_configuration_website_domain` - The domain of the website endpoint. This is used to create Route 53 alias records.
- `s3_bucket_website_configuration_website_endpoint` - The website endpoint.
- `s3_bucket_lifecycle_configuration_id` - The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
