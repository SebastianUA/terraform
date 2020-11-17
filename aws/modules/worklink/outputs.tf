#---------------------------------------------------
# AWS worklink fleet
#---------------------------------------------------
output "worklink_fleet_id" {
  description = "The ARN of the created WorkLink Fleet."
  value       = element(concat(aws_worklink_fleet.worklink_fleet.*.id, [""]), 0)
}

output "worklink_fleet_arn" {
  description = "The ARN of the created WorkLink Fleet."
  value       = element(concat(aws_worklink_fleet.worklink_fleet.*.arn, [""]), 0)
}

output "worklink_fleet_company_code" {
  description = "The identifier used by users to sign in to the Amazon WorkLink app."
  value       = element(concat(aws_worklink_fleet.worklink_fleet.*.company_code, [""]), 0)
}

output "worklink_fleet_created_time" {
  description = "The time that the fleet was created."
  value       = element(concat(aws_worklink_fleet.worklink_fleet.*.created_time, [""]), 0)
}

output "worklink_fleet_last_updated_time" {
  description = "The time that the fleet was last updated."
  value       = element(concat(aws_worklink_fleet.worklink_fleet.*.last_updated_time, [""]), 0)
}

#---------------------------------------------------
# AWS worklink website certificate authority association
#---------------------------------------------------
output "worklink_website_certificate_authority_association_id" {
  description = "The ID of worklink website certificate authority association"
  value       = element(concat(aws_worklink_website_certificate_authority_association.worklink_website_certificate_authority_association.*.id, [""]), 0)
}

output "worklink_website_certificate_authority_association_website_ca_id" {
  description = "A unique identifier for the Certificate Authority."
  value       = element(concat(aws_worklink_website_certificate_authority_association.worklink_website_certificate_authority_association.*.website_ca_id, [""]), 0)
}
