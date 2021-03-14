#---------------------------------------------------
# AWS Codebuild project
#---------------------------------------------------
output "codebuild_project_id" {
  description = "The name (if imported via name) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project."
  value       = element(concat(aws_codebuild_project.codebuild_project.*.id, [""]), 0)
}

output "codebuild_project_arn" {
  description = "The ARN of the CodeBuild project."
  value       = element(concat(aws_codebuild_project.codebuild_project.*.arn, [""]), 0)
}

output "codebuild_project_badge_url" {
  description = "The URL of the build badge when badge_enabled is enabled."
  value       = element(concat(aws_codebuild_project.codebuild_project.*.badge_url, [""]), 0)
}

#---------------------------------------------------
# AWS Codebuild source credential
#---------------------------------------------------
output "codebuild_source_credential_id" {
  description = "The ARN of Source Credential."
  value       = element(concat(aws_codebuild_source_credential.codebuild_source_credential.*.id, [""]), 0)
}

output "codebuild_source_credential_arn" {
  description = "The ARN of Source Credential."
  value       = element(concat(aws_codebuild_source_credential.codebuild_source_credential.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Codebuild webhook
#---------------------------------------------------
output "codebuild_webhook_id" {
  description = "The name of the build project."
  value       = element(concat(aws_codebuild_webhook.codebuild_webhook.*.id, [""]), 0)
}

output "codebuild_webhook_payload_url" {
  description = "The CodeBuild endpoint where webhook events are sent."
  value       = element(concat(aws_codebuild_webhook.codebuild_webhook.*.payload_url, [""]), 0)
}

output "codebuild_webhook_secret" {
  description = "The secret token of the associated repository. Not returned by the CodeBuild API for all source types."
  value       = element(concat(aws_codebuild_webhook.codebuild_webhook.*.secret, [""]), 0)
}

output "codebuild_webhook_url" {
  description = "The URL to the webhook."
  value       = element(concat(aws_codebuild_webhook.codebuild_webhook.*.url, [""]), 0)
}

#---------------------------------------------------
# AWS Codebuild report group
#---------------------------------------------------
output "codebuild_report_group_id" {
  description = "The ARN of Report Group."
  value       = element(concat(aws_codebuild_report_group.codebuild_report_group.*.id, [""]), 0)
}

output "codebuild_report_group_arn" {
  description = "The ARN of Report Group."
  value       = element(concat(aws_codebuild_report_group.codebuild_report_group.*.arn, [""]), 0)
}

output "codebuild_report_group_created" {
  description = "The date and time this Report Group was created."
  value       = element(concat(aws_codebuild_report_group.codebuild_report_group.*.created, [""]), 0)
}
