#---------------------------------------------------
# AWS organizations account
#---------------------------------------------------
output "organizations_account_arn" {
  description = "The ARN for this account."
  value       = element(concat(aws_organizations_account.organizations_account.*.arn, [""]), 0)
}

output "organizations_account_id" {
  description = "The AWS account id"
  value       = element(concat(aws_organizations_account.organizations_account.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS organizations organizational
#---------------------------------------------------
output "organizations_organization_arn" {
  description = "ARN of the organization"
  value       = element(concat(aws_organizations_organization.organizations_organization.*.arn, [""]), 0)
}

output "organizations_organization_id" {
  description = "Identifier of the organization"
  value       = element(concat(aws_organizations_organization.organizations_organization.*.id, [""]), 0)
}

output "organizations_organization_master_account_arn" {
  description = "ARN of the master account"
  value       = element(concat(aws_organizations_organization.organizations_organization.*.master_account_arn, [""]), 0)
}

output "organizations_organization_master_account_id" {
  description = "Identifier of the master account"
  value       = element(concat(aws_organizations_organization.organizations_organization.*.master_account_id, [""]), 0)
}

output "organizations_organization_master_account_email" {
  description = "Email address of the master account"
  value       = element(concat(aws_organizations_organization.organizations_organization.*.master_account_email, [""]), 0)
}

#---------------------------------------------------
# AWS organizations organizational unit
#---------------------------------------------------
output "organizations_organizational_unit_accounts" {
  description = "List of child accounts for this Organizational Unit. Does not return account information for child Organizational Units."
  value       = concat(aws_organizations_organizational_unit.organizations_organizational_unit.*.accounts, [""])
}

output "organizations_organizational_unit_arn" {
  description = "ARN of the organizational unit"
  value       = element(concat(aws_organizations_organizational_unit.organizations_organizational_unit.*.arn, [""]), 0)
}

output "organizations_organizational_unit_id" {
  description = "Identifier of the organization unit"
  value       = element(concat(aws_organizations_organizational_unit.organizations_organizational_unit.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS organizations policy
#---------------------------------------------------
output "organizations_policy_arn" {
  description = "Amazon Resource Name (ARN) of the policy."
  value       = element(concat(aws_organizations_policy.organizations_policy.*.arn, [""]), 0)
}

output "organizations_policy_id" {
  description = "The unique identifier (ID) of the policy."
  value       = element(concat(aws_organizations_policy.organizations_policy.*.id, [""]), 0)
}
