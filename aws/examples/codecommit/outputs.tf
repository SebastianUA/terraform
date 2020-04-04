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
