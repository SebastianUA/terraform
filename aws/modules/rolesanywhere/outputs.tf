#---------------------------------------------------
# AWS rolesanywhere profile
#---------------------------------------------------
output "rolesanywhere_profile_id" {
  description = "The Profile ID."
  value       = element(concat(aws_rolesanywhere_profile.rolesanywhere_profile.*.id, [""]), 0)
}

output "rolesanywhere_profile_arn" {
  description = "Amazon Resource Name (ARN) of the Profile"
  value       = element(concat(aws_rolesanywhere_profile.rolesanywhere_profile.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS rolesanywhere trust anchor
#---------------------------------------------------
output "rolesanywhere_trust_anchor_id" {
  description = "The Trust Anchor ID."
  value       = element(concat(aws_rolesanywhere_trust_anchor.rolesanywhere_trust_anchor.*.id, [""]), 0)
}

output "rolesanywhere_trust_anchor_arn" {
  description = "Amazon Resource Name (ARN) of the Trust Anchor"
  value       = element(concat(aws_rolesanywhere_trust_anchor.rolesanywhere_trust_anchor.*.arn, [""]), 0)
}
