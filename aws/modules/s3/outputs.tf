#---------------------------------
# S3 bucket
#---------------------------------
output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = element(concat(aws_s3_bucket.s3_bucket.*.arn, [""]), 0)
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = element(concat(aws_s3_bucket.s3_bucket.*.bucket_domain_name, [""]), 0)
}

output "s3_bucket_bucket_bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
  value       = element(concat(aws_s3_bucket.s3_bucket.*.bucket_regional_domain_name, [""]), 0)
}

output "s3_bucket_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  value       = element(concat(aws_s3_bucket.s3_bucket.*.hosted_zone_id, [""]), 0)
}

output "s3_bucket_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = element(concat(aws_s3_bucket.s3_bucket.*.region, [""]), 0)
}

output "s3_bucket_bucket_website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string."
  value       = element(concat(aws_s3_bucket.s3_bucket.*.website_endpoint, [""]), 0)
}

output "s3_bucket_bucket_website_domain" {
  description = "The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records."
  value       = element(concat(aws_s3_bucket.s3_bucket.*.website_domain, [""]), 0)
}

#---------------------------------
# S3 object
#---------------------------------
output "s3_object_id" {
  description = "The key of the resource supplied above"
  value       = element(concat(aws_s3_object.s3_object.*.id, [""]), 0)
}

output "s3_object_etag" {
  description = "The ETag generated for the object (an MD5 sum of the object content). For plaintext objects or objects encrypted with an AWS-managed key, the hash is an MD5 digest of the object data. For objects encrypted with a KMS key or objects created by either the Multipart Upload or Part Copy operation, the hash is not an MD5 digest, regardless of the method of encryption."
  value       = element(concat(aws_s3_object.s3_object.*.etag, [""]), 0)
}

