#---------------------------------------------------
# ECR repo
#---------------------------------------------------
output "ecr_repository_arn" {
    description = "Full ARN of the repository."
    value       = "${module.ecr.aws_ecr_repository_arn}"
}

output "ecr_repository_name" {
    description = "The name of the repository."
    value       = "${module.ecr.aws_ecr_repository_name}"
}

output "ecr_repository_registry_id" {
    description = "The registry ID where the repository was created."
    value       = "${module.ecr.aws_ecr_repository_registry_id}"
}
 
output "ecr_repository_url" {
    description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName"
    value       = "${module.ecr.aws_ecr_repository_url}"
}
#---------------------------------------------------
#
#---------------------------------------------------
