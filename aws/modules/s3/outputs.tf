#---------------------------------
# S3 bucket
#---------------------------------
output "s3_bucket_default_id" {
    description = "bucket_id"
    value       = "${element(concat(aws_s3_bucket.s3_bucket_default.*.id, list("")), 0)}"
}

output "s3_bucket_default_name" {
    description = "bucket_id"
    value       = "${element(concat(aws_s3_bucket.s3_bucket_default.*.id, list("")), 0)}"
    #value       = "${lower(var.name)}-s3-${lower(var.environment)}"
}

//the arn of the bucket that was created
#output "bucket_arn" {
#    value = "${aws_s3_bucket.s3_bucket.arn}"
#}
#
#output "bucket_domain_name" {
#    value = "${aws_s3_bucket.s3_bucket.bucket_domain_name}"
#}

#---------------------------------
# S3 bucket object
#---------------------------------
output "s3_bucket_object_ids" {
    description = " the key of the resource supplied above"
    value       = "${aws_s3_bucket_object.s3_bucket_object.*.id}"
}

output "s3_bucket_object_etag" {
    description = "the ETag generated for the object (an MD5 sum of the object content). For plaintext objects or objects encrypted with an AWS-managed key, the hash is an MD5 digest of the object data. For objects encrypted with a KMS key or objects created by either the Multipart Upload or Part Copy operation, the hash is not an MD5 digest, regardless of the method of encryption."
    value       = "${element(concat(aws_s3_bucket_object.s3_bucket_object.*.etag, list("")), 0)}"
}

output "s3_bucket_object_version_id" {
    description = "A unique version ID value for the object, if bucket versioning is enabled."
    value       = "${element(concat(aws_s3_bucket_object.s3_bucket_object.*.version_id, list("")), 0)}"
}

#---------------------------------
# S3 bucket notification
#---------------------------------
output "s3_bucket_notification_sns_id" {
    description = ""
    value       = "${element(concat(aws_s3_bucket_notification.s3_bucket_notification_sns.*.id, list("")), 0)}"
}

output "s3_bucket_notification_sqs_id" {
    description = ""
    value       = "${element(concat(aws_s3_bucket_notification.s3_bucket_notification_sqs.*.id, list("")), 0)}"
}

output "s3_bucket_notification_lambda_function_id" {
    description = ""
    value       = "${element(concat(aws_s3_bucket_notification.s3_bucket_notification_lambda_function.*.id, list("")), 0)}"
}

