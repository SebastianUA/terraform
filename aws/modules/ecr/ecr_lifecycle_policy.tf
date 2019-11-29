#---------------------------------------------------
# Create AWS ECR repository 
#---------------------------------------------------
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
    count       = var.enable_ecr_lifecycle_policy ? 1 : 0
    
    repository  = var.repository != "" && var.enable_ecr_repository ? var.repository : element(aws_ecr_repository.ecr_repository.*.name, 0)
    policy      = data.template_file.lifecycle_policy.rendered

    depends_on  = [
        aws_ecr_repository.ecr_repository,
        data.template_file.lifecycle_policy
    ]
}

data "template_file" "lifecycle_policy" {
    template    = var.lifecycle_policy_json_file
}
