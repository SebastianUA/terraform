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
