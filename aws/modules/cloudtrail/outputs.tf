output "cloudtrail_id" {
    description = "The name of the trail."
    value       = "${aws_cloudtrail.cloudtrail.id}"
}

output "cloudtrail_home_region" {
    description = "The region in which the trail was created."
    value       = "${aws_cloudtrail.cloudtrail.home_region}"
}

output "cloudtrail_arn" {
    description = "The region in which the trail was created."
    value       = "${aws_cloudtrail.cloudtrail.arn}"
}