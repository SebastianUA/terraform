#---------------------------------------------------
# AWS ECR repository
#---------------------------------------------------
resource "aws_ecr_repository" "ecr_repository" {
  count = var.enable_ecr_repository ? 1 : 0

  name = var.ecr_repository_name != "" ? var.ecr_repository_name : "${lower(var.name)}-ecr-${lower(var.environment)}"

  tags = merge(
    {
      Name = var.ecr_repository_name != "" ? var.ecr_repository_name : "${lower(var.name)}-ecr-${lower(var.environment)}"
    },
    var.tags
  )

  timeouts {
    delete = var.timeouts_delete
  }

  depends_on = []
}
