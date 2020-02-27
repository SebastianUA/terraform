#---------------------------------------------------
# AWS cloudfront distribution
#---------------------------------------------------
output "cloudfront_distribution_id" {
	description = "The identifier for the distribution. For example: EDFDVBD632BHDS5."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.id, [""]), 0)
}

output "cloudfront_distribution_arn" {
	description = "The ARN (Amazon Resource Name) for the distribution. For example: arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5, where 123456789012 is your AWS account ID."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.arn, [""]), 0)
}

output "cloudfront_distribution_caller_reference" {
	description = "Internal value used by CloudFront to allow future updates to the distribution configuration."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.caller_reference, [""]), 0)
}

output "cloudfront_distribution_status" {
	description = "The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.status, [""]), 0)
}

output "cloudfront_distribution_active_trusted_signers" {
	description = "The key pair IDs that CloudFront is aware of for each trusted signer, if the distribution is set up to serve private content with signed URLs."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.active_trusted_signers, [""]), 0)
}

output "cloudfront_distribution_domain_name" {
	description = "The domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.domain_name, [""]), 0)
}

output "cloudfront_distribution_last_modified_time" {
	description = "The date and time the distribution was last modified."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.last_modified_time, [""]), 0)
}

output "cloudfront_distribution_in_progress_validation_batches" {
	description = "The number of invalidation batches currently in progress."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.in_progress_validation_batches, [""]), 0)
}

output "cloudfront_distribution_etag" {
	description = "The current version of the distribution's information. For example: E2QWRUHAPOMQZL."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.etag, [""]), 0)
}

output "cloudfront_distribution_hosted_zone_id" {
	description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2."
    value       = element(concat(aws_cloudfront_distribution.cloudfront_distribution.*.hosted_zone_id, [""]), 0)
}

#---------------------------------------------------
# AWS cloudfront public key
#---------------------------------------------------
output "cloudfront_public_key_id" {
	description = "The identifier for the public key. For example: K3D5EWEUDCCXON."
    value       = element(concat(aws_cloudfront_public_key.cloudfront_public_key.*.id, [""]), 0)
}

output "cloudfront_public_key_caller_reference" {
	description = "Internal value used by CloudFront to allow future updates to the public key configuration."
    value       = element(concat(aws_cloudfront_public_key.cloudfront_public_key.*.caller_reference, [""]), 0)
}

output "cloudfront_public_key_etag" {
	description = "The current version of the public key. For example: E2QWRUHAPOMQZL."
    value       = element(concat(aws_cloudfront_public_key.cloudfront_public_key.*.etag, [""]), 0)
}

#---------------------------------------------------
# AWS cloudfront origin access identity
#---------------------------------------------------
output "cloudfront_origin_access_identity_id" {
	description = "The identifier for the distribution. For example: EDFDVBD632BHDS5."
    value       = element(concat(aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.*.id, [""]), 0)
}

output "cloudfront_origin_access_identity_caller_reference" {
	description = "Internal value used by CloudFront to allow future updates to the origin access identity."
    value       = element(concat(aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.*.caller_reference, [""]), 0)
}

output "cloudfront_origin_access_identity_cloudfront_access_identity_path" {
	description = "A shortcut to the full path for the origin access identity to use in CloudFront, see below."
    value       = element(concat(aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.*.cloudfront_access_identity_path, [""]), 0)
}

output "cloudfront_origin_access_identity_etag" {
	description = "The current version of the origin access identity's information. For example: E2QWRUHAPOMQZL."
    value       = element(concat(aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.*.etag, [""]), 0)
}

output "cloudfront_origin_access_identity_iam_arn" {
	description = "A pre-generated ARN for use in S3 bucket policies (see below). Example: arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2QWRUHAPOMQZL."
    value       = element(concat(aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.*.iam_arn, [""]), 0)
}

output "cloudfront_origin_access_identity_s3_canonical_user_id" {
	description = "The Amazon S3 canonical user ID for the origin access identity, which you use when giving the origin access identity read permission to an object in Amazon S3."
    value       = element(concat(aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.*.s3_canonical_user_id, [""]), 0)
}
