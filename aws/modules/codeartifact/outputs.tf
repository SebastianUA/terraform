#---------------------------------------------------
# AWS CodeArtifact domain
#---------------------------------------------------
output "codeartifact_domain_id" {
  description = "The Name of Domain."
  value       = element(concat(aws_codeartifact_domain.codeartifact_domain.*.id, [""]), 0)
}

output "codeartifact_domain_arn" {
  description = "The ARN of Domain."
  value       = element(concat(aws_codeartifact_domain.codeartifact_domain.*.arn, [""]), 0)
}

output "codeartifact_domain_domain" {
  description = "The ARN of Domain."
  value       = element(concat(aws_codeartifact_domain.codeartifact_domain.*.domain, [""]), 0)
}

output "codeartifact_domain_owner" {
  description = "The AWS account ID that owns the domain."
  value       = element(concat(aws_codeartifact_domain.codeartifact_domain.*.owner, [""]), 0)
}

output "codeartifact_domain_created_time" {
  description = "A timestamp that represents the date and time the domain was created in RFC3339 format."
  value       = element(concat(aws_codeartifact_domain.codeartifact_domain.*.created_time, [""]), 0)
}

output "codeartifact_domain_repository_count" {
  description = "The number of repositories in the domain."
  value       = element(concat(aws_codeartifact_domain.codeartifact_domain.*.repository_count, [""]), 0)
}

output "codeartifact_domain_asset_size_bytes" {
  description = "The total size of all assets in the domain."
  value       = element(concat(aws_codeartifact_domain.codeartifact_domain.*.asset_size_bytes, [""]), 0)
}

#---------------------------------------------------
# AWS CodeArtifact domain permissions policy
#---------------------------------------------------
output "codeartifact_domain_permissions_policy_id" {
  description = "The Name of Domain."
  value       = element(concat(aws_codeartifact_domain_permissions_policy.codeartifact_domain_permissions_policy.*.id, [""]), 0)
}

output "_resource_arn" {
  description = "The ARN of the resource associated with the resource policy."
  value       = element(concat(aws_codeartifact_domain_permissions_policy.codeartifact_domain_permissions_policy.*.resource_arn, [""]), 0)
}

#---------------------------------------------------
# AWS CodeArtifact repository
#---------------------------------------------------
output "codeartifact_repository_id" {
  description = "The Name of the repository."
  value       = element(concat(aws_codeartifact_repository.codeartifact_repository.*.id, [""]), 0)
}

output "codeartifact_repository_arn" {
  description = "The ARN of the repository."
  value       = element(concat(aws_codeartifact_repository.codeartifact_repository.*.arn, [""]), 0)
}

output "codeartifact_repository_administrator_account" {
  description = "The account number of the AWS account that manages the repository."
  value       = element(concat(aws_codeartifact_repository.codeartifact_repository.*.administrator_account, [""]), 0)
}

#---------------------------------------------------
# AWS CodeArtifact repository permissions policy
#---------------------------------------------------
output "codeartifact_repository_permissions_policy_id" {
  description = "The ARN of the resource associated with the resource policy."
  value       = element(concat(aws_codeartifact_repository_permissions_policy.codeartifact_repository_permissions_policy.*.id, [""]), 0)
}

output "codeartifact_repository_permissions_resource_policy_arn" {
  description = "The ARN of the resource associated with the resource policy."
  value       = element(concat(aws_codeartifact_repository_permissions_policy.codeartifact_repository_permissions_policy.*.resource_arn, [""]), 0)
}