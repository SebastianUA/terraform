output "bucket_id" {
    description = "bucket_id"
    value       = "${aws_s3_bucket.s3_bucket.id}"
}

output "bucket_name" {
    description = "bucket_id"
    value       = "${lower(var.name)}-s3-${lower(var.environment)}"
}

//the arn of the bucket that was created
output "bucket_arn" {
    value = "${aws_s3_bucket.s3_bucket.arn}"
}

output "bucket_domain_name" {
    value = "${aws_s3_bucket.s3_bucket.bucket_domain_name}"
}
