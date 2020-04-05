#---------------------------------------------------
# CodeCommit
#---------------------------------------------------
output "aws_codecommit_repository_name" {
  description = "The name of the repository"
  value       = module.codecommit.codecommit_repository_name
}

output "aws_codecommit_repository_clone_url_http" {
  description = "The URL to use for cloning the repository over HTTPS."
  value       = module.codecommit.codecommit_repository_clone_url_http
}

output "aws_codecommit_repository_clone_url_ssh" {
  description = "The URL to use for cloning the repository over SSH."
  value       = module.codecommit.codecommit_repository_clone_url_ssh
}

#---------------------------------------------------
# CodeBuild
#---------------------------------------------------
output "aws_codebuild_project_badge_url" {
  description = "The URL of the build badge when badge_enabled is enabled."
  value       = module.codebuild.codebuild_project_badge_url
}

output "aws_codebuild_webhook_payload_url" {
  description = "The CodeBuild endpoint where webhook events are sent."
  value       = module.codebuild.codebuild_webhook_payload_url
}

output "aws_codebuild_webhook_secret" {
  description = "The secret token of the associated repository. Not returned by the CodeBuild API for all source types."
  value       = module.codebuild.codebuild_webhook_secret
}
