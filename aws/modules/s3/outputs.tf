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
# S3 bucket object
#---------------------------------
output "s3_bucket_object_id" {
    description = "The key of the resource supplied above"
    value       = element(concat(aws_s3_bucket_object.s3_bucket_object.*.id, [""]), 0)
}

output "s3_bucket_object_etag" {
    description = "The ETag generated for the object (an MD5 sum of the object content). For plaintext objects or objects encrypted with an AWS-managed key, the hash is an MD5 digest of the object data. For objects encrypted with a KMS key or objects created by either the Multipart Upload or Part Copy operation, the hash is not an MD5 digest, regardless of the method of encryption."
    value       = element(concat(aws_s3_bucket_object.s3_bucket_object.*.etag, [""]), 0)
}

output "s3_bucket_object_version_id" {
    description = "A unique version ID value for the object, if bucket versioning is enabled."
    value       = element(concat(aws_s3_bucket_object.s3_bucket_object.*.version_id, [""]), 0)
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