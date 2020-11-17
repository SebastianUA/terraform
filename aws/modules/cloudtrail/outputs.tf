#---------------------------------------------------
# AWS cloudtrail
#---------------------------------------------------
output "cloudtrail_id" {
  description = "The name of the trail."
  value       = element(concat(aws_cloudtrail.cloudtrail.*.id, [""], ), 0)
}

output "cloudtrail_arn" {
  description = "The region in which the trail was created."
  value       = element(concat(aws_cloudtrail.cloudtrail.*.arn, [""], ), 0)
}

output "cloudtrail_home_region" {
  description = "The region in which the trail was created."
  value       = element(concat(aws_cloudtrail.cloudtrail.*.home_region, [""], ), 0)
}