output "s3_object_version_id" {
  description = "A unique version ID value for the object, if bucket versioning is enabled."
  value       = element(concat(aws_s3_object.s3_object.*.version_id, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket object copy
#---------------------------------------------------
output "s3_object_copy_id" {
  description = "The key of the resource supplied above."
  value       = element(concat(aws_s3_object_copy.s3_object_copy.*.id, [""]), 0)
}

output "s3_object_copy_etag" {
  description = "The ETag generated for the object (an MD5 sum of the object content). For plaintext objects or objects encrypted with an AWS-managed key, the hash is an MD5 digest of the object data. For objects encrypted with a KMS key or objects created by either the Multipart Upload or Part Copy operation, the hash is not an MD5 digest, regardless of the method of encryption. More information on possible values can be found on Common Response Headers."
  value       = element(concat(aws_s3_object_copy.s3_object_copy.*.etag, [""]), 0)
}

output "s3_object_copy_version_id" {
  description = "Version ID of the newly created copy."
  value       = element(concat(aws_s3_object_copy.s3_object_copy.*.version_id, [""]), 0)
}

output "s3_object_copy_expiration" {
  description = "If the object expiration is configured, this attribute will be set."
  value       = element(concat(aws_s3_object_copy.s3_object_copy.*.expiration, [""]), 0)
}

output "s3_object_copy_last_modified" {
  description = "Returns the date that the object was last modified, in RFC3339 format."
  value       = element(concat(aws_s3_object_copy.s3_object_copy.*.last_modified, [""]), 0)
}

output "s3_object_copy_request_charged" {
  description = "If present, indicates that the requester was successfully charged for the request."
  value       = element(concat(aws_s3_object_copy.s3_object_copy.*.request_charged, [""]), 0)
}

output "s3_object_copy_source_version_id" {
  description = "Version of the copied object in the source bucket."
  value       = element(concat(aws_s3_object_copy.s3_object_copy.*.source_version_id, [""]), 0)
}

output "s3_object_copy_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value       = concat(aws_s3_object_copy.s3_object_copy.*.version_id, [""])
}

#---------------------------------
# S3 bucket policy
#---------------------------------
output "s3_bucket_policy_id" {
  description = "ID of S3 bucket policy"
  value       = element(concat(aws_s3_bucket_policy.s3_bucket_policy.*.id, [""]), 0)
}

#---------------------------------
# S3 bucket notification
#---------------------------------
output "s3_bucket_notification_id" {
  description = "ID of S3 bucket notification"
  value       = element(concat(aws_s3_bucket_notification.s3_bucket_notification.*.id, [""]), 0)
}

#---------------------------------
# S3 bucket metric
#---------------------------------
output "s3_bucket_metric_id" {
  description = "ID of S3 bucket metric"
  value       = element(concat(aws_s3_bucket_metric.s3_bucket_metric.*.id, [""]), 0)
}

#-----------------------------------------------------------
# S3 bucket inventory
#-----------------------------------------------------------
output "s3_bucket_inventory_id" {
  description = "ID of S3 bucket inventory"
  value       = element(concat(aws_s3_bucket_inventory.s3_bucket_inventory.*.id, [""]), 0)
}

#---------------------------------------------------
# S3 bucket public access block
#---------------------------------------------------
output "s3_bucket_public_access_block_id" {
  description = "Name of the S3 bucket the configuration is attached to"
  value       = element(concat(aws_s3_bucket_public_access_block.s3_bucket_public_access_block.*.id, [""]), 0)
}

#---------------------------------------------------
# S3 account public access block
#---------------------------------------------------
output "s3_account_public_access_block_id" {
  description = "Name of the S3 bucket the configuration is attached to"
  value       = element(concat(aws_s3_account_public_access_block.s3_account_public_access_block.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS S3 access point
#---------------------------------------------------
output "s3_access_point_id" {
  description = "For Access Point of an AWS Partition S3 Bucket, the AWS account ID and access point name separated by a colon (:). For S3 on Outposts Bucket, the Amazon Resource Name (ARN) of the Access Point."
  value       = element(concat(aws_s3_access_point.s3_access_point.*.id, [""]), 0)
}

output "s3_access_point_arn" {
  description = "Amazon Resource Name (ARN) of the S3 Access Point."
  value       = element(concat(aws_s3_access_point.s3_access_point.*.arn, [""]), 0)
}

output "s3_access_point_domain_name" {
  description = "The DNS domain name of the S3 Access Point in the format name-account_id.s3-accesspoint.region.amazonaws.com. Note: S3 access points only support secure access by HTTPS. HTTP isn't supported."
  value       = element(concat(aws_s3_access_point.s3_access_point.*.domain_name, [""]), 0)
}

output "s3_access_point_has_public_access_policy" {
  description = "Indicates whether this access point currently has a policy that allows public access."
  value       = element(concat(aws_s3_access_point.s3_access_point.*.has_public_access_policy, [""]), 0)
}

output "s3_access_point_network_origin" {
  description = "Indicates whether this access point allows access from the public Internet. Values are VPC (the access point doesn't allow access from the public Internet) and Internet (the access point allows access from the public Internet, subject to the access point and bucket access policies)."
  value       = element(concat(aws_s3_access_point.s3_access_point.*.network_origin, [""]), 0)
}

output "s3_access_point_alias" {
  description = "The alias of the S3 Access Point."
  value       = element(concat(aws_s3_access_point.s3_access_point.*.alias, [""]), 0)
}

output "s3_access_point_endpoints" {
  description = "The VPC endpoints for the S3 Access Point."
  value       = element(concat(aws_s3_access_point.s3_access_point.*.endpoints, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket analytics configuration
#---------------------------------------------------
output "s3_bucket_analytics_configuration_id" {
  description = "The ID of s3 bucket analytics configuration"
  value       = element(concat(aws_s3_bucket_analytics_configuration.s3_bucket_analytics_configuration.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket ownership controls
#---------------------------------------------------
output "s3_bucket_ownership_controls_id" {
  description = "The ID of s3 bucket ownership controls"
  value       = element(concat(aws_s3_bucket_ownership_controls.s3_bucket_ownership_controls.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket request payment configuration
#---------------------------------------------------
output "s3_bucket_request_payment_configuration_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_request_payment_configuration.s3_bucket_request_payment_configuration.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket versioning
#---------------------------------------------------
output "s3_bucket_versioning_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_versioning.s3_bucket_versioning.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket accelerate configuration
#---------------------------------------------------
output "s3_bucket_accelerate_configuration_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_accelerate_configuration.s3_bucket_accelerate_configuration.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket cors configuration
#---------------------------------------------------
output "s3_bucket_cors_configuration_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_cors_configuration.s3_bucket_cors_configuration.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket intelligent tiering configuration
#---------------------------------------------------
output "s3_bucket_intelligent_tiering_configuration_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_intelligent_tiering_configuration.s3_bucket_intelligent_tiering_configuration.*.id, [""]), 0)
}

#---------------------------------------------------
# S3 bucket object lock configuration
#---------------------------------------------------
output "s3_bucket_object_lock_configuration_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_object_lock_configuration.s3_bucket_object_lock_configuration.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket logging
#---------------------------------------------------
output "s3_bucket_logging_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_logging.s3_bucket_logging.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS S3 bucket acl
#---------------------------------------------------
output "s3_bucket_acl_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_acl.s3_bucket_acl.*.id, [""]), 0)
}

#---------------------------------------------------
# S3 bucket replication configuration
#---------------------------------------------------
output "s3_bucket_replication_configuration_id" {
  description = "The S3 source bucket name."
  value       = element(concat(aws_s3_bucket_replication_configuration.s3_bucket_replication_configuration.*.id, [""]), 0)
}

#---------------------------------------------------
# S3 bucket website configuration
#---------------------------------------------------
output "s3_bucket_website_configuration_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_website_configuration.s3_bucket_website_configuration.*.id, [""]), 0)
}

output "s3_bucket_website_configuration_website_domain" {
  description = "The domain of the website endpoint. This is used to create Route 53 alias records."
  value       = element(concat(aws_s3_bucket_website_configuration.s3_bucket_website_configuration.*.website_domain, [""]), 0)
}

output "s3_bucket_website_configuration_website_endpoint" {
  description = "The website endpoint."
  value       = element(concat(aws_s3_bucket_website_configuration.s3_bucket_website_configuration.*.website_endpoint, [""]), 0)
}

#---------------------------------------------------
# S3 bucket lifecycle configuration
#---------------------------------------------------
output "s3_bucket_lifecycle_configuration_id" {
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
  value       = element(concat(aws_s3_bucket_lifecycle_configuration.s3_bucket_lifecycle_configuration.*.id, [""]), 0)
}
