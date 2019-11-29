#---------------------------------------------------
# Create AWS ECR repository policy
#---------------------------------------------------
resource "aws_ecr_repository_policy" "ecr_repository_policy" {
    count       = var.enable_ecr_repository_policy ? 1 : 0
                
    repository  = var.repository != "" && var.enable_ecr_repository ? var.repository : element(aws_ecr_repository.ecr_repository.*.name, 0)
    policy      = data.template_file.policy.rendered

    depends_on  = [
        aws_ecr_repository.ecr_repository,
        data.template_file.policy
    ]
}

data "template_file" "policy" {
    template    = var.policy_json_file
}