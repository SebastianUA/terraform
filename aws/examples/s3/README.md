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
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3_private_bucket" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket1"
  s3_bucket_acl    = "private"

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

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket2"
  s3_bucket_acl    = "private"

  s3_bucket_grant = []
  s3_bucket_website = {
    index_document = "index.tml"
    error_document = "error.tml"
    routing_rules = jsonencode([{
      Condition : {
        KeyPrefixEquals : "docs/"
      },
      Redirect : {
        ReplaceKeyPrefixWith : "documents/"
      }
    }])

  }

  s3_bucket_cors_rule = [
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

  s3_bucket_versioning = {
    enabled = true
  }

  s3_bucket_logging = {
    target_bucket = module.s3_private_bucket.s3_bucket_arn
    target_prefix = "log/"
  }

  s3_bucket_lifecycle_rule = [
    {
      enabled = true

      id     = "log"
      prefix = "log/"
      tags   = tomap({ "rule" = "log", "autoclean" = "true" })

      expiration = {
        days = 90
      }

      transition = [
        {
          days          = 30
          storage_class = "ONEZONE_IA"
        },
        {
          days          = 60
          storage_class = "GLACIER"
        }
      ]

      noncurrent_version_expiration = {
        days = 30
      }
    },
    {
      enabled = true

      id                                     = "log1"
      prefix                                 = "log1/"
      abort_incomplete_multipart_upload_days = 7

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
        },
      ]

      noncurrent_version_expiration = {
        days = 365
      }
    }
  ]

  s3_bucket_server_side_encryption_configuration = {
    //rule = {
    //  sse_algorithm     = "aws:kms"

    //  kms_master_key_id = module.kms_key.kms_key_arn
    //}
  }

  s3_bucket_object_lock_configuration = {
    //object_lock_enabled = "Enabled"
    //rule = {
    //  default_retention = {
    //    mode = "GOVERNANCE"
    //    days = 1
    //  }
    //}
  }


  # Add files to bucket
  enable_s3_bucket_object = true
  s3_bucket_object_stack = [
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
  s3_bucket_acl    = "private"

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
}```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_s3_bucket` - Enable to create S3 bucket by default (`default = False`)
- `s3_bucket_name` - Name for bucket name. Conflicts with s3_bucket_prefix. (`default = null`)
- `s3_bucket_prefix` - Creates a unique bucket name beginning with the specified prefix. Conflicts with s3_bucket_name. (`default = null`)
- `s3_bucket_acl` - The canned ACL to apply. Defaults to 'private'. (`default = null`)
- `s3_bucket_policy` - (Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. (`default = null`)
- `s3_bucket_force_destroy` - (Optional) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. (`default = null`)
- `s3_bucket_acceleration_status` - (Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended. (`default = null`)
- `s3_bucket_request_payer` - (Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information. (`default = null`)
- `s3_bucket_grant` - (Optional) An ACL policy grant (documented below). Conflicts with acl (`default = []`)
- `s3_bucket_website` - (Optional) A website object  (`default = {}`)
- `s3_bucket_cors_rule` - Cors rules (`default = []`)
- `s3_bucket_versioning` - (Optional) A state of versioning (`default = {}`)
- `s3_bucket_logging` - (Optional) A settings of bucket logging (`default = {}`)
- `s3_bucket_lifecycle_rule` - (Optional) A configuration of object lifecycle management (`default = []`)
- `s3_bucket_replication_configuration` - (Optional) A configuration of replication configuration (`default = {}`)
- `s3_bucket_object_lock_configuration` - (Optional) A configuration of S3 object locking (`default = {}`)
- `s3_bucket_server_side_encryption_configuration` - (Optional) A configuration of server-side encryption configuration (`default = {}`)
- `enable_s3_bucket_policy` - Enable s3 bucket policy usage (`default = False`)
- `s3_bucket_policy_bucket` - The name of the bucket to which to apply the policy. (`default = ""`)
- `s3_bucket_policy_policy` - (Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. (`default = ""`)
- `enable_s3_bucket_object` - Enable s3 bucket object (`default = False`)
- `s3_bucket_object_stack` - Set properties for s3 bucket object (`default = []`)
- `enable_s3_bucket_notification` - Enable s3 bucket notification usage (`default = False`)
- `s3_bucket_notification_bucket` - The name of the bucket to put notification configuration. (`default = ""`)
- `s3_bucket_notification_topic` - (Optional) The notification configuration to SNS Topic (`default = []`)
- `s3_bucket_notification_queue` - (Optional) The notification configuration to SQS Queue (`default = []`)
- `s3_bucket_notification_lambda_function` - (Optional, Multiple) Used to configure notifications to a Lambda Function (`default = []`)
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
- `s3_access_point_public_access_block_configuration` - (Optional) Configuration block to manage the PublicAccessBlock configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination. (`default = []`)
- `s3_access_point_vpc_configuration` - (Optional) Configuration block to restrict access to this access point to requests from the specified Virtual Private Cloud (VPC). Required for S3 on Outposts. (`default = []`)
- `enable_s3_bucket_analytics_configuration` - Enable s3 bucket analytics configuration usage (`default = False`)
- `s3_bucket_analytics_configuration_bucket` - The name of the bucket this analytics configuration is associated with. (`default = ""`)
- `s3_bucket_analytics_configuration_name` - Unique identifier of the analytics configuration for the bucket. (`default = ""`)
- `s3_bucket_analytics_configuration_filter` - (Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags (`default = []`)
- `s3_bucket_analytics_configuration_storage_class_analysis` - (Optional) Configuration for the analytics data export (`default = []`)
- `enable_s3_bucket_ownership_controls` - Enable s3 bucket ownership controls usage (`default = False`)
- `s3_bucket_ownership_controls_bucket` - The name of the bucket that you want to associate this access point with. (`default = ""`)
- `s3_bucket_ownership_controls_rule` - (Required) Configuration block(s) with Ownership Controls rules. (`default = []`)
- `AAAA` - AAAA (`default = null`)

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
- `s3_bucket_object_id` - The key of the resource supplied above
- `s3_bucket_object_etag` - The ETag generated for the object (an MD5 sum of the object content). For plaintext objects or objects encrypted with an AWS-managed key, the hash is an MD5 digest of the object data. For objects encrypted with a KMS key or objects created by either the Multipart Upload or Part Copy operation, the hash is not an MD5 digest, regardless of the method of encryption.
- `s3_bucket_object_version_id` - A unique version ID value for the object, if bucket versioning is enabled.
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
- `s3_bucket_analytics_configuration_id` - The ID of s3 bucket analytics configuration
- `s3_bucket_ownership_controls_id` - The ID of s3 bucket ownership controls


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
