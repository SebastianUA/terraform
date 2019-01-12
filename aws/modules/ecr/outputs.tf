#---------------------------------------------------
# ECR repo
#---------------------------------------------------
output "aws_ecr_repository_arn" {
    description = "Full ARN of the repository."
    value       = "${element(concat(aws_ecr_repository.ecr_repository.*.arn, list("")), 0)}"
}

output "aws_ecr_repository_name" {
    description = "The name of the repository."
    value       = "${element(concat(aws_ecr_repository.ecr_repository.*.name, list("")), 0)}"
}

output "aws_ecr_repository_registry_id" {
    description = "The registry ID where the repository was created."
    value       = "${element(concat(aws_ecr_repository.ecr_repository.*.registry_id, list("")), 0)}"
}

output "aws_ecr_repository_url" {
    description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName"
    value       = "${element(concat(aws_ecr_repository.ecr_repository.*.repository_url, list("")), 0)}"
}
