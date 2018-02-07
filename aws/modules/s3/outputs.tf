output "bucket_ids" {
    description = "bucket_id"
    value       = "${aws_s3_bucket.s3_bucket.*.id}"
}
//the arn of the bucket that was created
output "bucket_arns" {
    value = "${aws_s3_bucket.s3_bucket.*.arn}"
}

