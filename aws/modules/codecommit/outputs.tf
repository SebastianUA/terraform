#---------------------------------------------------
# AWS Codecommit repository
#---------------------------------------------------
output "codecommit_repository_id" {
  description = "The ID of the repository"
  value       = element(concat(aws_codecommit_repository.codecommit_repository.*.repository_id, [""]), 0)
}

output "codecommit_repository_name" {
  description = "The name of the repository"
  value       = element(concat(aws_codecommit_repository.codecommit_repository.*.repository_name, [""]), 0)
}

output "codecommit_repository_arn" {
  description = "The ARN of the repository"
  value       = element(concat(aws_codecommit_repository.codecommit_repository.*.arn, [""]), 0)
}

output "codecommit_repository_clone_url_http" {
  description = "The URL to use for cloning the repository over HTTPS."
  value       = element(concat(aws_codecommit_repository.codecommit_repository.*.clone_url_http, [""]), 0)
}

output "codecommit_repository_clone_url_ssh" {
  description = "The URL to use for cloning the repository over SSH."
  value       = element(concat(aws_codecommit_repository.codecommit_repository.*.clone_url_ssh, [""]), 0)
}

output "codecommit_repository_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_codecommit_repository.codecommit_repository.*.tags_all, [""])
}

#---------------------------------------------------
# AWS Codecommit approval rule template
#---------------------------------------------------
output "codecommit_approval_rule_template_approval_rule_template_id" {
  description = "The ID of the approval rule template"
  value       = concat(aws_codecommit_approval_rule_template.codecommit_approval_rule_template.*.approval_rule_template_id, [""])
}

output "codecommit_approval_rule_template_creation_date" {
  description = "The date the approval rule template was created, in RFC3339 format."
  value       = concat(aws_codecommit_approval_rule_template.codecommit_approval_rule_template.*.creation_date, [""])
}

output "codecommit_approval_rule_template_last_modified_date" {
  description = "The date the approval rule template was most recently changed, in RFC3339 format."
  value       = concat(aws_codecommit_approval_rule_template.codecommit_approval_rule_template.*.last_modified_date, [""])
}

output "codecommit_approval_rule_template_last_modified_user" {
  description = "The Amazon Resource Name (ARN) of the user who made the most recent changes to the approval rule template."
  value       = concat(aws_codecommit_approval_rule_template.codecommit_approval_rule_template.*.last_modified_user, [""])
}

output "codecommit_approval_rule_template_rule_content_sha256" {
  description = "The SHA-256 hash signature for the content of the approval rule template."
  value       = concat(aws_codecommit_approval_rule_template.codecommit_approval_rule_template.*.rule_content_sha256, [""])
}

#---------------------------------------------------
# AWS Codecommit approval rule template association
#---------------------------------------------------
output "codecommit_approval_rule_template_association_id" {
  description = "The name of the approval rule template and name of the repository, separated by a comma (,)."
  value       = concat(aws_codecommit_approval_rule_template_association.codecommit_approval_rule_template_association.*.id, [""])
}
