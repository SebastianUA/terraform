#---------------------------------------------------
# AWS ECR repository policy
#---------------------------------------------------
data "template_file" "policy" {
  template = var.ecr_repository_policy
}

resource "aws_ecr_repository_policy" "ecr_repository_policy" {
  count = var.enable_ecr_repository_policy ? 1 : 0

  repository = var.ecr_repository_policy_repository != "" && var.enable_ecr_repository ? var.ecr_repository_policy_repository : element(aws_ecr_repository.ecr_repository.*.name, 0)
  policy     = data.template_file.policy.rendered

  depends_on = [
    aws_ecr_repository.ecr_repository,
    data.template_file.policy
  ]
}
